/***************************************************************************//**
 *   @file   main.c
 *   @brief  TX bring-up at one fixed output level, to verify over the air
 *           (e.g. with a HackRF) that the transmitter really radiates.
 *
 *   TX source (app_config.h, TX_SOURCE):
 *     TX_SRC_PL  : PL tone generator -> util_rfifo -> axi_ad9361 DAC
 *     TX_SRC_DDS : the axi_ad9361 core's own DDS tone (control experiment,
 *                  independent of everything in the PL)
 *   The TX attenuation is set once (APP_TX_ATTEN_MDB) and left alone.
 *   APP_TX_ENABLE = 0 holds the AD9361 in reset instead, so nothing is
 *   transmitted (use it to record a "TX off" reference capture).
 *   No DMA, no Ethernet.
 *
 *   Based on ADI no-OS projects/ad9361/src/main.c (init parameters and FIR
 *   tables unchanged from it).
*******************************************************************************/

/******************************************************************************/
/***************************** Include Files **********************************/
/******************************************************************************/
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include "app_config.h"
#include "parameters.h"
#include "ad9361_api.h"
#include "axi_adc_core.h"
#include "axi_dac_core.h"
#include "no_os_spi.h"
#include "no_os_gpio.h"
#include "no_os_delay.h"
#include "no_os_error.h"
#include "xaxidma.h"
#include "xscugic.h"
#include "xil_exception.h"

#include <xparameters.h>
#include <xil_cache.h>
#include "xilinx_spi.h"
#include "xilinx_gpio.h"

#include "lwip/init.h"
#include "netif/xadapter.h"
#include "lwip/inet.h"
#include "xil_printf.h"
#include "lwip/udp.h"
#include "lwip/etharp.h"
#include "netif/ethernet.h"

//Variable definations:
struct xil_spi_init_param xil_spi_param = {
	.type = SPI_PS,
#ifdef SDT
	.base_addr = SPI_BASEADDR,
#endif
	.flags = 0
};

struct xil_gpio_init_param xil_gpio_param = {
	.type = GPIO_PS,
#ifdef SDT
	.base_addr = GPIO_BASEADDR,
#endif
	.device_id = GPIO_DEVICE_ID
};
//ethernet object
struct netif server_netif;
// global udp protocol control block
struct udp_pcb *udp_pcb_dma;
ip_addr_t pc_ip;

// DMA attributes:
#define RX_PACKET_SAMPLES 1024
#define RX_BYTES_PER_SAMPLE 8  // 64 bit => 8 bytes
#define RX_BUFFER_SIZE (RX_PACKET_SAMPLES * RX_BYTES_PER_SAMPLE) // 8192 bytes
// creation of 64 bit aligned buffer for DDR to have I/Q data:
static uint64_t rx_buffer[RX_PACKET_SAMPLES] __attribute__((aligned(64)));
#define RX_INTR_ID XPAR_FABRIC_RX_TESTBENCH_AXI_DMA_0_S2MM_INTROUT_INTR
// have a DMA instance:
XAxiDma axi_dma;
// Interrupt instance:
XScuGic intc;
volatile int rx_done =0;

#define GPIO_OPS	&xil_gpio_ops
#define SPI_OPS		&xil_spi_ops
#define GPIO_PARAM	&xil_gpio_param
#define SPI_PARAM	&xil_spi_param

/* The ADC core is needed by ad9361_init() for digital interface tuning */
struct axi_adc_init rx_adc_init = {
	.name = "cf-ad9361-lpc",
	.base = RX_CORE_BASEADDR,
	.num_channels = 4,
	.slave_base = 0,
	.num_slave_channels = 0
};

struct axi_dac_init tx_dac_init = {
	.name = "cf-ad9361-dds-core-lpc",
	.base = TX_CORE_BASEADDR,
	.num_channels = 4,
	.channels = NULL,
	.rate = 3
};

