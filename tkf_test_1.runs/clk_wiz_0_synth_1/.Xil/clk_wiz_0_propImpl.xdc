set_property SRC_FILE_INFO {cfile:{c:/Users/DELL/Desktop/TKF_FIRMWARE/FIRMWARE source/TKF_add_sp3_11.14/tkf_test_1/tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc} rfile:../../../tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.05
