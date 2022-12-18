
puts [pwd]

puts "\n------->>> Add net to debug probes <<<-------"

create_debug_core ila_pcie ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores ila_pcie]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores ila_pcie]
set_property C_ADV_TRIGGER false [get_debug_cores ila_pcie]
set_property C_DATA_DEPTH 1024 [get_debug_cores ila_pcie]
set_property C_EN_STRG_QUAL false [get_debug_cores ila_pcie]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores ila_pcie]
set_property C_TRIGIN_EN false [get_debug_cores ila_pcie]
set_property C_TRIGOUT_EN false [get_debug_cores ila_pcie]
set_property port_width 1 [get_debug_ports ila_pcie/clk]

connect_debug_port ila_pcie/clk [get_nets -hier -filter {NAME =~ *dpc_clk_gen/inst/clk_out1}]

#create_probe ila_pcie
#create_probe ila_pcie DATA

#-------------------------------------------------------------------------------
#
#    Task Manager
#
if { $TASK_MANAGER_ILA } {
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_tmgr_wr_data[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_tmgr_wr_valid}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_tmgr_wr_ready}]

    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_anb_wr_agent0_data[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_anb_wr_agent0_last}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_anb_wr_agent0_valid}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_anb_wr_agent0_ready}]

    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_context_q_tail_ctx[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_context_q_push}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_context_q_pop }]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_context_q_full}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_context_q_emply}]

    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_manager/dbg_ucfsm[*]}]
}
#-------------------------------------------------------------------------------
#
#    Task Distributor
#
if { $TASK_DISTRIBUTOR_ILA } {
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_tlfsm*}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_trfsm*}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_anb_data_cnt*}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/cin_cnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/din_cnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/cpl_cnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dout_acnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dout_cnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/last_cnt[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_in_valid}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_in_ready}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_out_valid}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_out_ready}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_packet_ready}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_readout_valid}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_readout_ready}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_out_data_count[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_din_last}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_anb_len_in[*]}]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_din_data[*] }]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_in_data[*] }]
    net2probe ila_pcie [get_nets -hier -filter {NAME =~ *task_distributor/dbg_dpe_out_data[*]}]
}
puts "-----------------------------------------------\n"