AD9361_InitParam default_init_param = {
	/* Device selection */
	ID_AD9361,	// dev_sel
	/* Reference Clock */
	40000000UL,	//reference_clk_rate
	/* Base Configuration */
	1,		//two_rx_two_tx_mode_enable *** adi,2rx-2tx-mode-enable
	1,		//one_rx_one_tx_mode_use_rx_num *** adi,1rx-1tx-mode-use-rx-num
	1,		//one_rx_one_tx_mode_use_tx_num *** adi,1rx-1tx-mode-use-tx-num
	1,		//frequency_division_duplex_mode_enable *** adi,frequency-division-duplex-mode-enable
	0,		//frequency_division_duplex_independent_mode_enable *** adi,frequency-division-duplex-independent-mode-enable
	0,		//tdd_use_dual_synth_mode_enable *** adi,tdd-use-dual-synth-mode-enable
	0,		//tdd_skip_vco_cal_enable *** adi,tdd-skip-vco-cal-enable
	0,		//tx_fastlock_delay_ns *** adi,tx-fastlock-delay-ns
	0,		//rx_fastlock_delay_ns *** adi,rx-fastlock-delay-ns
	0,		//rx_fastlock_pincontrol_enable *** adi,rx-fastlock-pincontrol-enable
	0,		//tx_fastlock_pincontrol_enable *** adi,tx-fastlock-pincontrol-enable
	0,		//external_rx_lo_enable *** adi,external-rx-lo-enable
	0,		//external_tx_lo_enable *** adi,external-tx-lo-enable
	5,		//dc_offset_tracking_update_event_mask *** adi,dc-offset-tracking-update-event-mask
	6,		//dc_offset_attenuation_high_range *** adi,dc-offset-attenuation-high-range
	5,		//dc_offset_attenuation_low_range *** adi,dc-offset-attenuation-low-range
	0x28,	//dc_offset_count_high_range *** adi,dc-offset-count-high-range
	0x32,	//dc_offset_count_low_range *** adi,dc-offset-count-low-range
	0,		//split_gain_table_mode_enable *** adi,split-gain-table-mode-enable
	MAX_SYNTH_FREF,	//trx_synthesizer_target_fref_overwrite_hz *** adi,trx-synthesizer-target-fref-overwrite-hz
	0,		// qec_tracking_slow_mode_enable *** adi,qec-tracking-slow-mode-enable
	/* ENSM Control */
	0,		//ensm_enable_pin_pulse_mode_enable *** adi,ensm-enable-pin-pulse-mode-enable
	0,		//ensm_enable_txnrx_control_enable *** adi,ensm-enable-txnrx-control-enable
	/* LO Control */
	2400000000UL,	//rx_synthesizer_frequency_hz *** adi,rx-synthesizer-frequency-hz
	2400000000UL,	//tx_synthesizer_frequency_hz *** adi,tx-synthesizer-frequency-hz
	1,				//tx_lo_powerdown_managed_enable *** adi,tx-lo-powerdown-managed-enable
	/* Rate & BW Control */
	{983040000, 245760000, 122880000, 61440000, 30720000, 30720000},// rx_path_clock_frequencies[6] *** adi,rx-path-clock-frequencies
	{983040000, 122880000, 122880000, 61440000, 30720000, 30720000},// tx_path_clock_frequencies[6] *** adi,tx-path-clock-frequencies
	18000000,//rf_rx_bandwidth_hz *** adi,rf-rx-bandwidth-hz
	18000000,//rf_tx_bandwidth_hz *** adi,rf-tx-bandwidth-hz
	/* RF Port Control */
	0,		//rx_rf_port_input_select *** adi,rx-rf-port-input-select
	0,		//tx_rf_port_input_select *** adi,tx-rf-port-input-select
	/* TX Attenuation Control */
	10000,	//tx_attenuation_mdB *** adi,tx-attenuation-mdB
	0,		//update_tx_gain_in_alert_enable *** adi,update-tx-gain-in-alert-enable
	/* Reference Clock Control */
	0,		//xo_disable_use_ext_refclk_enable *** adi,xo-disable-use-ext-refclk-enable
	{8, 5920},	//dcxo_coarse_and_fine_tune[2] *** adi,dcxo-coarse-and-fine-tune
	CLKOUT_DISABLE,	//clk_output_mode_select *** adi,clk-output-mode-select
	/* Gain Control */
	2,		//gc_rx1_mode *** adi,gc-rx1-mode
	2,		//gc_rx2_mode *** adi,gc-rx2-mode
	58,		//gc_adc_large_overload_thresh *** adi,gc-adc-large-overload-thresh
	4,		//gc_adc_ovr_sample_size *** adi,gc-adc-ovr-sample-size
	47,		//gc_adc_small_overload_thresh *** adi,gc-adc-small-overload-thresh
	8192,	//gc_dec_pow_measurement_duration *** adi,gc-dec-pow-measurement-duration
	0,		//gc_dig_gain_enable *** adi,gc-dig-gain-enable
	800,	//gc_lmt_overload_high_thresh *** adi,gc-lmt-overload-high-thresh
	704,	//gc_lmt_overload_low_thresh *** adi,gc-lmt-overload-low-thresh
	24,		//gc_low_power_thresh *** adi,gc-low-power-thresh
	15,		//gc_max_dig_gain *** adi,gc-max-dig-gain
	0,		//gc_use_rx_fir_out_for_dec_pwr_meas_enable *** adi,gc-use-rx-fir-out-for-dec-pwr-meas-enable
	/* Gain MGC Control */
	2,		//mgc_dec_gain_step *** adi,mgc-dec-gain-step
	2,		//mgc_inc_gain_step *** adi,mgc-inc-gain-step
	0,		//mgc_rx1_ctrl_inp_enable *** adi,mgc-rx1-ctrl-inp-enable
	0,		//mgc_rx2_ctrl_inp_enable *** adi,mgc-rx2-ctrl-inp-enable
	0,		//mgc_split_table_ctrl_inp_gain_mode *** adi,mgc-split-table-ctrl-inp-gain-mode
	/* Gain AGC Control */
	10,		//agc_adc_large_overload_exceed_counter *** adi,agc-adc-large-overload-exceed-counter
	2,		//agc_adc_large_overload_inc_steps *** adi,agc-adc-large-overload-inc-steps
	0,		//agc_adc_lmt_small_overload_prevent_gain_inc_enable *** adi,agc-adc-lmt-small-overload-prevent-gain-inc-enable
	10,		//agc_adc_small_overload_exceed_counter *** adi,agc-adc-small-overload-exceed-counter
	4,		//agc_dig_gain_step_size *** adi,agc-dig-gain-step-size
	3,		//agc_dig_saturation_exceed_counter *** adi,agc-dig-saturation-exceed-counter
	1000,	// agc_gain_update_interval_us *** adi,agc-gain-update-interval-us
	0,		//agc_immed_gain_change_if_large_adc_overload_enable *** adi,agc-immed-gain-change-if-large-adc-overload-enable
	0,		//agc_immed_gain_change_if_large_lmt_overload_enable *** adi,agc-immed-gain-change-if-large-lmt-overload-enable
	10,		//agc_inner_thresh_high *** adi,agc-inner-thresh-high
	1,		//agc_inner_thresh_high_dec_steps *** adi,agc-inner-thresh-high-dec-steps
	12,		//agc_inner_thresh_low *** adi,agc-inner-thresh-low
	1,		//agc_inner_thresh_low_inc_steps *** adi,agc-inner-thresh-low-inc-steps
	10,		//agc_lmt_overload_large_exceed_counter *** adi,agc-lmt-overload-large-exceed-counter
	2,		//agc_lmt_overload_large_inc_steps *** adi,agc-lmt-overload-large-inc-steps
	10,		//agc_lmt_overload_small_exceed_counter *** adi,agc-lmt-overload-small-exceed-counter
	5,		//agc_outer_thresh_high *** adi,agc-outer-thresh-high
	2,		//agc_outer_thresh_high_dec_steps *** adi,agc-outer-thresh-high-dec-steps
	18,		//agc_outer_thresh_low *** adi,agc-outer-thresh-low
	2,		//agc_outer_thresh_low_inc_steps *** adi,agc-outer-thresh-low-inc-steps
	1,		//agc_attack_delay_extra_margin_us; *** adi,agc-attack-delay-extra-margin-us
	0,		//agc_sync_for_gain_counter_enable *** adi,agc-sync-for-gain-counter-enable
	/* Fast AGC */
	64,		//fagc_dec_pow_measuremnt_duration ***  adi,fagc-dec-pow-measurement-duration
	260,	//fagc_state_wait_time_ns ***  adi,fagc-state-wait-time-ns
	/* Fast AGC - Low Power */
	0,		//fagc_allow_agc_gain_increase ***  adi,fagc-allow-agc-gain-increase-enable
	5,		//fagc_lp_thresh_increment_time ***  adi,fagc-lp-thresh-increment-time
	1,		//fagc_lp_thresh_increment_steps ***  adi,fagc-lp-thresh-increment-steps
	/* Fast AGC - Lock Level (Lock Level is set via slow AGC inner high threshold) */
	1,		//fagc_lock_level_lmt_gain_increase_en ***  adi,fagc-lock-level-lmt-gain-increase-enable
	5,		//fagc_lock_level_gain_increase_upper_limit ***  adi,fagc-lock-level-gain-increase-upper-limit
	/* Fast AGC - Peak Detectors and Final Settling */
	1,		//fagc_lpf_final_settling_steps ***  adi,fagc-lpf-final-settling-steps
	1,		//fagc_lmt_final_settling_steps ***  adi,fagc-lmt-final-settling-steps
	3,		//fagc_final_overrange_count ***  adi,fagc-final-overrange-count
	/* Fast AGC - Final Power Test */
	0,		//fagc_gain_increase_after_gain_lock_en ***  adi,fagc-gain-increase-after-gain-lock-enable
	/* Fast AGC - Unlocking the Gain */
	0,		//fagc_gain_index_type_after_exit_rx_mode ***  adi,fagc-gain-index-type-after-exit-rx-mode
	1,		//fagc_use_last_lock_level_for_set_gain_en ***  adi,fagc-use-last-lock-level-for-set-gain-enable
	1,		//fagc_rst_gla_stronger_sig_thresh_exceeded_en ***  adi,fagc-rst-gla-stronger-sig-thresh-exceeded-enable
	5,		//fagc_optimized_gain_offset ***  adi,fagc-optimized-gain-offset
	10,		//fagc_rst_gla_stronger_sig_thresh_above_ll ***  adi,fagc-rst-gla-stronger-sig-thresh-above-ll
	1,		//fagc_rst_gla_engergy_lost_sig_thresh_exceeded_en ***  adi,fagc-rst-gla-engergy-lost-sig-thresh-exceeded-enable
	1,		//fagc_rst_gla_engergy_lost_goto_optim_gain_en ***  adi,fagc-rst-gla-engergy-lost-goto-optim-gain-enable
	10,		//fagc_rst_gla_engergy_lost_sig_thresh_below_ll ***  adi,fagc-rst-gla-engergy-lost-sig-thresh-below-ll
	8,		//fagc_energy_lost_stronger_sig_gain_lock_exit_cnt ***  adi,fagc-energy-lost-stronger-sig-gain-lock-exit-cnt
	1,		//fagc_rst_gla_large_adc_overload_en ***  adi,fagc-rst-gla-large-adc-overload-enable
	1,		//fagc_rst_gla_large_lmt_overload_en ***  adi,fagc-rst-gla-large-lmt-overload-enable
	0,		//fagc_rst_gla_en_agc_pulled_high_en ***  adi,fagc-rst-gla-en-agc-pulled-high-enable
	0,		//fagc_rst_gla_if_en_agc_pulled_high_mode ***  adi,fagc-rst-gla-if-en-agc-pulled-high-mode
	64,		//fagc_power_measurement_duration_in_state5 ***  adi,fagc-power-measurement-duration-in-state5
	2,		//fagc_large_overload_inc_steps *** adi,fagc-adc-large-overload-inc-steps
	/* RSSI Control */
	1,		//rssi_delay *** adi,rssi-delay
	1000,	//rssi_duration *** adi,rssi-duration
	3,		//rssi_restart_mode *** adi,rssi-restart-mode
	0,		//rssi_unit_is_rx_samples_enable *** adi,rssi-unit-is-rx-samples-enable
	1,		//rssi_wait *** adi,rssi-wait
	/* Aux ADC Control */
	256,	//aux_adc_decimation *** adi,aux-adc-decimation
	40000000UL,	//aux_adc_rate *** adi,aux-adc-rate
	/* AuxDAC Control */
	1,		//aux_dac_manual_mode_enable ***  adi,aux-dac-manual-mode-enable
	0,		//aux_dac1_default_value_mV ***  adi,aux-dac1-default-value-mV
	0,		//aux_dac1_active_in_rx_enable ***  adi,aux-dac1-active-in-rx-enable
	0,		//aux_dac1_active_in_tx_enable ***  adi,aux-dac1-active-in-tx-enable
	0,		//aux_dac1_active_in_alert_enable ***  adi,aux-dac1-active-in-alert-enable
	0,		//aux_dac1_rx_delay_us ***  adi,aux-dac1-rx-delay-us
	0,		//aux_dac1_tx_delay_us ***  adi,aux-dac1-tx-delay-us
	0,		//aux_dac2_default_value_mV ***  adi,aux-dac2-default-value-mV
	0,		//aux_dac2_active_in_rx_enable ***  adi,aux-dac2-active-in-rx-enable
	0,		//aux_dac2_active_in_tx_enable ***  adi,aux-dac2-active-in-tx-enable
	0,		//aux_dac2_active_in_alert_enable ***  adi,aux-dac2-active-in-alert-enable
	0,		//aux_dac2_rx_delay_us ***  adi,aux-dac2-rx-delay-us
	0,		//aux_dac2_tx_delay_us ***  adi,aux-dac2-tx-delay-us
	/* Temperature Sensor Control */
	256,	//temp_sense_decimation *** adi,temp-sense-decimation
	1000,	//temp_sense_measurement_interval_ms *** adi,temp-sense-measurement-interval-ms
	0xCE,	//temp_sense_offset_signed *** adi,temp-sense-offset-signed
	1,		//temp_sense_periodic_measurement_enable *** adi,temp-sense-periodic-measurement-enable
	/* Control Out Setup */
	0xFF,	//ctrl_outs_enable_mask *** adi,ctrl-outs-enable-mask
	0,		//ctrl_outs_index *** adi,ctrl-outs-index
	/* External LNA Control */
	0,		//elna_settling_delay_ns *** adi,elna-settling-delay-ns
	0,		//elna_gain_mdB *** adi,elna-gain-mdB
	0,		//elna_bypass_loss_mdB *** adi,elna-bypass-loss-mdB
	0,		//elna_rx1_gpo0_control_enable *** adi,elna-rx1-gpo0-control-enable
	0,		//elna_rx2_gpo1_control_enable *** adi,elna-rx2-gpo1-control-enable
	0,		//elna_gaintable_all_index_enable *** adi,elna-gaintable-all-index-enable
	/* Digital Interface Control */
	0,		//digital_interface_tune_skip_mode *** adi,digital-interface-tune-skip-mode
	0,		//digital_interface_tune_fir_disable *** adi,digital-interface-tune-fir-disable
	1,		//pp_tx_swap_enable *** adi,pp-tx-swap-enable
	1,		//pp_rx_swap_enable *** adi,pp-rx-swap-enable
	0,		//tx_channel_swap_enable *** adi,tx-channel-swap-enable
	0,		//rx_channel_swap_enable *** adi,rx-channel-swap-enable
	1,		//rx_frame_pulse_mode_enable *** adi,rx-frame-pulse-mode-enable
	0,		//two_t_two_r_timing_enable *** adi,2t2r-timing-enable
	0,		//invert_data_bus_enable *** adi,invert-data-bus-enable
	0,		//invert_data_clk_enable *** adi,invert-data-clk-enable
	0,		//fdd_alt_word_order_enable *** adi,fdd-alt-word-order-enable
	0,		//invert_rx_frame_enable *** adi,invert-rx-frame-enable
	0,		//fdd_rx_rate_2tx_enable *** adi,fdd-rx-rate-2tx-enable
	0,		//swap_ports_enable *** adi,swap-ports-enable
	0,		//single_data_rate_enable *** adi,single-data-rate-enable
	1,		//lvds_mode_enable *** adi,lvds-mode-enable
	0,		//half_duplex_mode_enable *** adi,half-duplex-mode-enable
	0,		//single_port_mode_enable *** adi,single-port-mode-enable
	0,		//full_port_enable *** adi,full-port-enable
	0,		//full_duplex_swap_bits_enable *** adi,full-duplex-swap-bits-enable
	0,		//delay_rx_data *** adi,delay-rx-data
	0,		//rx_data_clock_delay *** adi,rx-data-clock-delay
	4,		//rx_data_delay *** adi,rx-data-delay
	7,		//tx_fb_clock_delay *** adi,tx-fb-clock-delay
	0,		//tx_data_delay *** adi,tx-data-delay
#ifdef ALTERA_PLATFORM
	300,	//lvds_bias_mV *** adi,lvds-bias-mV
#else
	150,	//lvds_bias_mV *** adi,lvds-bias-mV
#endif
	1,		//lvds_rx_onchip_termination_enable *** adi,lvds-rx-onchip-termination-enable
	0,		//rx1rx2_phase_inversion_en *** adi,rx1-rx2-phase-inversion-enable
	0xFF,	//lvds_invert1_control *** adi,lvds-invert1-control
	0x0F,	//lvds_invert2_control *** adi,lvds-invert2-control
	/* GPO Control */
	0,		//gpo_manual_mode_enable *** adi,gpo-manual-mode-enable
	0,		//gpo_manual_mode_enable_mask *** adi,gpo-manual-mode-enable-mask
	0,		//gpo0_inactive_state_high_enable *** adi,gpo0-inactive-state-high-enable
	0,		//gpo1_inactive_state_high_enable *** adi,gpo1-inactive-state-high-enable
	0,		//gpo2_inactive_state_high_enable *** adi,gpo2-inactive-state-high-enable
	0,		//gpo3_inactive_state_high_enable *** adi,gpo3-inactive-state-high-enable
	0,		//gpo0_slave_rx_enable *** adi,gpo0-slave-rx-enable
	0,		//gpo0_slave_tx_enable *** adi,gpo0-slave-tx-enable
	0,		//gpo1_slave_rx_enable *** adi,gpo1-slave-rx-enable
	0,		//gpo1_slave_tx_enable *** adi,gpo1-slave-tx-enable
	0,		//gpo2_slave_rx_enable *** adi,gpo2-slave-rx-enable
	0,		//gpo2_slave_tx_enable *** adi,gpo2-slave-tx-enable
	0,		//gpo3_slave_rx_enable *** adi,gpo3-slave-rx-enable
	0,		//gpo3_slave_tx_enable *** adi,gpo3-slave-tx-enable
	0,		//gpo0_rx_delay_us *** adi,gpo0-rx-delay-us
	0,		//gpo0_tx_delay_us *** adi,gpo0-tx-delay-us
	0,		//gpo1_rx_delay_us *** adi,gpo1-rx-delay-us
	0,		//gpo1_tx_delay_us *** adi,gpo1-tx-delay-us
	0,		//gpo2_rx_delay_us *** adi,gpo2-rx-delay-us
	0,		//gpo2_tx_delay_us *** adi,gpo2-tx-delay-us
	0,		//gpo3_rx_delay_us *** adi,gpo3-rx-delay-us
	0,		//gpo3_tx_delay_us *** adi,gpo3-tx-delay-us
	/* Tx Monitor Control */
	37000,	//low_high_gain_threshold_mdB *** adi,txmon-low-high-thresh
	0,		//low_gain_dB *** adi,txmon-low-gain
	24,		//high_gain_dB *** adi,txmon-high-gain
	0,		//tx_mon_track_en *** adi,txmon-dc-tracking-enable
	0,		//one_shot_mode_en *** adi,txmon-one-shot-mode-enable
	511,	//tx_mon_delay *** adi,txmon-delay
	8192,	//tx_mon_duration *** adi,txmon-duration
	2,		//tx1_mon_front_end_gain *** adi,txmon-1-front-end-gain
	2,		//tx2_mon_front_end_gain *** adi,txmon-2-front-end-gain
	48,		//tx1_mon_lo_cm *** adi,txmon-1-lo-cm
	48,		//tx2_mon_lo_cm *** adi,txmon-2-lo-cm
	/* GPIO definitions */
	{
		.number = -1,
		.platform_ops = GPIO_OPS,
		.extra = GPIO_PARAM
	},		//gpio_resetb *** reset-gpios
	/* MCS Sync */
	{
		.number = -1,
		.platform_ops = GPIO_OPS,
		.extra = GPIO_PARAM
	},		//gpio_sync *** sync-gpios

	{
		.number = -1,
		.platform_ops = GPIO_OPS,
		.extra = GPIO_PARAM
	},		//gpio_cal_sw1 *** cal-sw1-gpios

	{
		.number = -1,
		.platform_ops = GPIO_OPS,
		.extra = GPIO_PARAM
	},		//gpio_cal_sw2 *** cal-sw2-gpios

	{
		.device_id = SPI_DEVICE_ID,
		.mode = NO_OS_SPI_MODE_1,
		.chip_select = SPI_CS,
		.platform_ops = SPI_OPS,
		.extra = SPI_PARAM
	},

	/* External LO clocks */
	NULL,	//(*ad9361_rfpll_ext_recalc_rate)()
	NULL,	//(*ad9361_rfpll_ext_round_rate)()
	NULL,	//(*ad9361_rfpll_ext_set_rate)()
#ifndef AXI_ADC_NOT_PRESENT
	&rx_adc_init,	// *rx_adc_init
	&tx_dac_init,   // *tx_dac_init
#endif
};

