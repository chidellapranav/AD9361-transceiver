# ==============================================================================
# Script: run_all.tcl
# Description: One-click script to upgrade system_top.bd to QPSK and build
#              the complete bitstream and XSA hardware package.
# ==============================================================================

set script_path [file normalize [info script]]
set script_dir  [file dirname $script_path]

puts "=================================================================="
puts "  STEP 1: Updating Block Design with QPSK Modulator Subsystem    "
puts "=================================================================="
source [file join $script_dir "update_tx_qpsk_bd.tcl"]

puts "=================================================================="
puts "  STEP 2: Building Synthesis, Implementation, Bitstream & XSA    "
puts "=================================================================="
source [file join $script_dir "build_bitstream.tcl"]
