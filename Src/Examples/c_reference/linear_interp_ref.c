#include "linear_interp_ref.h"

#include <math.h>

int linear_interp_ref(const double *x, const double *y, size_t n,
                      const double *xq, size_t nq, double *yq)
{
    size_t i;
    size_t segment = 0U;

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

        while (segment + 1U < n - 1U && xq[i] > x[segment + 1U]) {
            ++segment;
        }

        dx = x[segment + 1U] - x[segment];
        ratio = (xq[i] - x[segment]) / dx;
        yq[i] = y[segment] + ratio * (y[segment + 1U] - y[segment]);
        if (!isfinite(yq[i])) {
            return -1;
        }
    }

    return 0;
}
