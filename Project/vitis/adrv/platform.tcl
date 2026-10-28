# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/adrv/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx/adrv/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {adrv}\
-hw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_180826.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {/home/pranavsai/ReferenceDesign/Vitis/baremetal/ad9361_tx}

platform write
platform generate -domains 
platform active {adrv}
platform generate
bsp reload
bsp setlib -name xilffs -ver 4.8
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/Downloads/system_top_210926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/Downloads/system_top_210926.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_180826.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/Downloads/system_top_210926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_180826.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/Downloads/system_top_210926.xsa}
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_180826.xsa}
platform generate -domains 
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926_2.xsa}
platform generate -domains 
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926_2.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/Downloads/system_top_210926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926_2.xsa}
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_230926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_220926.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361v_1.0/system_240926.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/new_reference/hdl/projects/adrv9361z7035/ccbob_lvds/system_250926.xsa}
platform generate -domains 
platform active {adrv}
domain active {zynq_fsbl}
bsp reload
bsp setlib -name lwip211 -ver 1.8
bsp write
bsp reload
catch {bsp regenerate}
domain active {standalone_domain}
bsp reload
platform generate -domains zynq_fsbl 
domain active {zynq_fsbl}
bsp config api_mode "RAW_API"
bsp write
domain active {standalone_domain}
bsp setlib -name lwip211 -ver 1.8
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
platform config -updatehw {/home/pranavsai/new_reference/hdl/projects/adrv9361z7035/ccbob_lvds/system_270926.xsa}
domain active {zynq_fsbl}
bsp reload
bsp reload
domain active {standalone_domain}
bsp reload
bsp reload
platform generate -domains 
domain active {zynq_fsbl}
bsp reload
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/new_reference/hdl/projects/adrv9361z7035/ccbob_lvds/system_270926_01.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_290926.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_29.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_290926_007.xsa}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_290926_007.xsa}
platform clean
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_290926_007.xsa}
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_300926.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_011026.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_011026.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_ILA_021016.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_061026_00.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_071026.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_071026_Sample.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_buff_0710.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_gemini.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_old_071026.xsa}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_old_071026.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_gemini.xsa}
platform clean
platform generate
domain active {standalone_domain}
bsp reload
bsp write
platform generate -domains 
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_081026.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_081026.xsa}
platform generate -domains 
platform active {adrv}
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_121026.xsa}
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_121026_001.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_121026_002.xsa}
platform generate -domains 
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_sys_ila_1210.xsa}
platform generate
platform generate -domains 
platform clean
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_gemini.xsa}
platform generate -domains 
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_081026.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_121026_002.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_131026.xsa}
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_131026_001.xsa}
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_ols.xsa}
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_ols.xsa}
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_ols.xsa}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_141026.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_141026_001.xsa}
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_141026_002.xsa}
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_151026.xsa}
platform generate
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_151026.xsa}
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_151026_001.xsa}
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_8192.xsa}
platform clean
platform generate
platform config -updatehw {/home/pranavsai/ReferenceDesign/Vivado/adrv9361/system_top_151026_001.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/PRJ_SELF/AD9361/system_211026.xsa}
platform clean
platform generate
platform active {adrv}
platform config -updatehw {/home/pranavsai/PRJ_SELF/AD9361/system_281026.xsa}
platform clean
platform generate
