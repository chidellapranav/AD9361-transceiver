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
#define APP_LO_FREQ_HZ			((uint64_t)2000000000)	/* 2.0 GHz default LO */
#define APP_SAMPLE_RATE_HZ		30720000UL		/* 30.72 MSPS baseband sample rate */
#define APP_RF_BW_HZ			18000000UL		/* 18 MHz analog RF filter bandwidth */

/* ---------------- TX verification (HackRF / spectrum analyser) -------------
 * TX_SOURCE selects what the DAC transmits:
 *   TX_SRC_PL  : PL QPSK TTC Modulator (tx_modem_burst -> util_rfifo -> DAC)
 *   TX_SRC_DDS : AD9361 core's own DDS tone (control experiment)            */
#define APP_TX_ENABLE			1

#define TX_SRC_PL			0
#define TX_SRC_DDS			1
#define TX_SOURCE			TX_SRC_PL
#define APP_TX_TONE_HZ			1000000

/* Fixed TX level. AD9361 attenuation range is 0 .. 89750 mdB in 0.25 dB steps;
 * 10000 mdB = 10.0 dB attenuation (safe level for spectral purity without compression). */
#define APP_TX_ATTEN_MDB		10000	/* 10.00 dB attenuation */

/* DDS amplitude (TX_SRC_DDS only), 1000000 = full scale. 500000 = -6 dBFS,
 * which matches the CORDIC amplitude of the PL tone (1.0 = 16384 of 32768). */
#define APP_TX_DDS_SCALE		500000

#endif /* CONFIG_H_ */
