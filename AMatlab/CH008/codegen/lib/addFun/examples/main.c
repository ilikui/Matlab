/*
 * File: main.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 15-Dec-2022 15:29:32
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include Files */
#include "rt_nonfinite.h"
#include "addFun.h"
#include "main.h"
#include "addFun_terminate.h"
#include "addFun_initialize.h"

/* Function Declarations */
static int argInit_int32_T(void);
static void main_addFun(void);

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : int
 */
static int argInit_int32_T(void)
{
  return 0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_addFun(void)
{
  int c;
  int d;

  /* Initialize function 'addFun' input arguments. */
  /* Call the entry-point 'addFun'. */
  addFun(argInit_int32_T(), argInit_int32_T(), &c, &d);
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  addFun_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_addFun();

  /* Terminate the application.
     You do not need to do this more than one time. */
  addFun_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
