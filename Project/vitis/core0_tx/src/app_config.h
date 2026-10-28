/***************************************************************************//**
 *   @file   app_config.h
 *   @brief  Build configuration: AD9361 init + TX, tx_iq_pack capture -> UDP.
*******************************************************************************/
#ifndef CONFIG_H_
#define CONFIG_H_

/* ---------------- Device selection (read by the ad9361 driver) ------------ */
#define HAVE_SPLIT_GAIN_TABLE		1
#define AD9361_DEVICE			1
#define AD9364_DEVICE			0
#define AD9363A_DEVICE			0

/* ---------------- Platform ------------------------------------------------ */
#ifndef XILINX_PLATFORM
#define XILINX_PLATFORM
#endif
#define ADI_RF_SOM			/* ADRV9361-Z7035: LVDS, external 40 MHz TCXO */

/* ---------------- Driver messages ---------------------------------------- */
#define HAVE_VERBOSE_MESSAGES
//#define HAVE_DEBUG_MESSAGES		/* leave off -- floods the console */

/* ---------------- Application debug prints (main.c) -----------------------
 * Uncomment to print "DEBUG_TX: success" once axi_dac_set_datasel() confirms
 * the DAC is taking samples from the PL (tx_iq_pack -> util_rfifo). Leave
 * commented out for normal runs -- keep debug prints minimal, not a flood. */
#define DEBUG_TX

/* One-line probe of axi_dma_1: writes Run/Stop directly and prints whether it
 * latched and whether the channel left HALTED. Use to tell a clock/reset
 * problem in the DMA from a problem further down the stream path. */
//#define DEBUG_DMA

/* ---------------- AD9361 / TX settings ------------------------------------ */
#define APP_LO_FREQ_HZ ((uint64_t)2400000000)
#define APP_SAMPLE_RATE_HZ		30720000UL
#define APP_RF_BW_HZ			18000000UL


/* ---------------- TX verification (HackRF / spectrum analyser) -------------
 * TX_SOURCE selects what the DAC transmits:
 *   TX_SRC_PL  : your PL tone generator (tone -> util_rfifo -> DAC)
 *   TX_SRC_DDS : AD9361 core's own DDS, APP_TX_TONE_HZ above the LO
 *                (control experiment: does the TX analog path + antenna work,
 *                 independent of the PL?)                                   */
/* 1 = transmit. 0 = TX OFF: AD9361 is held in reset (no RF output at all),
 * for recording a reference capture. Rebuild and re-run to switch. */
#define APP_TX_ENABLE			1

#define TX_SRC_PL			0
#define TX_SRC_DDS			1
#define TX_SOURCE			TX_SRC_PL
#define APP_TX_TONE_HZ			1000000

/* Fixed TX level. AD9361 attenuation range is 0 .. 89750 mdB in 0.25 dB steps;
 * output power falls 1 dB per 1 dB of attenuation.
 * Target: about -20 dBm at the TX port (10 dB pad -> about -30 dBm at the HackRF).
 * 20 dB is an ESTIMATE (see notes: assumes about +1 dBm at 0 dB attenuation for a
 * -6 dBFS tone). Measure the real level and trim this value by the difference. */
#define APP_TX_ATTEN_MDB		40000	/* 20.00 dB */

/* DDS amplitude (TX_SRC_DDS only), 1000000 = full scale. 500000 = -6 dBFS,
 * which matches the CORDIC amplitude of the PL tone (1.0 = 16384 of 32768). */
#define APP_TX_DDS_SCALE		500000

#endif /* CONFIG_H_ */
