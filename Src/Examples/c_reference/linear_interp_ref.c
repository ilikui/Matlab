#include "linear_interp_ref.h"

#include <math.h>

int linear_interp_ref(const double *x, const double *y, size_t n,
                      const double *xq, size_t nq, double *yq)
{
    size_t i;

    if (n < 2U || x == NULL || y == NULL) {
        return -1;
    }
    if (nq == 0U) {
        return 0;
    }
    if (xq == NULL || yq == NULL) {
        return -1;
    }

    for (i = 0U; i < n; ++i) {
        if (!isfinite(x[i]) || !isfinite(y[i])) {
            return -1;
        }
        if (i > 0U && !(x[i] > x[i - 1U])) {
            return -1;
        }
    }

    for (i = 0U; i < nq; ++i) {
        if (!isfinite(xq[i]) || xq[i] < x[0] || xq[i] > x[n - 1U]) {
            return -1;
        }
    }

    for (i = 0U; i < nq; ++i) {
        size_t lo = 0U;
        size_t hi = n - 1U;
        size_t left;
        double dx;
        double ratio;

        if (xq[i] == x[0]) {
            yq[i] = y[0];
            continue;
        }
        if (xq[i] == x[n - 1U]) {
            yq[i] = y[n - 1U];
            continue;
        }

        /* Binary search means query points need not be sorted. */
        while (hi - lo > 1U) {
            size_t mid = lo + (hi - lo) / 2U;
            if (xq[i] < x[mid]) {
                hi = mid;
            } else {
                lo = mid;
            }
        }
        left = lo;
        dx = x[left + 1U] - x[left];
        ratio = (xq[i] - x[left]) / dx;
        yq[i] = y[left] + ratio * (y[left + 1U] - y[left]);
        if (!isfinite(yq[i])) {
            return -1;
        }
    }

    return 0;
}
