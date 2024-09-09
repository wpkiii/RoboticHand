create_clock -name clk -period "50MHz" [get_ports clk]
#create_clock -period 20.0 -name sys_clk [get_ports sys_clk]
#derive_pll_clocks