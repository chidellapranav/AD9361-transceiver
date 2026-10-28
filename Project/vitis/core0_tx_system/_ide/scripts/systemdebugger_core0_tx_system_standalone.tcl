# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/core0_tx_system/_ide/scripts/systemdebugger_core0_tx_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/core0_tx_system/_ide/scripts/systemdebugger_core0_tx_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS3 210299B8B535" && level==0 && jtag_device_ctx=="jsn-JTAG-HS3-210299B8B535-23732093-0"}
fpga -file /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/core0_tx/_ide/bitstream/system_281026.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/adrv/export/adrv/hw/system_281026.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/core0_tx/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/core0_tx/Debug/core0_tx.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