AD9361_RXFIRConfig rx_fir_config = {	// BPF PASSBAND 3/20 fs to 1/4 fs
	3, // rx
	0, // rx_gain
	1, // rx_dec
	{
		-4, -6, -37, 35, 186, 86, -284, -315,
			107, 219, -4, 271, 558, -307, -1182, -356,
			658, 157, 207, 1648, 790, -2525, -2553, 748,
			865, -476, 3737, 6560, -3583, -14731, -5278, 14819,
			14819, -5278, -14731, -3583, 6560, 3737, -476, 865,
			748, -2553, -2525, 790, 1648, 207, 157, 658,
			-356, -1182, -307, 558, 271, -4, 219, 107,
			-315, -284, 86, 186, 35, -37, -6, -4,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0
		}, // rx_coef[128]
	64, // rx_coef_size
	{0, 0, 0, 0, 0, 0}, //rx_path_clks[6]
	0 // rx_bandwidth
};

AD9361_TXFIRConfig tx_fir_config = {	// BPF PASSBAND 3/20 fs to 1/4 fs
	3, // tx
	-6, // tx_gain
	1, // tx_int
	{
		-4, -6, -37, 35, 186, 86, -284, -315,
			107, 219, -4, 271, 558, -307, -1182, -356,
			658, 157, 207, 1648, 790, -2525, -2553, 748,
			865, -476, 3737, 6560, -3583, -14731, -5278, 14819,
			14819, -5278, -14731, -3583, 6560, 3737, -476, 865,
			748, -2553, -2525, 790, 1648, 207, 157, 658,
			-356, -1182, -307, 558, 271, -4, 219, 107,
			-315, -284, 86, 186, 35, -37, -6, -4,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0
		}, // tx_coef[128]
	64, // tx_coef_size
	{0, 0, 0, 0, 0, 0}, // tx_path_clks[6]
	0 // tx_bandwidth
};
struct ad9361_rf_phy *ad9361_phy;

