//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: Adder module. Wraps block design
//
//-------------------------------------------------------------------------------


//-------------------------------------------------------------------------------
module automatic adder_m
(
    input logic  clk,
    input logic  rst,
    
    dinp_if.s    a,
    dinp_if.s    b,
    dout_if.m    out
);

//------------------------------------------------------------------------------
//
//    Settings
//
    
//------------------------------------------------------------------------------
//
//    Types
//
    
    
//------------------------------------------------------------------------------
//
//    Objects
//
logic adder_en;
logic a_full;
logic b_full;

//------------------------------------------------------------------------------
//
//    Functions and tasks
//

//------------------------------------------------------------------------------
//
//    Logic
//
always_ff @(posedge clk) begin
    out.valid <= adder_en;  // add pipeline delay
end
    
//------------------------------------------------------------------------------
//
//    Instances
//
adder_wrapper adder_bd
(   
    .clk            ( clk                ),
    .rst            ( rst                ),
    .dinp_a_full    ( a_full             ),
    .dinp_a_wr_data ( a.data             ),
    .dinp_a_wr_en   ( a.valid && !a_full ),
    .dinp_b_full    ( b_full             ),
    .dinp_b_wr_data ( b.data             ),
    .dinp_b_wr_en   ( b.valid && !b_full ),
    .dout           ( out.data           ),
    .adder_en       ( adder_en           )

);
//-------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------

