/*
 * File: _coder_addFun_api.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 15-Dec-2022 15:29:32
 */

#ifndef _CODER_ADDFUN_API_H
#define _CODER_ADDFUN_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_addFun_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void addFun(int32_T a, int32_T b, int32_T *c, int32_T *d);
extern void addFun_api(const mxArray * const prhs[2], const mxArray *plhs[2]);
extern void addFun_atexit(void);
extern void addFun_initialize(void);
extern void addFun_terminate(void);
extern void addFun_xil_terminate(void);

#endif

/*
 * File trailer for _coder_addFun_api.h
 *
 * [EOF]
 */
