#include "lowpass_ref.h"

#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_SAMPLES 1000000U

int main(int argc, char **argv)
{
    FILE *inputFile;
    FILE *outputFile;
    double *input;
    double *output;
    double alpha;
    char *alphaEnd;
    size_t count = 0U;
    size_t capacity = 64U;
    int scanResult;
    size_t k;

    if (argc != 4) {
        fprintf(stderr, "Usage: %s input.csv output.csv alpha\n", argv[0]);
        return 2;
    }

    errno = 0;
    alpha = strtod(argv[3], &alphaEnd);
    if (errno != 0 || alphaEnd == argv[3] || *alphaEnd != '\\0' ||\n        !isfinite(alpha) || alpha <= 0.0 || alpha > 1.0) {
        fprintf(stderr, "alpha must be finite and in (0, 1]\n");
        return 3;
    }

    inputFile = fopen(argv[1], "r");
    if (inputFile == NULL) {
        perror("Unable to open input");
        return 4;
    }
    input = (double *)malloc(capacity * sizeof(double));
    if (input == NULL) {
        fclose(inputFile);
        return 5;
    }

    while ((scanResult = fscanf(inputFile, " %lf", &input[count])) == 1) {
        int ch;
        if (!isfinite(input[count])) {
            fprintf(stderr, "Input contains a non-finite sample\n");
            free(input);
            fclose(inputFile);
            return 6;
        }
        ++count;
        if (count >= MAX_SAMPLES) {
            fprintf(stderr, "Input exceeds sample limit\n");
            free(input);
            fclose(inputFile);
            return 7;
        }
        if (count == capacity) {
            double *grown;
            capacity *= 2U;
            grown = (double *)realloc(input, capacity * sizeof(double));
            if (grown == NULL) {
                free(input);
                fclose(inputFile);
                return 8;
            }
            input = grown;
        }
        ch = fgetc(inputFile);
        if (ch == EOF) {
            break;
        }
        if (ch != '\n' && ch != '\r' && ch != ',' && ch != ' ' && ch != '\t') {
            fprintf(stderr, "Unexpected character in input file\n");
            free(input);
            fclose(inputFile);
            return 9;
        }
        if (ch == '\n' || ch == '\r') {
            continue;
        }
        /* Consume the remainder of the line; one numeric sample per line is expected. */
        while (ch != '\n' && ch != '\r' && ch != EOF) {
            ch = fgetc(inputFile);
        }
    }
    if (scanResult == 0) {
        fprintf(stderr, "Unable to parse input sample\n");
        free(input);
        fclose(inputFile);
        return 10;
    }
    fclose(inputFile);

    output = (double *)malloc((count == 0U ? 1U : count) * sizeof(double));
    if (output == NULL) {
        free(input);
        return 11;
    }
    if (lowpass_ref(input, count, alpha, output) != 0) {
        fprintf(stderr, "lowpass_ref failed\n");
        free(input);
        free(output);
        return 12;
    }

    outputFile = fopen(argv[2], "w");
    if (outputFile == NULL) {
        perror("Unable to open output");
        free(input);
        free(output);
        return 13;
    }
    for (k = 0U; k < count; ++k) {
        if (fprintf(outputFile, "%.17g\n", output[k]) < 0) {
            fclose(outputFile);
            free(input);
            free(output);
            return 14;
        }
    }
    fclose(outputFile);
    free(input);
    free(output);
    return 0;
}
