/***************************************************************************//**
 *   @file   parameters.h
 *   @brief  Hardware parameters: AD9361 init + TX, TX-capture DMA, network.
 *
 *   Block design "system" (Zynq PS7):
 *     axi_ad9361   ADI AD9361 core   RX @ base, TX @ base + 0x4000
 *     TX path      tone gen -> util_rfifo -> axi_ad9361 DAC   (unchanged)
 *     Capture tap  tone gen -> tx_iq_pack -> axi_dma_1 (S2MM) -> HP0 -> DDR
 *     SPI0 (EMIO, CS0 = AD9361), GPIO EMIO 64 bits
 *
 *   GPIO numbering follows ADI adrv9361z7035 system_top.v:
 *     resetb = EMIO 46, up_enable = gpio_o[47], up_txnrx = gpio_o[48].
 *   EMIO pin number = 54 + bit index.
*******************************************************************************/
#ifndef __PARAMETERS_H__
#define __PARAMETERS_H__

#include "app_config.h"

#ifdef XILINX_PLATFORM
#include <xparameters.h>

/* ------------------------------ AD9361 core ------------------------------ */
#ifdef XPAR_AXI_AD9361_0_BASEADDR
#define AD9361_BASEADDR			XPAR_AXI_AD9361_0_BASEADDR
#else
#define AD9361_BASEADDR			XPAR_AXI_AD9361_BASEADDR
#endif
#define AD9361_RX_0_BASEADDR		(AD9361_BASEADDR)
#define AD9361_TX_0_BASEADDR		(AD9361_BASEADDR + 0x4000)
#define RX_CORE_BASEADDR		AD9361_RX_0_BASEADDR
#define TX_CORE_BASEADDR		AD9361_TX_0_BASEADDR

///* -------------------- TX capture DMA (axi_dma_1, S2MM only) --------------
// * Taps tx_iq_pack (parallel with util_rfifo) and writes packed samples into
// * a DDR buffer. TX_CAP_PACKET_LEN below MUST match the PACKET_LEN parameter
// * set on tx_iq_pack_0 in the block design (default 16384).                 */
//#define TX_CAP_DMA_BASEADDR		XPAR_AXI_DMA_1_BASEADDR	/* 0x40410000 */
//#ifndef SDT
//#define TX_CAP_DMA_DEVICE_ID		XPAR_AXI_DMA_1_DEVICE_ID
//#endif
//#ifdef XPAR_FABRIC_AXI_DMA_1_S2MM_INTROUT_INTR
//#define TX_CAP_DMA_IRQ_ID		XPAR_FABRIC_AXI_DMA_1_S2MM_INTROUT_INTR
//#else
//#define TX_CAP_DMA_IRQ_ID		90	/* sys_concat_intc In14 */
//#endif
//
//#define TX_CAP_PACKET_LEN		16384U	/* samples/beats per capture -- must match PL */
//#define TX_CAP_BYTES_PER_SAMPLE		8U	/* {q1,i1,q0,i0} packed 64-bit */
//#define TX_CAP_BYTES			(TX_CAP_PACKET_LEN * TX_CAP_BYTES_PER_SAMPLE)

/* ------------------------------ PS7 GPIO --------------------------------- */
#ifdef SDT
#define GPIO_BASEADDR			XPAR_XGPIOPS_0_BASEADDR
#define GPIO_DEVICE_ID			0
#else
#define GPIO_DEVICE_ID			XPAR_PS7_GPIO_0_DEVICE_ID
#endif
#define GPIO_OFFSET			54
#define GPIO_RESET_PIN			101	/*  */

/* ------------------------------ PS7 SPI0 --------------------------------- */
#ifdef SDT
#define SPI_BASEADDR			XPAR_XSPIPS_0_BASEADDR
#define SPI_DEVICE_ID			0
#else
#define SPI_DEVICE_ID			XPAR_PS7_SPI_0_DEVICE_ID
#endif
#define SPI_CS				0

#endif /* XILINX_PLATFORM */

/* ------------------------------ Network (lwIP) ---------------------------
 * ASSUMED defaults -- change here if your bench uses different addressing.
 * Board: static IP, no DHCP. Server: PC listening for raw UDP IQ packets.  */
#define NET_BOARD_IP0	192
#define NET_BOARD_IP1	168
#define NET_BOARD_IP2	1
#define NET_BOARD_IP3	10

#define NET_GATEWAY_IP0	192
#define NET_GATEWAY_IP1	168
#define NET_GATEWAY_IP2	1
#define NET_GATEWAY_IP3	1

#define NET_NETMASK0	255
#define NET_NETMASK1	255
#define NET_NETMASK2	255
#define NET_NETMASK3	0

#define NET_SERVER_IP0	192
#define NET_SERVER_IP1	168
#define NET_SERVER_IP2	1
#define NET_SERVER_IP3	100

#define NET_SERVER_UDP_PORT	5005

#endif /* __PARAMETERS_H__ */
