/*
 * fun1_initialize.c
 *
 * Code generation for function 'fun1_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fun1.h"
#include "fun1_initialize.h"
#include "_coder_fun1_mex.h"
#include "fun1_data.h"

/* Function Definitions */
void fun1_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (fun1_initialize.c) */
