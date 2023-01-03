//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: Default top-level file
//
//-------------------------------------------------------------------------------

`include "cfg_params.svh"


module automatic top
#(
    localparam DATA_W = `DATA_WIDTH
)
(
`ifdef DIFF_REFCLK
    input  logic              ref_clk_p,
    input  logic              ref_clk_n,
`else                         
    input  logic              ref_clk,
`endif

    output logic              clk_out,

    input  logic [DATA_W-1:0] dinp_a,
    input  logic              valid_a,
    output logic              ready_a,

    input  logic [DATA_W-1:0] dinp_b,
    input  logic              valid_b,
    output logic              ready_b,

    output logic [ DATA_W:0]  out,
    output logic              valid_out
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
`ifdef DIFF_REFCLK
logic ref_clk;
`endif

logic clk;
logic pll_locked;
logic rst;

`ifndef COMPLEX_EXAMPLE

logic [DATA_W-1:0] a_reg       = 0;
logic [DATA_W-1:0] b_reg       = 0;
logic              valid_a_reg = 0;
logic              valid_b_reg = 0;

`endif // COMPLEX_EXAMPLE

dinp_if #( .DATA_W ( DATA_W   ) ) a();
dinp_if #( .DATA_W ( DATA_W   ) ) b();
dout_if #( .DATA_W ( DATA_W+1 ) ) o();


//------------------------------------------------------------------------------
//
//    ILA debug
//
`ifdef TOP_ENABLE_ILA

(* mark_debug = "true" *) logic [DATA_W-1:0] dbg_out;
(* mark_debug = "true" *) logic              dbg_pll_locked;

assign dbg_out        = out;
assign dbg_pll_locked = pll_locked;

`endif // TOP_DEBUG_ENABLE


//------------------------------------------------------------------------------
//
//    Functions and tasks
//

//------------------------------------------------------------------------------
//
//    Logic
//
assign rst     = ~pll_locked;

`ifdef COMPLEX_EXAMPLE

assign a.valid   = valid_a;
assign b.valid   = valid_b;
                 
assign ready_a   = a.ready;
assign ready_b   = b.ready;
                 
assign a.data    = dinp_a;
assign b.data    = dinp_b;

assign out       = o.data;
assign valid_out = o.valid;

`else

assign ready_a   = 1;
assign ready_b   = 1;
assign valid_out = 1;

always_ff @(posedge clk) begin
    a_reg       <= dinp_a;
    b_reg       <= dinp_b;
    valid_a_reg <= valid_a;
    valid_b_reg <= valid_b;
end


always_ff @(posedge clk) begin
    if(rst) begin
        out <= 0;
    end
    else begin
        if(valid_a_reg && valid_b_reg) begin
            out <= a_reg + b_reg;
        end
    end
end

`endif // COMPLEX_EXAMPLE


//------------------------------------------------------------------------------
//
//    Instances
//
`ifdef DIFF_REFCLK
IBUFDS diff_clk_200
(
    .I  ( ref_clk_p ),
    .IB ( ref_clk_n ),
    .O  ( ref_clk   )
);
`endif
//------------------------------------------------------------------------------
pll pll_inst
(
    .clk_in1  ( ref_clk    ),
    .clk_out1 ( clk        ),
    .locked   ( pll_locked )
);
//-------------------------------------------------------------------------------
ODDR 
#(
   .DDR_CLK_EDGE ("OPPOSITE_EDGE" ),  // "OPPOSITE_EDGE" or "SAME_EDGE"
   .INIT         (1'b0            ),  // Initial value of Q: 1'b0 or 1'b1
   .SRTYPE       ("SYNC"          )   // Set/Reset type: "SYNC" or "ASYNC"
) 
clk_out_gen 
(
    .C  ( clk     ),  // 1-bit clock input
    .CE ( 1'b1    ),  // 1-bit clock enable input
    .D1 ( 1'b0    ),  // 1-bit data input (positive edge)
    .D2 ( 1'b1    ),  // 1-bit data input (negative edge)
    .R  ( 1'b0    ),  // 1-bit reset
    .S  ( 1'b0    ),  // 1-bit set
    .Q  ( clk_out )   // 1-bit DDR output
);
//-------------------------------------------------------------------------------
`ifdef COMPLEX_EXAMPLE
adder_m adder
(   
    .clk ( clk ),
    .rst ( rst ),
    .a   ( a   ),
    .b   ( b   ),
    .out ( o   )
 );
`endif // COMPLEX_EXAMPLE
//-------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------

