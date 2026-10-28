# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AMPLITUDE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_CODED_PAIRS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PAYLOAD_BYTES" -parent ${Page_0}


}

proc update_PARAM_VALUE.AMPLITUDE { PARAM_VALUE.AMPLITUDE } {
	# Procedure called to update AMPLITUDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AMPLITUDE { PARAM_VALUE.AMPLITUDE } {
	# Procedure called to validate AMPLITUDE
	return true
}

proc update_PARAM_VALUE.MAX_CODED_PAIRS { PARAM_VALUE.MAX_CODED_PAIRS } {
	# Procedure called to update MAX_CODED_PAIRS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_CODED_PAIRS { PARAM_VALUE.MAX_CODED_PAIRS } {
	# Procedure called to validate MAX_CODED_PAIRS
	return true
}

proc update_PARAM_VALUE.PAYLOAD_BYTES { PARAM_VALUE.PAYLOAD_BYTES } {
	# Procedure called to update PAYLOAD_BYTES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PAYLOAD_BYTES { PARAM_VALUE.PAYLOAD_BYTES } {
	# Procedure called to validate PAYLOAD_BYTES
	return true
}


proc update_MODELPARAM_VALUE.PAYLOAD_BYTES { MODELPARAM_VALUE.PAYLOAD_BYTES PARAM_VALUE.PAYLOAD_BYTES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PAYLOAD_BYTES}] ${MODELPARAM_VALUE.PAYLOAD_BYTES}
}

proc update_MODELPARAM_VALUE.MAX_CODED_PAIRS { MODELPARAM_VALUE.MAX_CODED_PAIRS PARAM_VALUE.MAX_CODED_PAIRS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_CODED_PAIRS}] ${MODELPARAM_VALUE.MAX_CODED_PAIRS}
}

proc update_MODELPARAM_VALUE.AMPLITUDE { MODELPARAM_VALUE.AMPLITUDE PARAM_VALUE.AMPLITUDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AMPLITUDE}] ${MODELPARAM_VALUE.AMPLITUDE}
}

