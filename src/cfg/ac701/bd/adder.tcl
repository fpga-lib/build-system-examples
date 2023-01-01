#--------------------------------------------------------------------------------
#
#     Project:     Any
#
#     Description: BD adding hook template
#
#     Author:      Harry E. Zhurov
#
#--------------------------------------------------------------------------------

source $BUILD_SRC_DIR/cfg_params.tcl

#-------------------------------------------------------------------------------
#
#   BD Configuration Section
#

# Create interface ports
set dinp_a [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:fifo_write_rtl:1.0 dinp_a ]
set dinp_b [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:fifo_write_rtl:1.0 dinp_b ]

# Create ports
set clk [ create_bd_port -dir I -type clk -freq_hz [expr $MAIN_CLK*1000000] clk ]
set dout [ create_bd_port -dir O -from 47 -to 0 -type data dout ]
set rst [ create_bd_port -dir I rst ]

# Create instance: fifo_a, and set properties
set fifo_a [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_a ]
set_property -dict [ list \
    CONFIG.Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
    CONFIG.Fifo_Implementation {Common_Clock_Distributed_RAM} \
    CONFIG.Full_Threshold_Assert_Value [expr ${FIFO_DEPTH}-2] \
    CONFIG.Full_Threshold_Negate_Value [expr ${FIFO_DEPTH}-3] \
    CONFIG.Input_Data_Width ${DATA_WIDTH} \
    CONFIG.Input_Depth ${FIFO_DEPTH} \
    CONFIG.Output_Data_Width ${DATA_WIDTH} \
    CONFIG.Output_Depth ${FIFO_DEPTH} \
    CONFIG.Read_Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
    CONFIG.Write_Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
] $fifo_a

# Create instance: fifo_b, and set properties
set fifo_b [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_b ]
set_property -dict [ list \
    CONFIG.Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
    CONFIG.Fifo_Implementation {Common_Clock_Distributed_RAM} \
    CONFIG.Full_Threshold_Assert_Value [expr ${FIFO_DEPTH}-2] \
    CONFIG.Full_Threshold_Negate_Value [expr ${FIFO_DEPTH}-3] \
    CONFIG.Input_Data_Width ${DATA_WIDTH} \
    CONFIG.Input_Depth ${FIFO_DEPTH} \
    CONFIG.Output_Data_Width ${DATA_WIDTH} \
    CONFIG.Output_Depth ${FIFO_DEPTH} \
    CONFIG.Read_Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
    CONFIG.Write_Data_Count_Width ${FIFO_DCOUNT_WIDTH} \
] $fifo_b

# Create instance: c_addsub_0, and set properties
set c_addsub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_0 ]

set_property -dict [ list                     \
    CONFIG.A_Type {Unsigned}                  \
    CONFIG.A_Width ${DATA_WIDTH}              \
    CONFIG.B_Type {Unsigned}                  \
    CONFIG.B_Width ${DATA_WIDTH}              \
    CONFIG.Latency {1}                        \
    CONFIG.Out_Width [expr ${DATA_WIDTH} + 1] \
] $c_addsub_0

# Create instance: not_gate_0, and set properties
set not_gate_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 not_gate_0 ]
set_property -dict [ list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
    CONFIG.LOGO_FILE {data/sym_notgate.png} \
] $not_gate_0

# Create instance: and_gate, and set properties
set and_gate [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 and_gate ]
set_property -dict [ list \
    CONFIG.C_SIZE {1} \
] $and_gate

# Create instance: not_gate_1, and set properties
set not_gate_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 not_gate_1 ]
set_property -dict [ list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
    CONFIG.LOGO_FILE {data/sym_notgate.png} \
] $not_gate_1

create_bd_port -dir O adder_en

# Create interface connections
connect_bd_intf_net -intf_net FIFO_WRITE_1 [get_bd_intf_ports dinp_a] [get_bd_intf_pins fifo_a/FIFO_WRITE]
connect_bd_intf_net -intf_net FIFO_WRITE_1_1 [get_bd_intf_ports dinp_b] [get_bd_intf_pins fifo_b/FIFO_WRITE]

# Create port connections
connect_bd_net -net CLK_1 [get_bd_ports clk] [get_bd_pins c_addsub_0/CLK] [get_bd_pins fifo_a/clk] [get_bd_pins fifo_b/clk]

connect_bd_net -net fifo_generator_0_empty [get_bd_pins fifo_a/empty] [get_bd_pins not_gate_0/Op1]
connect_bd_net -net fifo_generator_1_empty [get_bd_pins fifo_b/empty] [get_bd_pins not_gate_1/Op1]

connect_bd_net -net not_gate_0_Res [get_bd_pins not_gate_0/Res] [get_bd_pins and_gate/Op1]
connect_bd_net -net not_gate_1_Res [get_bd_pins not_gate_1/Res] [get_bd_pins and_gate/Op2]
connect_bd_net -net c_addsub_0_S [get_bd_ports dout] [get_bd_pins c_addsub_0/S]

connect_bd_net -net and_gate_Res [get_bd_pins and_gate/Res] [get_bd_pins c_addsub_0/CE] [get_bd_pins fifo_a/rd_en] [get_bd_pins fifo_b/rd_en] [get_bd_ports adder_en]

connect_bd_net -net fifo_generator_0_dout [get_bd_pins c_addsub_0/A] [get_bd_pins fifo_a/dout]
connect_bd_net -net fifo_generator_1_dout [get_bd_pins c_addsub_0/B] [get_bd_pins fifo_b/dout]
connect_bd_net [get_bd_ports rst] [get_bd_pins fifo_b/srst]
connect_bd_net [get_bd_ports rst] [get_bd_pins fifo_a/srst]

#-------------------------------------------------------------------------------

