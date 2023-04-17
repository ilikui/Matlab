/*
 * fun1.c
 *
 * Code generation for function 'fun1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fun1.h"

/* Function Definitions */
uint8_T fun1(uint8_T a, uint8_T b)
{
  int32_T i0;
  i0 = (int32_T)((uint32_T)a + b);
  if ((uint32_T)i0 > 255U) {
    i0 = 255;
  }

  return (uint8_T)i0;
}

/* End of code generation (fun1.c) */