/* DDS tone index = (channel * 2) + tone; tone 1 of each of the 4 channels.
 * TX1: I = 0, Q = 2   TX2: I = 4, Q = 6   (same layout as ADI's DDS_CHAN_*) */
#define DDS_TX1_I_F1	0
#define DDS_TX1_Q_F1	2
#define DDS_TX2_I_F1	4
#define DDS_TX2_Q_F1	6

static int32_t tx_source_setup(void)
{
	int32_t status;

#if TX_SOURCE == TX_SRC_DDS
	static const uint8_t i_tone[] = {DDS_TX1_I_F1, DDS_TX2_I_F1};
	static const uint8_t q_tone[] = {DDS_TX1_Q_F1, DDS_TX2_Q_F1};
	unsigned int n;

	status = axi_dac_set_datasel(ad9361_phy->tx_dac, -1, AXI_DAC_DATA_SEL_DDS);
	if (status < 0)
		return status;
	for (n = 0; n < 2; n++) {
		/* complex tone: I at 90 deg, Q at 0 deg, same frequency */
		axi_dac_dds_set_frequency(ad9361_phy->tx_dac, i_tone[n], APP_TX_TONE_HZ);
		axi_dac_dds_set_frequency(ad9361_phy->tx_dac, q_tone[n], APP_TX_TONE_HZ);
		axi_dac_dds_set_phase(ad9361_phy->tx_dac, i_tone[n], 90000);
		axi_dac_dds_set_phase(ad9361_phy->tx_dac, q_tone[n], 0);
		axi_dac_dds_set_scale(ad9361_phy->tx_dac, i_tone[n], APP_TX_DDS_SCALE);
		axi_dac_dds_set_scale(ad9361_phy->tx_dac, q_tone[n], APP_TX_DDS_SCALE);
	}
	printf("TX source: AD9361 core DDS, tone %u Hz above LO\n",
	       (unsigned)APP_TX_TONE_HZ);
#else
	/* CORDIC input: the DAC takes samples from util_rfifo (PL tone) which is sin+cos wave */
	status = axi_dac_set_datasel(ad9361_phy->tx_dac, -1, AXI_DAC_DATA_SEL_DMA);
	if (status < 0)
		return status;
	printf("TX source: PL tone generator via util_rfifo\n");
#endif
	return 0;
}

