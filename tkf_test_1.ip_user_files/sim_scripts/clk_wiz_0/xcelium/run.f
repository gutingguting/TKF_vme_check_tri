-makelib xcelium_lib/xil_defaultlib -sv \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
  "../../../../tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

