import socket
import struct
import numpy as np
import matplotlib.pyplot as plt

UDP_IP = "0.0.0.0"
UDP_PORT = 5005
SAMPLE_RATE = 30720000  # 30.72 MHz from app_config.h

# Set up UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

# Stop capturing if no data arrives for 2 seconds
sock.settimeout(2.0)

print(f"Listening on UDP port {UDP_PORT}...")
print("Capture will stop automatically when transmission ends, or press Ctrl+C to stop manually.")

i_data = []
q_data = []

try:
    while True:
        data, _ = sock.recvfrom(2048)
        shorts = struct.unpack('<512h', data)
        
        # Extract I and Q
        for j in range(0, 512, 4):
            i_data.append(shorts[j])
            q_data.append(shorts[j+1])
            
except KeyboardInterrupt:
    print(f"\nManual stop (Ctrl+C). Captured {len(i_data)} samples.")
except socket.timeout:
    print(f"\nTransmission stopped automatically. Captured {len(i_data)} samples.")

if not i_data:
    print("No data received. Exiting.")
    exit()

print("Calculating FFT and rendering plots...")

# Convert to numpy arrays
I = np.array(i_data)
Q = np.array(q_data)
complex_signal = I + 1j * Q

plt.figure(figsize=(12, 8))

# 1. Time Domain Plot (Showing first 1000 samples for visibility)
plt.subplot(2, 1, 1)
samples_to_plot = min(1000, len(I))
plt.plot(I[:samples_to_plot], label='I (In-phase)', color='blue', alpha=0.7)
plt.plot(Q[:samples_to_plot], label='Q (Quadrature)', color='red', alpha=0.7)
plt.title(f"Time Domain (First {samples_to_plot} samples)")
plt.ylabel("Amplitude")
plt.legend()
plt.grid(True)

# 2. FFT Plot with Blackman Window
window = np.blackman(len(complex_signal))
windowed_signal = complex_signal * window

# Compute FFT
fft_result = np.fft.fftshift(np.fft.fft(windowed_signal))
fft_mag_db = 10 * np.log10(np.abs(fft_result)**2 + 1e-12)

# Calculate frequency axis in MHz
freqs = np.fft.fftshift(np.fft.fftfreq(len(complex_signal), d=1/SAMPLE_RATE))
freqs_mhz = freqs / 1e6 

plt.subplot(2, 1, 2)
plt.plot(freqs_mhz, fft_mag_db, color='purple')
plt.title("Frequency Domain (FFT with Blackman Window)")
plt.xlabel("Frequency Offset (MHz)")
plt.ylabel("Relative Power (dB)")
plt.grid(True)

plt.tight_layout()
plt.show()
