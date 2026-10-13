#ifndef LOWPASS_REF_H
#define LOWPASS_REF_H

#include <stddef.h>

/*
 * First-order low-pass reference:
 *   y[0] = x[0]
 *   y[k] = y[k-1] + alpha * (x[k] - y[k-1])
 *
 * Returns 0 on success, -1 for invalid arguments.
 * alpha must be finite and in (0, 1]. Inputs and outputs may not overlap.
 */
int lowpass_ref(const double *x, size_t n, double alpha, double *y);

#endif
