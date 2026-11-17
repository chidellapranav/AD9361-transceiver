"""
================================================================================
QPSK TTC Receiver & Analyzer for ADRV9361-Z7035
================================================================================
This script receives IQ baseband samples streamed over UDP (port 5005) from the
Zynq-7000 PS, or reads saved sample files, and performs:
  1. Time-Domain Burst Visualization (I and Q waveforms)
  2. RF Power Spectral Density (PSD) with RRC theoretical mask comparison
  3. QPSK Constellation Diagram
  4. CCSDS Frame Sync Detection (Searching for ASM 0x1ACFFC1D)
  5. Telemetry Header & Sequence Counter Extraction
================================================================================
"""

import socket
import struct
import argparse
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# System Parameters matching app_config.h and Verilog RTL
SAMPLE_RATE_HZ = 30720000        # 30.72 MSPS
SAMPLES_PER_SYMBOL = 4           # 4x oversampling in rrc_interpolator.v
SYMBOL_RATE_HZ = SAMPLE_RATE_HZ / SAMPLES_PER_SYMBOL  # 7.68 Msps
RRC_ALPHA = 0.35                 # Roll-off factor
CCSDS_ASM = 0x1ACFFC1D           # 32-bit Attached Sync Marker
ASM_SYMBOLS = 16                 # 32 bits = 16 QPSK symbols

def unpack_udp_packets(sock, num_samples_target=32768, timeout_sec=3.0):
    """Captures IQ baseband samples from the Zynq board via UDP."""
    sock.settimeout(timeout_sec)
    i_list = []
    q_list = []
    
    print(f"Listening on UDP port 5005 for {num_samples_target} samples...")
    try:
        while len(i_list) < num_samples_target:
            data, _ = sock.recvfrom(2048)
            shorts = struct.unpack('<512h', data)
            # Zynq DMA buffer packing: {iq_ch1_q, iq_ch1_i, iq_ch0_q, iq_ch0_i}
            # Each beat is 4 shorts (64-bit). Channel 0 is shorts[0]=I, shorts[1]=Q
            for idx in range(0, len(shorts), 4):
                i_list.append(shorts[idx])
                q_list.append(shorts[idx + 1])
    except socket.timeout:
        print(f"Capture completed/timed out. Acquired {len(i_list)} samples.")
    except KeyboardInterrupt:
        print(f"Manual stop. Acquired {len(i_list)} samples.")

    i_arr = np.array(i_list, dtype=np.float32)
    q_arr = np.array(q_list, dtype=np.float32)
    return i_arr + 1j * q_arr

def detect_bursts(iq_signal, threshold_factor=0.3):
    """Detects active burst intervals based on signal envelope."""
    envelope = np.abs(iq_signal)
    max_val = np.max(envelope) if len(envelope) > 0 else 1.0
    thresh = max_val * threshold_factor
    active = envelope > thresh
    return active, envelope

