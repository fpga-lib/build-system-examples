
#include <iostream>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "adder.h"

using namespace std;

//------------------------------------------------------------------------------
int main()
{
    dinp_t a[]   = {  1,  2,  3,  4 };
    dinp_t b[]   = {  3,  4,  5,  6 };
    dout_t res[] = {  4,  6,  8, 10 };
    
    cout << endl << "run csim test for HLS adder" << endl << endl;
    for(size_t i = 0; i < sizeof(a)/sizeof(a[0]); ++i)
    {
        dout_t out;
        adder(a[i], b[i], out);
        cout << "a: " << a[i] << ", b: " << b[i] << ", a + b: " << out << endl;
        
        if(out != res[i])
        {
            cout << "E: incorrect result value: " << out << ". Must be: " << res[i] << endl;
            
            return -1;
        }
    }
    cout << endl << "csim test successfull" << endl << endl;
    
    return 0;
}
//------------------------------------------------------------------------------

