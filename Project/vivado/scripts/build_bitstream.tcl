# ==============================================================================
# Script: build_bitstream.tcl
# Description: Synthesizes, implements, generates bitstream, and exports XSA
#              for the updated AD9361 QPSK TTC design.
# Target: ADRV9361-Z7035 (Zynq XC7Z035 + AD9361)
# ==============================================================================

set script_path [file normalize [info script]]
set script_dir  [file dirname $script_path]
set prj_dir     [file normalize [file join $script_dir ".."]]
set xpr_file    [file join $prj_dir "AD9361.xpr"]

puts "=================================================================="
puts "  Building Bitstream & Hardware Export (.xsa) for QPSK Design    "
puts "  Project: $xpr_file"
puts "=================================================================="

# Open project if not open
if {[catch {current_project} result]} {
    open_project $xpr_file
}

# Update compile order
update_compile_order -fileset sources_1

# Reset and Launch Synthesis
puts "INFO: Resetting and launching Synthesis (synth_1)..."
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} {
    puts "ERROR: Synthesis failed. Check synth_1 log."
    exit 1
}
puts "SUCCESS: Synthesis completed successfully."

# Launch Implementation through Bitstream Generation
puts "INFO: Launching Implementation & Bitstream generation (impl_1)..."
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {
    puts "ERROR: Implementation failed. Check impl_1 log."
    exit 1
}
puts "SUCCESS: Bitstream generation completed successfully."

# Export Hardware Platform (.xsa) for Vitis
set xsa_file [file join $prj_dir "system_qpsk_top.xsa"]
puts "INFO: Exporting fixed hardware platform to $xsa_file..."
write_hw_platform -fixed -include_bit -force -file $xsa_file

puts "=================================================================="
puts "  BUILD COMPLETE: Bitstream generated and exported to XSA:        "
puts "  $xsa_file"
puts "=================================================================="
