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
#    Timing
#-------------------------------------------------------------------------------

create_clock -period $REF_CLK_PERIOD -name ref_clk -waveform "0.000 $REF_CLK_HALF_PERIOD" [get_ports ref_clk]

create_generated_clock -name clk_out -source [get_pins pll_inst/clk_out2] -multiply_by 1 [get_pins clk_out_gen/C]

#set_input_delay  -clock [get_clocks clk_out] 0.0 [get_ports {{dinp_a[0]} {dinp_a[1]} {dinp_a[2]} {dinp_a[3]} {dinp_b[0]} {dinp_b[1]} {dinp_b[2]} {dinp_b[3]} valid_a valid_b}]
#set_output_delay -clock [get_clocks clk_out] 0.0 [get_ports {{out[0]} {out[1]} {out[2]} {out[3]} {out[4]} }]

set_input_delay  -clock [get_clocks clk_out] 0.0 [get_ports {dinp_a[*] valid_a valid_b}]
set_output_delay -clock [get_clocks clk_out] 0.0 [get_ports out[*]]

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

set_property PACKAGE_PIN P13 [get_ports valid_a]
set_property PACKAGE_PIN N14 [get_ports valid_b]
                         
set_property PACKAGE_PIN P14 [get_ports valid_out]

#-------------------------------------------------------------------------------
set_property IOB true [get_ports {out[*]}]
set_property IOB true [get_cells -hierarchical "a_reg*" ]
set_property IOB true [get_cells -hierarchical "b_reg*" ]
set_property IOB true [get_cells -hierarchical "valid_a_reg*" ]
set_property IOB true [get_cells -hierarchical "valid_b_reg*" ]

set_property DRIVE 12 [get_ports clk_out]
set_property DRIVE 12 [get_ports valid_out]
set_property DRIVE 12 [get_ports {out[*]}]

set_property SLEW FAST [get_ports clk_out]
set_property SLEW FAST [get_ports valid_out]
set_property SLEW FAST [get_ports {out[*]}]

set_property IOSTANDARD LVCMOS33 [get_ports clk_out]
set_property IOSTANDARD LVCMOS33 [get_ports valid_a]
set_property IOSTANDARD LVCMOS33 [get_ports valid_b]
set_property IOSTANDARD LVCMOS33 [get_ports valid_out]
set_property IOSTANDARD LVCMOS33 [get_ports {dinp_a[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dinp_b[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[*]}]

#-------------------------------------------------------------------------------

