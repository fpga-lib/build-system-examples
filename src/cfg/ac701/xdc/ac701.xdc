#-------------------------------------------------------------------------------
#   Project:       SCons FPGA Project Build System
#   Board:         Xilinx AC701
#
#   Description:   example project
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#-------------------------------------------------------------------------------
#    Ref clk
#-------------------------------------------------------------------------------

set_property PACKAGE_PIN R3 [get_ports ref_clk_p]
set_property PACKAGE_PIN P3 [get_ports ref_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports ref_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports ref_clk_n]

# EMCCLK
#set_property PACKAGE_PIN P16 [get_ports emcclk]
#set_property IOSTANDARD LVCMOS33 [get_ports emcclk]

set_switching_activity -deassert_resets

#-------------------------------------------------------------------------------
#    Timing
#-------------------------------------------------------------------------------
create_clock -period $REF_CLK_PERIOD -name ref_clk -waveform "0.000 $REF_CLK_HALF_PERIOD" [get_ports ref_clk_p]

create_generated_clock -name clk_out -source [get_pins pll_inst/clk_out2] -multiply_by 1 [get_pins clk_out_gen/C]

#set_input_delay  -clock [get_clocks clk_out] 0.0 [get_ports {{dinp_a[0]} {dinp_a[1]} {dinp_a[2]} {dinp_a[3]} {dinp_b[0]} {dinp_b[1]} {dinp_b[2]} {dinp_b[3]} valid_a valid_b}]
#set_output_delay -clock [get_clocks clk_out] 0.0 [get_ports {{out[0]} {out[1]} {out[2]} {out[3]} {out[4]}}]

set_input_delay  -clock [get_clocks clk_out] 0.0 [get_ports {dinp_a[*] valid_a valid_b}]
set_output_delay -clock [get_clocks clk_out] 0.0 [get_ports out[*]]


#-------------------------------------------------------------------------------
#    Pin locations
#-------------------------------------------------------------------------------

set_property PACKAGE_PIN M26 [get_ports {out[0]}]
set_property PACKAGE_PIN T24 [get_ports {out[1]}]
set_property PACKAGE_PIN T25 [get_ports {out[2]}]
set_property PACKAGE_PIN R26 [get_ports {out[3]}]
set_property PACKAGE_PIN P26 [get_ports {out[4]}]
set_property PACKAGE_PIN T22 [get_ports {out[5]}]
set_property PACKAGE_PIN R22 [get_ports {out[6]}]
set_property PACKAGE_PIN T23 [get_ports {out[7]}]
set_property PACKAGE_PIN R23 [get_ports {out[8]}]
set_property PACKAGE_PIN N26 [get_ports clk_out]

set_property PACKAGE_PIN M19 [get_ports {dinp_a[0]}]
set_property PACKAGE_PIN R14 [get_ports {dinp_a[1]}]
set_property PACKAGE_PIN R15 [get_ports {dinp_a[2]}]
set_property PACKAGE_PIN P14 [get_ports {dinp_a[3]}]
set_property PACKAGE_PIN N14 [get_ports {dinp_a[4]}]
set_property PACKAGE_PIN P15 [get_ports {dinp_a[5]}]
set_property PACKAGE_PIN P16 [get_ports {dinp_a[6]}]
set_property PACKAGE_PIN N16 [get_ports {dinp_a[7]}]

set_property PACKAGE_PIN R16 [get_ports {dinp_b[0]}]
set_property PACKAGE_PIN R17 [get_ports {dinp_b[1]}]
set_property PACKAGE_PIN P18 [get_ports {dinp_b[2]}]
set_property PACKAGE_PIN N18 [get_ports {dinp_b[3]}]
set_property PACKAGE_PIN K25 [get_ports {dinp_b[4]}]
set_property PACKAGE_PIN K26 [get_ports {dinp_b[5]}]
set_property PACKAGE_PIN M20 [get_ports {dinp_b[6]}]
set_property PACKAGE_PIN L20 [get_ports {dinp_b[7]}]

set_property PACKAGE_PIN M25 [get_ports valid_a]
set_property PACKAGE_PIN L22 [get_ports valid_b]

set_property PACKAGE_PIN L23 [get_ports valid_out]

#-------------------------------------------------------------------------------
set_property IOB true [get_ports {out[*]}]
set_property IOB true [get_ports {valid_out}]
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
#    Bitstream
#-------------------------------------------------------------------------------
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-1 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
#-------------------------------------------------------------------------------

