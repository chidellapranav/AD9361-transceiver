# ==============================================================================
# Script: sim_tx_modem_burst.tcl
# Description: Launches behavioral simulation of tb_tx_modem_burst in Vivado XSim.
# ==============================================================================

set script_path [file normalize [info script]]
set script_dir  [file dirname $script_path]
set prj_dir     [file normalize [file join $script_dir ".."]]
set xpr_file    [file join $prj_dir "AD9361.xpr"]

if {[catch {current_project} result]} {
    open_project $xpr_file
}

# Set simulation top
set_property top tb_tx_modem_burst [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

# Launch simulation
launch_simulation
run 200us
