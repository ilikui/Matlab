/*
 * fun1_terminate.c
 *
 * Code generation for function 'fun1_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fun1.h"
#include "fun1_terminate.h"
#include "_coder_fun1_mex.h"
#include "fun1_data.h"

/* Function Definitions */
void fun1_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void fun1_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (fun1_terminate.c) */
