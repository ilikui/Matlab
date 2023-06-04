/*=================================================================
 *
 * YPRIME.C	Sample .MEX file corresponding to YPRIME.M
 *	        Solves simple 3 body orbit problem 
 *
 * The calling syntax is:
 *
 *		[yp] = yprime(t, y)
 *
 *  You may also want to look at the corresponding M-code, yprime.m.
 *
 * This is a MEX-file for MATLAB.  
 * Copyright 1984-2017 The MathWorks, Inc.
 *
 *=================================================================*/
#include <math.h>
#include "mex.h"



void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )     
{ 
    
    int a,b,c;
    
    a =12;
    c =a+13;
    mexPrintf("c = %d\n",c);
    return;
}

/* LocalWords:  yp maxlhs
 */