static int32_t tx_set_attenuation(uint32_t mdb)
{
	uint32_t rb0 = 0, rb1 = 0;
	int32_t st;

	st = ad9361_set_tx_attenuation(ad9361_phy, 0, mdb); // TX1
	if (st < 0)
		return st;
	st = ad9361_set_tx_attenuation(ad9361_phy, 1, mdb);//  TX2
	if (st < 0)
		return st;

	ad9361_get_tx_attenuation(ad9361_phy, 0, &rb0);
	ad9361_get_tx_attenuation(ad9361_phy, 1, &rb1);
	printf("TX attenuation: %"PRIu32".%02"PRIu32" dB (readback TX1 %"PRIu32
	       ", TX2 %"PRIu32" mdB)\n", mdb / 1000, (mdb % 1000) / 10, rb0, rb1);
	return 0;
}
/*
 * The ISR method call is the method which is called once the DMA finishes
 * pushing the 1024 samples and observes the "tlast" flag.
 */
static void rx_dma_isr(void *CallbackRef) {
    XAxiDma *dma_inst = (XAxiDma *)CallbackRef;
    u32 irq_status;

    /* 1. Read the pending interrupt status from the DMA engine */
    irq_status = XAxiDma_IntrGetIrq(dma_inst, XAXIDMA_DEVICE_TO_DMA);

    /* 2. Acknowledge (clear) the interrupt immediately to prevent infinite looping */
    XAxiDma_IntrAckIrq(dma_inst, irq_status, XAXIDMA_DEVICE_TO_DMA);

    /* 3. Check if this is an "Interrupt On Completion" (IOC) event */
    if (irq_status & XAXIDMA_IRQ_IOC_MASK) {
        /* Fulfilling your request to print inside the ISR */
        printf("\n\r[ISR] DMA RX Interrupt Asserted! 1024 Samples Received.\n\r");

        /* 4. Set the flag to release the main loop */
        rx_done = 1;
    }
}
/*
 * the below method initiailizes the Zynq's GIC and wires the DMA to the ISR
 */
