#ifndef LINEAR_INTERP_REF_H
#define LINEAR_INTERP_REF_H

#include <stddef.h>

/*
 * Piecewise linear interpolation without extrapolation.
 *
 * x and y contain n table points, where n >= 2 and x is strictly
 * increasing. Every query must be finite and inside [x[0], x[n - 1]].
 * The output buffer yq must contain at least nq elements.
 *
 * Returns 0 on success, -1 on invalid input. An empty query list (nq == 0)
 * is valid; in that case xq and yq may be NULL.
 */
int linear_interp_ref(const double *x, const double *y, size_t n,
                      const double *xq, size_t nq, double *yq);

#endif
