#include "lowpass_ref.h"

#include <math.h>

int lowpass_ref(const double *x, size_t n, double alpha, double *y)
{
    size_t k;

    if (!isfinite(alpha) || alpha <= 0.0 || alpha > 1.0) {
        return -1;
    }
    if (n == 0U) {
        return 0;
    }
    if (x == NULL || y == NULL) {
        return -1;
    }

    for (k = 0U; k < n; ++k) {
        if (!isfinite(x[k])) {
            return -1;
        }
    }

    y[0] = x[0];
    for (k = 1U; k < n; ++k) {
        y[k] = y[k - 1U] + alpha * (x[k] - y[k - 1U]);
    }
    return 0;
}