int setup_interrupt_system(XAxiDma *dma_inst) {
    int status;
    XScuGic_Config *intc_config;

    /* 1. Look up and initialize the Zynq Interrupt Controller */
    intc_config = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
    status = XScuGic_CfgInitialize(&intc, intc_config, intc_config->CpuBaseAddress);
    if (status != XST_SUCCESS) return status;

    /* 2. Set priority (0xA0) and trigger type (0x3 = rising edge) for the DMA interrupt */
    XScuGic_SetPriorityTriggerType(&intc, RX_INTR_ID, 0xA0, 0x3);

    /* 3. Connect your custom ISR function to the hardware interrupt ID */
    status = XScuGic_Connect(&intc, RX_INTR_ID, (Xil_InterruptHandler)rx_dma_isr, dma_inst);
    if (status != XST_SUCCESS) return status;

    /* 4. Enable the specific interrupt inside the GIC */
    XScuGic_Enable(&intc, RX_INTR_ID);

    /* 5. Enable exception handling in the ARM Cortex-A9 processor */
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
                                 &intc);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}

//ethernet setup function:
int setup_ethernet(void) {
    ip_addr_t ipaddr, netmask, gw;

    /* Define a unique MAC address for your board */
    unsigned char mac_ethernet_address[] = { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

    /* Configure static IP: 192.168.1.10 */
    IP4_ADDR(&ipaddr,  192, 168,   1,  10);
    IP4_ADDR(&netmask, 255, 255, 255,   0);
    IP4_ADDR(&gw,      192, 168,   1,   1);

    /* Initialize the lwIP stack */
    lwip_init();

    /* Add the network interface to lwIP */
    if (!xemac_add(&server_netif, &ipaddr, &netmask, &gw, mac_ethernet_address, XPAR_XEMACPS_0_BASEADDR)) {
        printf("Error adding network interface\n\r");
        return -1;
    }

    /* Set this as the default network interface and bring it up */
    netif_set_default(&server_netif);
    netif_set_up(&server_netif);

    printf("Ethernet Interface UP. Static IP: %s\n\r", ip4addr_ntoa(&server_netif.ip_addr));

    return 0;
}
//creation of udp (setup function)
int setup_udp(void) {
    err_t err;

    IP4_ADDR(&pc_ip, 192, 168, 1, 11);

    udp_pcb_dma = udp_new();
    if (!udp_pcb_dma) return -1;

    err = udp_bind(udp_pcb_dma, IP_ADDR_ANY, 5005);
    if (err != ERR_OK) return -1;

    err = udp_connect(udp_pcb_dma, &pc_ip, 5005);
    if (err != ERR_OK) return -1;

    return 0;
}
/***************************************************************************//**
 * @brief main
*******************************************************************************/
int main(void)
{
    uint64_t tx_lo = 0;
    uint64_t rx_lo = 0;
    int32_t status;
    XAxiDma_Config *dma_config;

    // Enabling the caches
    Xil_ICacheEnable();
    Xil_DCacheEnable();

    default_init_param.spi_param.extra = &xil_spi_param;
    default_init_param.spi_param.platform_ops = &xil_spi_ops;

    // NOTE: GPIO numbers are for the ADRV9361-Z7035 system_top.v
    default_init_param.gpio_resetb.number = GPIO_RESET_PIN;
    default_init_param.gpio_sync.number = 102;
    default_init_param.gpio_cal_sw1.number = -1;
    default_init_param.gpio_cal_sw2.number = -1;

#if APP_TX_ENABLE == 0
    /* TX OFF: hold the AD9361 in reset. Re-running this app with
     * APP_TX_ENABLE = 1 releases it again (ad9361_init pulses reset itself). */
    {
        struct no_os_gpio_desc *rst;

        if (no_os_gpio_get(&rst, &default_init_param.gpio_resetb) == 0 &&
            no_os_gpio_direction_output(rst, NO_OS_GPIO_LOW) == 0)
            printf("TX OFF: AD9361 held in reset, no RF output\n");
        else
            printf("TX OFF FAILED: could not drive the AD9361 reset line\n");
        goto end;
    }
#endif

    default_init_param.tx_attenuation_mdB = APP_TX_ATTEN_MDB;
    default_init_param.tx_synthesizer_frequency_hz = APP_LO_FREQ_HZ;

    /* Instruct the driver to listen to the physical ENSM pins */
        default_init_param.ensm_enable_txnrx_control_enable = 0;
        default_init_param.ensm_enable_pin_pulse_mode_enable = 0;

        /* 1. DECLARE ALL VARIABLES FIRST */
        struct no_os_gpio_init_param enable_init_param = {
            .number = 109, /* EMIO 55 */
            .platform_ops = GPIO_OPS,
            .extra = GPIO_PARAM
        };
        struct no_os_gpio_init_param txnrx_init_param = {
            .number = 110, /* EMIO 56 */
            .platform_ops = GPIO_OPS,
            .extra = GPIO_PARAM
        };
        struct no_os_gpio_init_param clksel_init_param = {
            .number = 108, /* EMIO 54 */
            .platform_ops = GPIO_OPS,
            .extra = GPIO_PARAM
        };

        struct no_os_gpio_desc *gpio_clksel;
        struct no_os_gpio_desc *gpio_enable;
        struct no_os_gpio_desc *gpio_txnrx;

        /* 2. EXECUTE FUNCTIONS AFTER DECLARATIONS */

        /* Obtain control of the GPIOs */
        no_os_gpio_get(&gpio_clksel, &clksel_init_param);
        no_os_gpio_get(&gpio_enable, &enable_init_param);
        no_os_gpio_get(&gpio_txnrx, &txnrx_init_param);

        /* Set direction to output and drive LOW to select the onboard 40MHz TCXO */
        no_os_gpio_direction_output(gpio_clksel, 1);

        /* Set direction to output and initialize low (Alert state) */
        no_os_gpio_direction_output(gpio_enable, 0);
        no_os_gpio_direction_output(gpio_txnrx, 0);

    if (AD9364_DEVICE) {
        default_init_param.dev_sel = ID_AD9364;
        tx_dac_init.num_channels = 2;
        tx_dac_init.rate = 1;
        rx_adc_init.num_channels = 2;
    } else {
        if (!default_init_param.two_rx_two_tx_mode_enable) {
            tx_dac_init.num_channels = 2;
            tx_dac_init.rate = 1;
            rx_adc_init.num_channels = 2;
        }
    }
    if (AD9363A_DEVICE)
        default_init_param.dev_sel = ID_AD9363A;

#ifdef ADI_RF_SOM
    default_init_param.xo_disable_use_ext_refclk_enable = 1;
#endif

    /* Initialization */
    status = ad9361_init(&ad9361_phy, &default_init_param); // the method call which configures the AD9361 using the parameters
    if (status < 0) {
        printf("TX FAILED: ad9361_init returned %"PRIi32"\n", status);
        goto end;
    }

     //fir filter config of ad9361
    ad9361_set_tx_fir_config(ad9361_phy, tx_fir_config);
    ad9361_set_rx_fir_config(ad9361_phy, rx_fir_config);

    // the gain of the rx to be assigned:
    ad9361_set_rx_gain_control_mode(ad9361_phy, 0, RF_GAIN_FASTATTACK_AGC);
    ad9361_set_rx_gain_control_mode(ad9361_phy, 1, RF_GAIN_FASTATTACK_AGC);


    status = axi_dac_init(&ad9361_phy->tx_dac, &tx_dac_init); // tx initialization
    if (status < 0) {
        printf("TX FAILED: axi_dac_init returned %"PRIi32"\n", status);
        goto end;
    }

    status = axi_adc_init(&ad9361_phy->rx_adc, &rx_adc_init); // rx initialization
    if (status != 0) {
        printf("axi_adc_init() failed\n\r");
        return -1;
    }

    status = ad9361_set_tx_lo_freq(ad9361_phy,(uint64_t)2000000000);
        if (status < 0) {
            printf("TX FAILED: ad9361_set_tx_lo_freq returned %"PRIi32"\n", status);
            goto end;
        }
    status = ad9361_set_rx_lo_freq(ad9361_phy,(uint64_t)2000000000);
        if (status < 0) {
                printf("RX FAILED: ad9361_set_rx_lo_freq returned %"PRIi32"\n", status);
                goto end;
            }

        // Set a safe manual hardware gain (e.g., 30 dB) to prevent clipping
            ad9361_set_rx_rf_gain(ad9361_phy, 0, 0);
            ad9361_set_rx_rf_gain(ad9361_phy, 1, 0);

// The initialization of the tx setup and rx setup is done, the transceiver has started transmitting and recieving
    status = tx_source_setup();
    if (status < 0) {
        printf("TX FAILED: could not select the TX source (%"PRIi32")\n", status);
        goto end;
    }

    no_os_mdelay(10);

    ad9361_get_rx_lo_freq(ad9361_phy, &rx_lo);
    ad9361_get_tx_lo_freq(ad9361_phy, &tx_lo);
    printf("The LO's of both Tx and Rx are %" PRIu64 " MHz and %" PRIu64 " MHz respectively.\n",
           (uint64_t)(tx_lo / 1000000ULL),
           (uint64_t)(rx_lo / 1000000ULL));
    status = tx_set_attenuation(APP_TX_ATTEN_MDB);
    if (status < 0) {
        printf("TX FAILED: set attenuation returned %"PRIi32"\n", status);
        goto end;
    }

    /* Force the AD9361 state machine into FDD (Transmit/Receive) mode */
    ad9361_set_en_state_machine_mode(ad9361_phy, ENSM_MODE_FDD);
    no_os_mdelay(500);

    // DMA Startup Code:

    dma_config = XAxiDma_LookupConfig(XPAR_RX_TESTBENCH_AXI_DMA_0_DEVICE_ID);

   if (XAxiDma_CfgInitialize(&axi_dma, dma_config) != XST_SUCCESS) {
            printf("DMA Init Failed!\n\r");
            return -1;
    }


    if (setup_interrupt_system(&axi_dma) != XST_SUCCESS) {
            printf("Interrupt Setup Failed!\n\r");
            return -1;
        }

    if(setup_ethernet() != 0)
    {
    	printf("ETH setup failed!");
    	return -1;
    }
        if(setup_udp() != 0) {
            printf("UDP ain't configured!!");
            return -1;
        }

        XAxiDma_IntrEnable(&axi_dma, XAXIDMA_IRQ_IOC_MASK, XAXIDMA_DEVICE_TO_DMA);

        while(1) {
                /* Keep network alive */
                xemacif_input(&server_netif);

                // 1. Get fresh snapshot from DMA
                rx_done = 0;
                XAxiDma_SimpleTransfer(&axi_dma, (UINTPTR)rx_buffer, RX_BUFFER_SIZE, XAXIDMA_DEVICE_TO_DMA);

                while (!rx_done) {
                    xemacif_input(&server_netif);
                }

                Xil_DCacheInvalidateRange((UINTPTR)rx_buffer, RX_BUFFER_SIZE);

                // 2. Transmit the payload via UDP in chunks
                int chunk_size = 1024;
                int num_chunks = RX_BUFFER_SIZE / chunk_size;

                for (int i = 0; i < num_chunks; i++) {
                    struct pbuf *p = NULL;

                    /* Active Flow Control 1: Wait for memory without freezing the CPU */
                    while (p == NULL) {
                        p = pbuf_alloc(PBUF_TRANSPORT, chunk_size, PBUF_POOL);
                        if (p == NULL) {
                            xemacif_input(&server_netif); // Process network while waiting
                        }
                    }

                    memcpy(p->payload, (uint8_t *)rx_buffer + (i * chunk_size), chunk_size);

                    /* Active Flow Control 2: If TX hardware ring is full (ERR_MEM), keep trying */
                    err_t err = udp_send(udp_pcb_dma, p);
                    while (err == ERR_MEM) {
                        xemacif_input(&server_netif); // Force MAC to drain the TX ring
                        err = udp_send(udp_pcb_dma, p);
                    }

                    pbuf_free(p);

                    /* Give the MAC a quick cycle to push the packet to the wire */
                    xemacif_input(&server_netif);
                }
            }
   //       2. Dump the whole buffer as CSV via UART without delays
         for(int i = 0; i < RX_PACKET_SAMPLES; i++) {
             uint16_t i0 = (rx_buffer[i] >> 0)  & 0xFFFF;
             uint16_t q0 = (rx_buffer[i] >> 16) & 0xFFFF;

             // Output format: I,Q (easy for Python to split by comma)
             printf("%d,%d\n", (int16_t)i0, (int16_t)q0);
         }

         int chunk_size = 1024;
                 int num_chunks = RX_BUFFER_SIZE / chunk_size;

                 for (int i = 0; i < num_chunks; i++) {
                     struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, chunk_size, PBUF_RAM);
                     if (p != NULL) {
                         memcpy(p->payload, (uint8_t *)rx_buffer + (i * chunk_size), chunk_size);

                         err_t send_err = udp_send(udp_pcb_dma, p);
                         if (send_err != ERR_OK) {
                             /* Print the specific error code */
                             printf("udp_send failed! Error: %d\n\r", send_err);
                         }

                         pbuf_free(p);
                     } else {
                         printf("Failed to allocate pbuf!\n\r");
                     }
                 }

#ifdef DEBUG_TX
    {
        uint32_t ensm = 0xFF;
        uint64_t rx_lo = 0;

        ad9361_get_en_state_machine_mode(ad9361_phy, &ensm);
        ad9361_get_rx_lo_freq(ad9361_phy, &rx_lo);
        ad9361_get_tx_lo_freq(ad9361_phy, &tx_lo);
        printf("DEBUG_TX: ENSM mode %"PRIu32" (%d = FDD), RX LO %"PRIu32
               " MHz, TX LO %"PRIu32" MHz\n", ensm, (int)ENSM_MODE_FDD,
               (uint32_t)(rx_lo / 1000000ULL), (uint32_t)(tx_lo / 1000000ULL));
    }
#endif

end:
    /* Leave the transmitter running; do not return to the BSP exit path */
    while (1)
        ;

    return 0;
}
