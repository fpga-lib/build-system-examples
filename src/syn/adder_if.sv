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

