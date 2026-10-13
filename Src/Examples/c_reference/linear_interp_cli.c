#include "linear_interp_ref.h"

#include <ctype.h>
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ROWS 100000U
#define LINE_CAP 512U

static int parse_number(const char *text, double *value, const char **end_out)
{
    char *end;
    errno = 0;
    *value = strtod(text, &end);
    if (errno != 0 || end == text || !isfinite(*value)) {
        return -1;
    }
    *end_out = end;
    return 0;
}

static int only_space(const char *text)
{
    while (*text != '\0') {
        if (!isspace((unsigned char)*text)) {
            return 0;
        }
        ++text;
    }
    return 1;
}

static int read_table(const char *path, double *x, double *y, size_t *count)
{
    FILE *file = fopen(path, "r");
    char line[LINE_CAP];
    size_t n = 0U;

    if (file == NULL) {
        perror(path);
        return -1;
    }
    while (fgets(line, sizeof(line), file) != NULL) {
        double xv;
        double yv;
        const char *end1;
        const char *end2;
        char *comma;
        size_t len = strlen(line);

        if (len > 0U && line[len - 1U] != '\n' && !feof(file)) {
            fprintf(stderr, "table row exceeds line limit\n");
            fclose(file);
            return -1;
        }
        if (only_space(line)) {
            continue;
        }
        comma = strchr(line, ',');
        if (comma == NULL || strchr(comma + 1, ',') != NULL ||
            parse_number(line, &xv, &end1) != 0 || end1 != comma ||
            parse_number(comma + 1, &yv, &end2) != 0 || !only_space(end2)) {
            fprintf(stderr, "invalid table row: %s", line);
            fclose(file);
            return -1;
        }
        if (n >= MAX_ROWS) {
            fprintf(stderr, "table exceeds maximum row count\n");
            fclose(file);
            return -1;
        }
        x[n] = xv;
        y[n] = yv;
        ++n;
    }
    if (ferror(file)) {
        perror("read table");
        fclose(file);
        return -1;
    }
    fclose(file);
    *count = n;
    return 0;
}

static int read_queries(const char *path, double *q, size_t *count)
{
    FILE *file = fopen(path, "r");
    char line[LINE_CAP];
    size_t n = 0U;

    if (file == NULL) {
        perror(path);
        return -1;
    }
    while (fgets(line, sizeof(line), file) != NULL) {
        double value;
        const char *end;
        size_t len = strlen(line);

        if (len > 0U && line[len - 1U] != '\n' && !feof(file)) {
            fprintf(stderr, "query row exceeds line limit\n");
            fclose(file);
            return -1;
        }
        if (only_space(line)) {
            continue;
        }
        if (parse_number(line, &value, &end) != 0 || !only_space(end)) {
            fprintf(stderr, "invalid query row: %s", line);
            fclose(file);
            return -1;
        }
        if (n >= MAX_ROWS) {
            fprintf(stderr, "query file exceeds maximum row count\n");
            fclose(file);
            return -1;
        }
        q[n++] = value;
    }
    if (ferror(file)) {
        perror("read queries");
        fclose(file);
        return -1;
    }
    fclose(file);
    *count = n;
    return 0;
}

int main(int argc, char **argv)
{
    double *x = NULL;
    double *y = NULL;
    double *q = NULL;
    double *out = NULL;
    size_t n = 0U;
    size_t nq = 0U;
    size_t i;
    FILE *file = NULL;
    int status = EXIT_FAILURE;

    if (argc != 4) {
        fprintf(stderr, "usage: %s table.csv queries.csv output.csv\n", argv[0]);
        return EXIT_FAILURE;
    }

    x = (double *)malloc(MAX_ROWS * sizeof(*x));
    y = (double *)malloc(MAX_ROWS * sizeof(*y));
    q = (double *)malloc(MAX_ROWS * sizeof(*q));
    out = (double *)malloc(MAX_ROWS * sizeof(*out));
    if (x == NULL || y == NULL || q == NULL || out == NULL) {
        fprintf(stderr, "memory allocation failed\n");
        goto cleanup;
    }

    if (read_table(argv[1], x, y, &n) != 0 || n < 2U) {
        fprintf(stderr, "table must contain at least two valid rows\n");
        goto cleanup;
    }
    if (read_queries(argv[2], q, &nq) != 0) {
        goto cleanup;
    }
    if (linear_interp_ref(x, y, n, q, nq, out) != 0) {
        fprintf(stderr, "invalid table or query outside the table range\n");
        goto cleanup;
    }

    file = fopen(argv[3], "w");
    if (file == NULL) {
        perror(argv[3]);
        goto cleanup;
    }
    for (i = 0U; i < nq; ++i) {
        if (fprintf(file, "%.17g\n", out[i]) < 0) {
            perror("write output");
            goto cleanup;
        }
    }
    if (fclose(file) != 0) {
        file = NULL;
        perror("close output");
        goto cleanup;
    }
    file = NULL;
    status = EXIT_SUCCESS;

cleanup:
    if (file != NULL) {
        fclose(file);
    }
    free(out);
    free(q);
    free(y);
    free(x);
    return status;
}
