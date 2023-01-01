//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: Adder module. Wraps block design
//
//
//-------------------------------------------------------------------------------




//-------------------------------------------------------------------------------
interface dinp_if
#(
    parameter DATA_W = 4
);
    
typedef logic [DATA_W-1:0] data_t;
    
data_t data;
logic  valid;
logic  ready;
    
modport m
(
    output data,
    output valid,
    input  ready
);    
    
modport s
(
    input  data,
    input  valid,
    output ready
);    
endinterface
//-------------------------------------------------------------------------------
interface dout_if
#(
    parameter DATA_W = 4
);

typedef logic [DATA_W-1:0] data_t;

data_t data;
logic  valid;

modport m
(
    output data,
    output valid
);    

modport s
(
    input  data,
    input  valid
);    
endinterface
//-------------------------------------------------------------------------------
module automatic adder_m
#(
    parameter DATA_W = 4
)
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
    
always_comb begin
    a.ready = !a_full;
    b.ready = !b_full;
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
    .dinp_a_wr_en   ( a.valid && a.ready ),
    .dinp_b_full    ( b_full             ),
    .dinp_b_wr_data ( b.data             ),
    .dinp_b_wr_en   ( b.valid && b.ready ),
    .dout           ( out.data           ),
    .adder_en       ( adder_en           )

);
//-------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------

