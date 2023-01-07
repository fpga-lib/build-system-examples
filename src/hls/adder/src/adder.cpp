//-------------------------------------------------------------------------------
//
//     Project:     Any
//                  
//     Purpose:     Adder HLS source example file
//
//     Description: Performs simple unsigned addition
//
//-------------------------------------------------------------------------------

#include "adder.h"


void adder(dinp_t a, dinp_t b, dout_t &out)
{
#pragma HLS INTERFACE port=a   mode=ap_vld 
#pragma HLS INTERFACE port=b   mode=ap_vld  
#pragma HLS INTERFACE port=out mode=ap_vld 
    
#pragma HLS INTERFACE port=return ap_ctrl_none
    
    out = a + b;
}
//-------------------------------------------------------------------------------

