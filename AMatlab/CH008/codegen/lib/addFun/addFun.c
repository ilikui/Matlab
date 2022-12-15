/*
 * File: addFun.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 15-Dec-2022 15:29:32
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "addFun.h"

/* Function Definitions */

/*
 * Arguments    : int a
 *                int b
 *                int *c
 *                int *d
 * Return Type  : void
 */
void addFun(int a, int b, int *c, int *d)
{
  int i;
  double d0;
  for (i = 0; i < 10; i++) {
    d0 = (double)a + (1.0 + (double)i);
    if (d0 < 2.147483648E+9) {
      *c = (int)d0;
    } else {
      *c = MAX_int32_T;
    }

    d0 = (double)b + (1.0 + (double)i);
    if (d0 < 2.147483648E+9) {
      *d = (int)d0;
    } else {
      *d = MAX_int32_T;
    }
  }
}

/*
 * File trailer for addFun.c
 *
 * [EOF]
 */
