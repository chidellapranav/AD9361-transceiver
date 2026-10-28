import socket
import struct
import threading
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from collections import deque

UDP_IP = "0.0.0.0"
UDP_PORT = 5005
CHUNK_SIZE = 1024

# Using a rolling window of 4096 samples to keep the live plot responsive and prevent memory crashes
MAX_SAMPLES = 4096
i_data = deque(maxlen=MAX_SAMPLES)
q_data = deque(maxlen=MAX_SAMPLES)

# AD9361 sample rate from app_config.h is 30.72 MHz
SAMPLE_RATE = 30720000 

def receive_data():
    """Background thread to continuously capture UDP packets"""
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((UDP_IP, UDP_PORT))
    print(f"Listening on port {UDP_PORT}... Close the plot window to stop.")
    
    while True:
        try:
            data, _ = sock.recvfrom(2048)
            # Unpack 1024 bytes into 512 16-bit integers
            shorts = struct.unpack('<512h', data)
            
            # Extract I and Q (every 4th integer, as 64-bit samples = 4 x 16-bit)
            for j in range(0, 512, 4):
                i_data.append(shorts[j])
                q_data.append(shorts[j+1])
        except Exception as e:
            print("Receiver thread stopped.")
            break

# Start the UDP receiver thread
rx_thread = threading.Thread(target=receive_data, daemon=True)
rx_thread.start()

# Set up the Matplotlib figure with 2 subplots
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))
fig.tight_layout(pad=4.0)

def update_plot(frame):
    """Animation function called periodically to update the graphs"""
    if len(i_data) < 100:
        return # Wait until we have enough data

    # Copy deque to numpy arrays for math operations
    I = np.array(i_data)
    Q = np.array(q_data)

    # --- 1. Time Domain Plot ---
    ax1.clear()
    ax1.plot(I, label='I (In-phase)', color='blue', alpha=0.7)
    ax1.plot(Q, label='Q (Quadrature)', color='red', alpha=0.7)
    ax1.set_title("Real-Time I/Q Time Domain")
    ax1.set_ylabel("Amplitude")
    ax1.legend(loc='upper right')
    ax1.grid(True)

    # --- 2. Frequency Domain (FFT) Plot ---
    # Combine I and Q into a complex signal
    complex_signal = I + 1j * Q
    
    # Apply a Hanning window to reduce spectral leakage
    window = np.hanning(len(complex_signal))
    windowed_signal = complex_signal * window
    
    # Compute FFT and shift zero-frequency component to the center
    fft_result = np.fft.fftshift(np.fft.fft(windowed_signal))
    
    # Convert magnitude to Power Spectral Density in dB
    fft_mag_db = 10 * np.log10(np.abs(fft_result)**2 + 1e-12)
    
    # Calculate the frequency axis in MHz based on the 30.72 MHz sample rate
    freqs = np.fft.fftshift(np.fft.fftfreq(len(complex_signal), d=1/SAMPLE_RATE))
    freqs_mhz = freqs / 1e6 
    
    ax2.clear()
    ax2.plot(freqs_mhz, fft_mag_db, color='purple')
    ax2.set_title("Frequency Domain (FFT)")
    ax2.set_xlabel("Frequency Offset (MHz)")
    ax2.set_ylabel("Relative Power (dB)")
    ax2.grid(True)

# Create the live animation (updates every 100ms)
ani = animation.FuncAnimation(fig, update_plot, interval=100, cache_frame_data=False)

# This blocks execution until you close the window
plt.show()
