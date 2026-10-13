#include "lowpass_ref.h"

#include <math.h>
#include <stdio.h>

static int nearly_equal(double a, double b, double tolerance)
{
    return fabs(a - b) <= tolerance;
}

int main(void)
{
    const double input[] = {0.0, 1.0, 1.0, 0.0};
    const double expected[] = {0.0, 0.5, 0.75, 0.375};
    double output[4];
    double unused = 0.0;
    size_t k;

    if (lowpass_ref(input, 4U, 0.5, output) != 0) {
        fprintf(stderr, "lowpass_ref unexpectedly failed\n");
        return 1;
    }
    for (k = 0U; k < 4U; ++k) {
        if (!nearly_equal(output[k], expected[k], 1e-12)) {
            fprintf(stderr, "sample %lu: got %.15g expected %.15g\n",
                    (unsigned long)k, output[k], expected[k]);
            return 2;
        }
    }
    if (lowpass_ref(input, 4U, 0.0, output) == 0) {
        fprintf(stderr, "alpha=0 should be rejected\n");
        return 3;
    }
    if (lowpass_ref(input, 4U, 1.1, output) == 0) {
        fprintf(stderr, "alpha>1 should be rejected\n");
        return 4;
    }
    if (lowpass_ref(NULL, 1U, 0.5, output) == 0) {
        fprintf(stderr, "NULL input should be rejected for non-empty input\n");
        return 5;
    }
    if (lowpass_ref(NULL, 0U, 0.5, NULL) != 0) {
        fprintf(stderr, "empty input should be accepted\n");
        return 6;
    }
    (void)unused;
    puts("C low-pass reference tests passed.");
    return 0;
}
