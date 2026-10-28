# the SPI connections coming out from the Zynq Processing system 


set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS18 PULLTYPE PULLUP} [get_ports SPI0_SS_O_0]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS18} [get_ports SPI0_SCLK_O_0]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS18} [get_ports SPI0_MOSI_O_0]
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS18} [get_ports SPI0_MISO_I_0]


# the processing system requires the GPIO pins which are down as follows:

# the processing system requires the GPIO pins which are down as follows:

# =========================================================
# AD9361 Status (Inputs to Zynq)
# =========================================================
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[0]}]
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[1]}]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[2]}]
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[3]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[4]}]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[5]}]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[6]}]
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS18} [get_ports {gpio_status_0[7]}]

# =========================================================
# AD9361 Control (Outputs from Zynq)
# =========================================================
set_property -dict {PACKAGE_PIN C2  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl_0[0]}]
set_property -dict {PACKAGE_PIN B1  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl_0[1]}]
set_property -dict {PACKAGE_PIN B2  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl_0[2]}]
set_property -dict {PACKAGE_PIN A2  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl_0[3]}]

# =========================================================
# AD9361 Independent Pins
# =========================================================
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS18} [get_ports gpio_en_agc_0]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS18} [get_ports gpio_sync_0]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS18} [get_ports gpio_resetb_0]
set_property -dict {PACKAGE_PIN K11 IOSTANDARD LVCMOS18} [get_ports gpio_clksel_0]