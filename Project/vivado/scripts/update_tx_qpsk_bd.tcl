# ==============================================================================
# Script: update_tx_qpsk_bd.tcl
# Description: Upgrades the AD9361 transmit path in system_top.bd from the basic
#              CORDIC CW tone generator to the full QPSK TTC burst modulator.
# Target: ADRV9361-Z7035 (Zynq XC7Z035 + AD9361)
# ==============================================================================

set script_path [file normalize [info script]]
set script_dir  [file dirname $script_path]
set prj_dir     [file normalize [file join $script_dir ".."]]
set xpr_file    [file join $prj_dir "AD9361.xpr"]

puts "=================================================================="
puts "  Updating AD9361 Transceiver: Upgrading to QPSK TTC Modulator   "
puts "  Project: $xpr_file"
puts "=================================================================="

# 1. Open the project if not already open
if {[catch {current_project} result]} {
    puts "INFO: Opening project $xpr_file..."
    open_project $xpr_file
}

# 2. Ensure all QPSK Verilog source files are added to the fileset
set src_dir [file join $prj_dir "AD9361.srcs" "sources_1"]
set qpsk_files [list \
    [file join $src_dir "imports" "tx_crc_step1" "payload_generator.v"] \
    [file join $src_dir "imports" "tx_crc_step1" "crc32_append.v"] \
    [file join $src_dir "imports" "tx_crc_step1" "tx_payload_crc_top.v"] \
    [file join $src_dir "new" "packet_scrambler.v"] \
    [file join $src_dir "new" "conv_encoder.v"] \
    [file join $src_dir "new" "frame_assembler.v"] \
    [file join $src_dir "new" "qpsk_mapper.v"] \
    [file join $src_dir "new" "rrc_interpolator.v"] \
    [file join $src_dir "new" "tx_coded_top.v"] \
    [file join $src_dir "new" "tx_qpsk_top.v"] \
    [file join $src_dir "new" "tx_rrc_top.v"] \
    [file join $src_dir "new" "tx_modem_burst.v"] \
]

foreach f $qpsk_files {
    if {[get_files -quiet [file tail $f]] eq ""} {
        puts "INFO: Adding missing source file $f to sources_1..."
        add_files -fileset sources_1 $f
    }
}
update_compile_order -fileset sources_1

# 3. Open the Block Design
puts "INFO: Opening block design system_top.bd..."
open_bd_design [get_files system_top.bd]

# 4. Remove old CORDIC-based tone generator hierarchy (Tx_TestBench)
if {[get_bd_cells -quiet Tx_TestBench] ne ""} {
    puts "INFO: Deleting legacy Tx_TestBench (CORDIC CW tone generator)..."
    delete_bd_objs [get_bd_cells Tx_TestBench]
}

# 5. Remove existing tx_modem_burst_0 if present for clean instantiation
if {[get_bd_cells -quiet tx_modem_burst_0] ne ""} {
    puts "INFO: Removing existing tx_modem_burst_0 for clean re-instantiation..."
    delete_bd_objs [get_bd_cells tx_modem_burst_0]
}

# 6. Add tx_modem_burst as a Module Reference
puts "INFO: Instantiating tx_modem_burst as RTL module reference tx_modem_burst_0..."
create_bd_cell -type module -reference tx_modem_burst tx_modem_burst_0

# 7. Add enable tie-off (logic 1 for autonomous operation)
if {[get_bd_cells -quiet xlconstant_tx_en] eq ""} {
    puts "INFO: Adding xlconstant_tx_en (logic 1 enable)..."
    create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_tx_en
    set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells xlconstant_tx_en]
}

# 8. Connect Clock and Reset
puts "INFO: Connecting clock and reset to tx_modem_burst_0..."
# Clock: 30.72 MHz baseband clock from clock_divider_0
connect_bd_net [get_bd_pins clock_divider_0/clk_out] [get_bd_pins tx_modem_burst_0/clk]
# Reset: active-low synchronous reset from AD9361 proc_sys_reset
connect_bd_net [get_bd_pins rst_ad9361/peripheral_aresetn] [get_bd_pins tx_modem_burst_0/resetn]
# Enable: continuous burst sequencing
connect_bd_net [get_bd_pins xlconstant_tx_en/dout] [get_bd_pins tx_modem_burst_0/enable]

# 9. Connect QPSK Modulator Outputs to AD9361 DAC FIFO (IP_AnalogDevices)
puts "INFO: Connecting QPSK I/Q outputs to IP_AnalogDevices (util_rfifo_0)..."

# Channel 0 (TX1)
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_i] [get_bd_pins IP_AnalogDevices/din_data_0]
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_q] [get_bd_pins IP_AnalogDevices/din_data_1]

# Channel 1 (TX2) - Dual transmission
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_i] [get_bd_pins IP_AnalogDevices/din_data_2]
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_q] [get_bd_pins IP_AnalogDevices/din_data_3]

# Valid strobes for Channel 0 & Channel 1
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_valid] [get_bd_pins IP_AnalogDevices/din_valid_in_1]
connect_bd_net [get_bd_pins tx_modem_burst_0/tx_valid] [get_bd_pins IP_AnalogDevices/din_valid_in_3]

# 10. Validate and Save Block Design
puts "INFO: Validating block design..."
validate_bd_design

puts "INFO: Saving block design..."
save_bd_design

# 11. Generate Output Products
puts "INFO: Generating output products for system_top.bd..."
generate_target all [get_files system_top.bd]

# 12. Update Top-Level HDL Wrapper
puts "INFO: Updating HDL wrapper..."
make_wrapper -files [get_files system_top.bd] -top -import -force

puts "=================================================================="
puts "  SUCCESS: system_top.bd has been updated with QPSK TTC Modulator!"
puts "=================================================================="
