#-------------------------------------------------------------------------------
#   project:       vivado-boilerplate
#   variant:       7a35t
#
#   description:   
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#-------------------------------------------------------------------------------
#    ref_clk
#-------------------------------------------------------------------------------

#create_clock -period $REF_CLK_PERIOD [get_ports ref_clk]

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports ref_clk]
set_switching_activity -deassert_resets

#-------------------------------------------------------------------------------
#    dnum
#-------------------------------------------------------------------------------

set_property IOSTANDARD LVCMOS33 [get_ports {out}]
#set_property IOB TRUE [get_ports {dnum}]

#-------------------------------------------------------------------------------
#    Pin locations
#-------------------------------------------------------------------------------

set_property PACKAGE_PIN R11 [get_ports clk_out]

set_property PACKAGE_PIN K17 [get_ports {out[0]}]
set_property PACKAGE_PIN K18 [get_ports {out[1]}]
set_property PACKAGE_PIN L14 [get_ports {out[2]}]
set_property PACKAGE_PIN M14 [get_ports {out[3]}]
set_property PACKAGE_PIN L15 [get_ports {out[4]}]

set_property PACKAGE_PIN L18 [get_ports {dinp_a[0]}]
set_property PACKAGE_PIN M18 [get_ports {dinp_a[1]}]
set_property PACKAGE_PIN R12 [get_ports {dinp_a[2]}]
set_property PACKAGE_PIN L13 [get_ports {dinp_a[3]}]

set_property PACKAGE_PIN T18 [get_ports {dinp_b[0]}]
set_property PACKAGE_PIN N14 [get_ports {dinp_b[1]}]
set_property PACKAGE_PIN P14 [get_ports {dinp_b[2]}]
set_property PACKAGE_PIN N17 [get_ports {dinp_b[3]}]

set_property PACKAGE_PIN M16 [get_ports ready_a]
set_property PACKAGE_PIN M17 [get_ports ready_b]

set_property PACKAGE_PIN N16 [get_ports valid_a]
set_property PACKAGE_PIN P17 [get_ports valid_b]

set_property PACKAGE_PIN P15 [get_ports valid_out]

#-------------------------------------------------------------------------------
set_property DRIVE 12 [get_ports clk_out]
set_property DRIVE 12 [get_ports ready_a]
set_property DRIVE 12 [get_ports ready_b]
set_property DRIVE 12 [get_ports valid_out]
set_property DRIVE 12 [get_ports {out[*]}]

set_property SLEW SLOW [get_ports clk_out]
set_property SLEW SLOW [get_ports ready_a]
set_property SLEW SLOW [get_ports ready_b]
set_property SLEW SLOW [get_ports valid_out]
set_property SLEW SLOW [get_ports {out[*]}]

set_property IOSTANDARD LVCMOS33 [get_ports clk_out]
set_property IOSTANDARD LVCMOS33 [get_ports valid_a]
set_property IOSTANDARD LVCMOS33 [get_ports valid_b]
set_property IOSTANDARD LVCMOS33 [get_ports ready_a]
set_property IOSTANDARD LVCMOS33 [get_ports ready_b]
set_property IOSTANDARD LVCMOS33 [get_ports valid_out]
set_property IOSTANDARD LVCMOS33 [get_ports {dinp_a[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dinp_b[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[*]}]

#-------------------------------------------------------------------------------

