#-------------------------------------------------------------------------------
#   project:       vivado-boilerplate
#   cfg:           7a50t
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

set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports ref_clk]
set_switching_activity -deassert_resets

#-------------------------------------------------------------------------------
#    Pin locations
#-------------------------------------------------------------------------------

set_property PACKAGE_PIN K12 [get_ports clk_out]

set_property PACKAGE_PIN J14 [get_ports {out[0]}]
set_property PACKAGE_PIN K15 [get_ports {out[1]}]
set_property PACKAGE_PIN K16 [get_ports {out[2]}]
set_property PACKAGE_PIN L15 [get_ports {out[3]}]
set_property PACKAGE_PIN M15 [get_ports {out[4]}]

set_property PACKAGE_PIN M14 [get_ports {dinp_a[0]}]
set_property PACKAGE_PIN K13 [get_ports {dinp_a[1]}]
set_property PACKAGE_PIN L13 [get_ports {dinp_a[2]}]
set_property PACKAGE_PIN L12 [get_ports {dinp_a[3]}]

set_property PACKAGE_PIN N16 [get_ports {dinp_b[0]}]
set_property PACKAGE_PIN P15 [get_ports {dinp_b[1]}]
set_property PACKAGE_PIN P16 [get_ports {dinp_b[2]}]
set_property PACKAGE_PIN R15 [get_ports {dinp_b[3]}]

set_property PACKAGE_PIN T14 [get_ports ready_a]
set_property PACKAGE_PIN T15 [get_ports ready_b]

set_property PACKAGE_PIN P13 [get_ports valid_a]
set_property PACKAGE_PIN N14 [get_ports valid_b]
                         
set_property PACKAGE_PIN P14 [get_ports valid_out]

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