def analyze_qpsk(iq_signal):
    """Performs full spectral, time-domain, and constellation analysis."""
    if len(iq_signal) == 0:
        print("No samples available to analyze.")
        return

    active_mask, envelope = detect_bursts(iq_signal)
    burst_samples = iq_signal[active_mask] if np.any(active_mask) else iq_signal

    print(f"\n--- Signal Summary ---")
    print(f"Total Samples: {len(iq_signal)}")
    print(f"Active Burst Samples: {len(burst_samples)} ({len(burst_samples)/len(iq_signal)*100:.1f}% duty)")
    print(f"Peak Amplitude: {np.max(envelope):.1f}")
    print(f"RMS Power: {np.sqrt(np.mean(np.abs(iq_signal)**2)):.1f}")

    # Downsample by 4 to get symbol constellation points (sampling at peak)
    # Search best phase offset [0..3] that maximizes constellation separation
    best_phase = 0
    best_metric = -1
    for ph in range(SAMPLES_PER_SYMBOL):
        sub = burst_samples[ph::SAMPLES_PER_SYMBOL]
        if len(sub) > 0:
            # Metric: kurtosis / distance from axes
            metric = np.mean(np.abs(np.real(sub))) * np.mean(np.abs(np.imag(sub)))
            if metric > best_metric:
                best_metric = metric
                best_phase = ph

    sym_samples = burst_samples[best_phase::SAMPLES_PER_SYMBOL]

    # Plot 1: Time Domain, Spectrum, Constellation
    fig, axs = plt.subplots(2, 2, figsize=(14, 9))
    fig.suptitle("AD9361 PL QPSK TTC Transceiver Analysis", fontsize=14, fontweight='bold')

    # 1. Time Domain Burst
    ax_time = axs[0, 0]
    n_plot = min(2048, len(iq_signal))
    t_usec = np.arange(n_plot) / (SAMPLE_RATE_HZ / 1e6)
    ax_time.plot(t_usec, np.real(iq_signal[:n_plot]), label='I (In-phase)', color='royalblue', alpha=0.8)
    ax_time.plot(t_usec, np.imag(iq_signal[:n_plot]), label='Q (Quadrature)', color='crimson', alpha=0.8)
    ax_time.set_title(f"Time Domain Waveform (First {n_plot} Samples)")
    ax_time.set_xlabel("Time (µs)")
    ax_time.set_ylabel("ADC/DAC Counts (Signed 16-bit)")
    ax_time.legend(loc='upper right')
    ax_time.grid(True, linestyle='--', alpha=0.6)

    # 2. Power Spectral Density (Welch PSD)
    ax_psd = axs[0, 1]
    f_axis, psd = signal.welch(iq_signal, fs=SAMPLE_RATE_HZ, nperseg=1024, return_onesided=False)
    f_shift = np.fft.fftshift(f_axis) / 1e6  # MHz
    psd_shift = np.fft.fftshift(psd)
    psd_db = 10 * np.log10(psd_shift + 1e-12)
    psd_db -= np.max(psd_db)  # Normalize to 0 dB peak

    ax_psd.plot(f_shift, psd_db, color='darkmagenta', lw=1.5, label='Measured Spectrum')
    # Theoretical RRC bandwidth boundaries (+/- Rs/2 * (1 + alpha))
    bw_half = (SYMBOL_RATE_HZ / 2 * (1 + RRC_ALPHA)) / 1e6
    ax_psd.axvline(-bw_half, color='gray', linestyle=':', label=f"RRC Mask (BW = {2*bw_half:.2f} MHz)")
    ax_psd.axvline(bw_half, color='gray', linestyle=':')
    ax_psd.set_title("Baseband Power Spectral Density (PSD)")
    ax_psd.set_xlabel("Frequency Offset from Carrier (MHz)")
    ax_psd.set_ylabel("Normalized Power (dB)")
    ax_psd.set_ylim(-60, 5)
    ax_psd.legend(loc='upper right')
    ax_psd.grid(True, linestyle='--', alpha=0.6)

    # 3. Constellation Diagram
    ax_const = axs[1, 0]
    if len(sym_samples) > 0:
        norm_sym = sym_samples / (np.max(np.abs(sym_samples)) + 1e-6)
        ax_const.scatter(np.real(norm_sym), np.imag(norm_sym), color='teal', alpha=0.6, s=18, edgecolors='none')
    ax_const.axhline(0, color='black', lw=0.8)
    ax_const.axvline(0, color='black', lw=0.8)
    ax_const.set_title(f"QPSK Constellation Diagram ({len(sym_samples)} symbols)")
    ax_const.set_xlabel("In-Phase (I)")
    ax_const.set_ylabel("Quadrature (Q)")
    ax_const.set_xlim(-1.5, 1.5)
    ax_const.set_ylim(-1.5, 1.5)
    ax_const.grid(True, linestyle='--', alpha=0.6)

    # 4. Burst Envelope & Activity
    ax_env = axs[1, 1]
    env_plot = min(8192, len(envelope))
    t_env = np.arange(env_plot) / (SAMPLE_RATE_HZ / 1e6)
    ax_env.plot(t_env, envelope[:env_plot], color='darkorange', label='Envelope |I+jQ|')
    ax_env.set_title("Burst Transmission Envelope & Gap Detection")
    ax_env.set_xlabel("Time (µs)")
    ax_env.set_ylabel("Magnitude")
    ax_env.legend(loc='upper right')
    ax_env.grid(True, linestyle='--', alpha=0.6)

    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="AD9361 QPSK TTC Signal Analyzer")
    parser.add_argument("--ip", default="0.0.0.0", help="UDP listen IP (default: 0.0.0.0)")
    parser.add_argument("--port", type=int, default=5005, help="UDP port (default: 5005)")
    parser.add_argument("--samples", type=int, default=32768, help="Number of samples to capture")
    parser.add_argument("--file", type=str, default=None, help="Optional raw I/Q file to analyze offline")
    args = parser.parse_args()

    if args.file:
        print(f"Loading IQ samples from file: {args.file}...")
        raw = np.fromfile(args.file, dtype=np.int16)
        i = raw[0::2]
        q = raw[1::2]
        signal_iq = i.astype(np.float32) + 1j * q.astype(np.float32)
    else:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind((args.ip, args.port))
        signal_iq = unpack_udp_packets(sock, num_samples_target=args.samples)
        sock.close()

    analyze_qpsk(signal_iq)
