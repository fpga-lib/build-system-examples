//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: Adder HLS header example file
//
//-------------------------------------------------------------------------------

#ifndef ADDER_HLS_H
#define ADDER_HLS_H

#include <ap_int.h>

typedef ap_uint<DATA_WIDTH>   dinp_t;
typedef ap_uint<DATA_WIDTH+1> dout_t;

void adder(dinp_t a, dinp_t b, dout_t& out);
                   
#endif // ADDER_HLS_H
//-------------------------------------------------------------------------------

