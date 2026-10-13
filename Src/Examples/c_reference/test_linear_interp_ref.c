#include "linear_interp_ref.h"

#include <math.h>
#include <stdio.h>

#define CHECK(condition) do { \
    if (!(condition)) { \
        fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #condition); \
        return 1; \
    } \
} while (0)

static int near(double actual, double expected)
{
    return fabs(actual - expected) <= 1e-12;
}

int main(void)
{
    const double x[] = {0.0, 1.0, 3.0, 4.0};
    const double y[] = {0.0, 10.0, 30.0, 20.0};
    const double q[] = {0.0, 0.5, 2.0, 3.0, 4.0};
    const double expected[] = {0.0, 5.0, 20.0, 30.0, 20.0};
    double out[5] = {0.0};
    const double duplicate_x[] = {0.0, 1.0, 1.0};
    const double bad_y[] = {0.0, NAN, 2.0};
    const double out_of_range[] = {-0.1};
    const double unsorted_q[] = {3.0, 0.5, 2.0};
    double unsorted_out[3] = {0.0};
    size_t i;

    CHECK(linear_interp_ref(x, y, 4U, q, 5U, out) == 0);
    for (i = 0U; i < 5U; ++i) {
        CHECK(near(out[i], expected[i]));
    }

    CHECK(linear_interp_ref(x, y, 4U, unsorted_q, 3U, unsorted_out) == 0);
    CHECK(near(unsorted_out[0], 30.0));
    CHECK(near(unsorted_out[1], 5.0));
    CHECK(near(unsorted_out[2], 20.0));

    CHECK(linear_interp_ref(x, y, 4U, NULL, 0U, NULL) == 0);
    CHECK(linear_interp_ref(NULL, y, 4U, q, 5U, out) == -1);
    CHECK(linear_interp_ref(x, y, 1U, q, 5U, out) == -1);
    CHECK(linear_interp_ref(duplicate_x, y, 3U, q, 1U, out) == -1);
    CHECK(linear_interp_ref(x, bad_y, 3U, q, 1U, out) == -1);
    CHECK(linear_interp_ref(x, y, 4U, out_of_range, 1U, out) == -1);
    CHECK(linear_interp_ref(x, y, 4U, NULL, 1U, out) == -1);

    puts("linear_interp_ref: all tests passed");
    return 0;
}
