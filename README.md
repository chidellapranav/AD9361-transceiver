# AD9361 SDR Transceiver — PL-Centric QPSK Modulator for TTC

[![Board](https://img.shields.io/badge/Board-ADRV9361--Z7035-blue.svg)](https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/adrv9361-z7035.html)
[![FPGA](https://img.shields.io/badge/FPGA-Xilinx%20Zynq--7000%20XC7Z035-orange.svg)](https://www.xilinx.com/products/silicon-devices/soc/zynq-7000.html)
[![RF Transceiver](https://img.shields.io/badge/Transceiver-Analog%20Devices%20AD9361-green.svg)](https://www.analog.com/en/products/ad9361.html)
[![Standard](https://img.shields.io/badge/Standard-CCSDS%20TTC%20Telemetry-purple.svg)](https://public.ccsds.org/)
[![Toolchain](https://img.shields.io/badge/Vivado%20%7C%20Vitis-2022.2-red.svg)](https://www.xilinx.com/support/download.html)

A professional, high-performance **Software-Defined Radio (SDR)** transceiver reference design for the **Analog Devices ADRV9361-Z7035** System-on-Module (SOM). 

This design features an autonomous, hardware-accelerated **QPSK (Quadrature Phase Shift Keying) transmitter** compliant with space-standard **Telemetry, Tracking, and Command (TTC)** architectures. All baseband processing (framing, scrambling, error control, symbol mapping, and polyphase pulse-shaping) is implemented entirely in **Programmable Logic (PL)**, requiring minimal supervision from the ARM Processing System (PS).

---

## Table of Contents
- [1. System Architecture](#1-system-architecture)
- [2. PL Baseband Processing Pipeline](#2-pl-baseband-processing-pipeline)
- [3. RF & Link Budget Specifications](#3-rf--link-budget-specifications)
- [4. Repository Structure](#4-repository-structure)
- [5. Module Description](#5-module-description)
- [6. Processing System (PS) Firmware](#6-processing-system-ps-firmware)
- [7. Vivado TCL Automation & Build Flow](#7-vivado-tcl-automation--build-flow)
- [8. Hardware Verification & Host Analysis](#8-hardware-verification--host-analysis)
- [9. License](#9-license)

---

## 1. System Architecture

The design partitions functionality to maximize throughput, determinism, and software simplicity:

- **Processing System (PS - Dual ARM Cortex-A9)**:
  - Configures the AD9361 RFIC via SPI using the official Analog Devices `no-OS` driver.
  - Controls radio parameters (carrier frequency, bandwidth, attenuation, ENSM state machine).
  - Routes DAC baseband input to the PL FIFO (`AXI_DAC_DATA_SEL_DMA`).
  - Receives live RX ADC samples via AXI DMA (S2MM) and streams them over Ethernet UDP (port 5005) for host-side spectral and constellation inspection.
- **Programmable Logic (PL - Xilinx XC7Z035 FPGA Fabric)**:
  - Generates telemetry packets, computes CRC, randomizes with CCSDS LFSR, applies convolutional FEC coding, attaches synchronization markers, maps to QPSK symbols, and pulse-shapes via a 33-tap polyphase Root-Raised Cosine (RRC) filter.
  - Buffers shaped bursts in block RAM and streams them directly into the AD9361 DAC FIFO (`util_rfifo_0`) at the native 30.72 MHz baseband clock.

```
+-----------------------------------------------------------------------------------+
|                            ZYNQ-7000 XC7Z035 SOC                                  |
|                                                                                   |
|  +------------------------+                     +-------------------------------+ |
|  |     PS (Cortex-A9)     |                     |    PL (Programmable Logic)    | |
|  |                        |                     |                               | |
|  |  [AD9361 no-OS Init]   |                     |  [Autonomous TTC QPSK Mod]    | |
|  |  - SPI / GPIO Control  |--- EMIO / SPI ----->|  - Payload Generator          | |
|  |  - LO: 2.0 GHz         |                     |  - CRC-32 + Scrambler         | |
|  |  - DAC DataSel = DMA   |                     |  - Rate 1/2 K=7 Conv Encoder  | |
|  |                        |                     |  - CCSDS ASM 0x1ACFFC1D Frame | |
|  |  [RX Ethernet Bridge]  |                     |  - QPSK Mapper (+/-8192)      | |
|  |  - AXI DMA Driver      |<--- HP0 (DDR) ------|  - 33-Tap Polyphase RRC (4x)  | |
|  |  - lwIP UDP Streamer   |<--- AXI Stream -----|  - Burst Buffer & Sequencer   | |
|  +------------------------+                     +---------------+---------------+ |
|             | (Ethernet)                                        | (16-bit I/Q)    |
|             v                                                   v                 |
|       Host PC Analyzer                             +----------------------------+ |
|                                                    |      util_rfifo_0 / DAC    | |
+----------------------------------------------------+--------------+-------------+-+
                                                                    | (LVDS)
                                                                    v
                                                     +----------------------------+
                                                     |    AD9361 RF Transceiver   |
                                                     |  - Dual TX / Dual RX       |
                                                     |  - RF Output: 2.0 GHz      |
                                                     +----------------------------+
```

---

## 2. PL Baseband Processing Pipeline

The PL transmit processing path executes sequentially through the following pipeline:

```
[Payload Generator] (16 bytes test telemetry: 0x00..0x0F)
        |
        v
[CRC-32 Appender]   (ISO-HDLC / Ethernet standard poly 0xEDB88320)
        |
        v
[Packet Scrambler]  (CCSDS 7-bit LFSR: x^7 + x^4 + 1, seed 7'b1111111)
        |
        v
[Conv Encoder]      (CCSDS Rate 1/2, K=7, G1=171o, G2=133o + 6-bit zero tail)
        |
        v
[Frame Assembler]   (32 QPSK symb Preamble + 16 symb ASM 0x1ACFFC1D + 32 symb Hdr + Body)
        |
        v
[QPSK Mapper]       (Bit pairs -> Constellation points: +/-8192 I / +/-8192 Q)
        |
        v
[RRC Interpolator]  (33-tap Polyphase Root Raised Cosine, 4x upsampling, alpha=0.35)
        |
        v
[tx_modem_burst]    (2048-Sample BRAM storage, gap sequencer, clean sample-by-sample output)
        |
        v
[util_rfifo_0]      (16-bit signed tx_i, tx_q into AD9361 DAC at 30.72 MHz)
```

---

## 3. RF & Link Budget Specifications

| Parameter | Specification | Notes |
| :--- | :--- | :--- |
| **RF Carrier (LO)** | 2.000 GHz | Configurable via `APP_LO_FREQ_HZ` in `app_config.h` |
| **Baseband Sample Rate** | 30.72 MSPS | Generated by `clock_divider_0` from `l_clk` |
| **Interpolation Factor** | 4 samples / symbol | Implemented inside `rrc_interpolator.v` |
| **Symbol Rate ($R_s$)** | 7.68 Msps | $30.72\text{ MSPS} / 4$ |
| **Coded Channel Bitrate** | 15.36 Mbps | 2 bits/symbol (QPSK) |
| **Information Bitrate** | 7.68 Mbps | Rate 1/2 Convolutional FEC |
| **Pulse-Shaping Filter** | Root-Raised Cosine (RRC) | 33 taps, 4-phase polyphase, roll-off $\alpha = 0.35$ |
| **Occupied Bandwidth** | ~10.37 MHz | $B = R_s \times (1 + \alpha) = 7.68 \times 1.35$ |
| **Frame Synchronization** | `0x1ACFFC1D` | Standard 32-bit CCSDS Attached Sync Marker (ASM) |
| **Burst Profile** | 1013 samples (~33 µs) | Periodic burst with 10 ms idle gap (`GAP_CYCLES = 307200`) |
| **TX Attenuation** | 10.00 dB | Configurable via `APP_TX_ATTEN_MDB` (prevents analog saturation) |

---

## 4. Repository Structure

```
D:/AD9361/AD9361-transceiver/
├── README.md                                # This documentation
├── .gitignore                               # Git ignore configuration
│
├── Project/
│   ├── vivado/
│   │   ├── AD9361.xpr                       # Vivado project file
│   │   ├── AD9361.srcs/
│   │   │   ├── sources_1/
│   │   │   │   ├── bd/system_top/           # Block design (system_top.bd)
│   │   │   │   ├── new/                     # QPSK TTC RTL source files
│   │   │   │   │   ├── conv_encoder.v       # Rate 1/2 K=7 convolutional encoder
│   │   │   │   │   ├── frame_assembler.v    # ASM & header assembler
│   │   │   │   │   ├── packet_scrambler.v   # CCSDS LFSR scrambler
│   │   │   │   │   ├── qpsk_mapper.v        # QPSK symbol mapper
│   │   │   │   │   ├── rrc_interpolator.v   # 33-tap polyphase RRC filter
│   │   │   │   │   ├── tx_coded_top.v       # FEC + Scrambler integration
│   │   │   │   │   ├── tx_qpsk_top.v        # Framing + Mapping integration
│   │   │   │   │   ├── tx_rrc_top.v         # Pulse-shaping wrapper
│   │   │   │   │   └── tx_modem_burst.v     # Burst sequencer and BRAM manager
│   │   │   │   └── imports/
│   │   │   │       ├── new/                 # IO and packaging helpers
│   │   │   │       │   ├── ad9361_io_manager.v
│   │   │   │       │   ├── clock_divider.v
│   │   │   │       │   └── custom_pack.v
│   │   │   │       └── tx_crc_step1/        # CRC and payload generator
│   │   │   │           ├── crc32_append.v
│   │   │   │           ├── payload_generator.v
│   │   │   │           └── tx_payload_crc_top.v
│   │   │   ├── constrs_1/                   # Constraints
│   │   │   │   ├── ad9361_constr.xdc        # AD9361 LVDS differential constraints
│   │   │   │   └── ps_constr.xdc            # SPI and GPIO pin allocations
│   │   │   └── sim_1/new/                   # Testbenches
│   │   │       ├── tb_conv_encoder.v
│   │   │       ├── tb_qpsk_mapper.v
│   │   │       ├── tb_rrc_interpolator.v
│   │   │       ├── tb_tx_coded.v
│   │   │       ├── tb_tx_frame.v
│   │   │       ├── tb_tx_modem_burst.v
│   │   │       └── tb_tx_rrc.v
│   │   └── scripts/                         # TCL Automation Scripts
│   │       ├── update_tx_qpsk_bd.tcl        # Upgrades system_top.bd to QPSK
│   │       ├── build_bitstream.tcl          # Synth, impl, bitstream & XSA export
│   │       ├── run_all.tcl                  # Complete one-click pipeline
│   │       └── sim_tx_modem_burst.tcl       # XSim behavioral simulation
│   │
│   └── vitis/
│       ├── adrv/                            # Hardware platform workspace
│       └── core0_tx/src/                    # Baremetal application code
│           ├── app_config.h                 # RF and TX source configuration
│           ├── parameters.h                 # Memory maps, IRQ, IP addresses
│           └── main.c                       # Transceiver init & RX UDP streamer
│
└── test/
    ├── qpsk_receiver_analyzer.py            # Real-time Python GUI/CLI analyzer
    ├── ethernet_capture_.py                 # Static UDP capture and FFT
    └── ethernet_capture_live.py             # Live animation time/FFT viewer
```

---

## 5. Module Description

| Module Name | Purpose / Standard | Inputs | Outputs |
| :--- | :--- | :--- | :--- |
| `payload_generator.v` | Produces test telemetry payload (counting pattern). | `clk, resetn, start` | AXI-Stream `[7:0]`, `busy, done` |
| `crc32_append.v` | Computes ISO-HDLC / Ethernet CRC-32 (`0xEDB88320`) and appends 4 bytes. | AXI-Stream `[7:0]` | AXI-Stream `[7:0]`, `packet_done` |
| `packet_scrambler.v` | CCSDS LFSR randomization ($x^7+x^4+1$, seed `7'b1111111`). | AXI-Stream `[7:0]` | AXI-Stream `[7:0]` |
| `conv_encoder.v` | Rate 1/2, $K=7$ ($G_1=171_8, G_2=133_8$) with 6-bit trellis tail flushing. | AXI-Stream `[7:0]` | AXI-Stream `[1:0]` (coded pair) |
| `frame_assembler.v` | Attaches 32-symb preamble, 16-symb CCSDS ASM (`0x1ACFFC1D`), 32-symb header with CRC-16. | AXI-Stream `[1:0]` | AXI-Stream `[1:0]` (frame stream) |
| `qpsk_mapper.v` | Maps symbol pairs $(b_1, b_0)$ to fixed-point amplitudes ($\pm 8192$). | AXI-Stream `[1:0]` | AXI-Stream `[31:0]` (`{Q, I}`) |
| `rrc_interpolator.v` | 33-tap polyphase Root Raised Cosine filter (4x oversampling, $\alpha = 0.35$). | AXI-Stream `[31:0]` | AXI-Stream `[31:0]` (`{Q, I}`) |
| `tx_modem_burst.v` | BRAM storage (2048 samples), playback sequencer, inter-burst gap timer. | `clk, resetn, enable` | Signed 16-bit `tx_i, tx_q`, `tx_valid` |

---

## 6. Processing System (PS) Firmware

The baremetal application resides in `Project/vitis/core0_tx/src/`:

- **Configuration (`app_config.h`)**:
  ```c
  #define APP_LO_FREQ_HZ        ((uint64_t)2000000000)  /* 2.0 GHz carrier */
  #define APP_SAMPLE_RATE_HZ    30720000UL              /* 30.72 MSPS baseband */
  #define APP_RF_BW_HZ          18000000UL              /* 18 MHz analog filter */
  #define TX_SOURCE             TX_SRC_PL               /* PL Modulator active */
  #define APP_TX_ATTEN_MDB      10000                   /* 10 dB attenuation */
  ```
- **Transmitter Enable (`main.c`)**:
  ```c
  /* Connect AD9361 DAC core to PL FIFO */
  status = axi_dac_set_datasel(ad9361_phy->tx_dac, -1, AXI_DAC_DATA_SEL_DMA);
  printf("TX source: PL QPSK TTC Modulator via util_rfifo\n");
  ```
- **RX DMA & UDP Streamer**:
  Continuous loop captures 1024 64-bit RX samples into DDR using AXI DMA S2MM and broadcasts them over UDP port 5005 to `192.168.1.11` for real-time constellation analysis.

---

## 7. Vivado TCL Automation & Build Flow

All block design upgrades and compilation steps are automated via scripts in `Project/vivado/scripts/`.

### Option A: Complete One-Click Build
Launch Vivado in batch mode:
```bash
cd D:/AD9361/AD9361-transceiver/Project/vivado
vivado -mode batch -source scripts/run_all.tcl
```
*This updates `system_top.bd`, runs synthesis and implementation, generates the bitstream, and exports `system_qpsk_top.xsa`.*

### Option B: Step-by-Step Execution
1. **Update Block Design Only**:
   ```bash
   vivado -mode batch -source scripts/update_tx_qpsk_bd.tcl
   ```
2. **Launch Behavioral Simulation**:
   ```bash
   vivado -mode batch -source scripts/sim_tx_modem_burst.tcl
   ```
3. **Compile Bitstream & Export Hardware**:
   ```bash
   vivado -mode batch -source scripts/build_bitstream.tcl
   ```

---

## 8. Hardware Verification & Host Analysis

A Python visualization and diagnostic tool is provided in `test/qpsk_receiver_analyzer.py`.

### Prerequisites
```bash
pip install numpy scipy matplotlib
```

### Running Live Capture & Analysis
Connect the PC's Ethernet port to the ADRV9361 board (configure host PC to static IP `192.168.1.11`, netmask `255.255.255.0`):
```bash
python test/qpsk_receiver_analyzer.py --port 5005 --samples 32768
```

### Analyzer Displays:
1. **Time-Domain Waveform**: Real-time I and Q waveforms showing the shaped bursts and silent inter-burst gaps.
2. **Power Spectral Density (PSD)**: Welch spectrum overlaid with the theoretical 10.37 MHz RRC bandwidth boundary ($\alpha = 0.35$).
3. **Constellation Diagram**: Downsampled 4-quadrant constellation display showing cluster sharpness and EVM.
4. **Burst Envelope & Duty Cycle**: Time-resolved magnitude $|I + jQ|$ verifying the 10 ms gap interval.

---

## 9. License

This project is licensed under the Apache License 2.0. Base transceiver drivers and HDL reference components are copyright Analog Devices, Inc. and Xilinx, Inc.
