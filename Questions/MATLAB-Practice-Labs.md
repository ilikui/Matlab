# MATLAB Practice Labs

These labs complement the [MATLAB Basics: 100 Questions](Matlab-Basics-100.md). Each lab should be completed by writing code, testing edge cases, and explaining the result.

## Lab 1 — Array inspection

Given `A = reshape(1:24, 4, 6)`:
1. Return the third column and second row.
2. Compute each row's mean and each column's sum.
3. Select elements greater than 15.
4. Explain why `A(2)` is not the second item when reading the matrix row by row.

**Acceptance:** result dimensions are stated and match the intended operation.

## Lab 2 — Sensor threshold events

Create a vector with normal values and a few threshold violations. Return:
- the violation mask,
- the indices,
- the count,
- the maximum violation,
- and a plot showing the threshold.

Test no violations, one violation, and all values violating the threshold.

## Lab 3 — Defensive function design

Write `validate_signal(x)` to require a nonempty, real, finite numeric vector. Define the behavior for row and column vectors. Test numeric, character, empty, complex, NaN, and Inf inputs.

**Acceptance:** invalid inputs fail with a stable, understandable error identifier or message.

## Lab 4 — CSV analysis

Read a CSV into a table. Verify required columns exist before accessing them. Report missing values and non-finite numeric data. Plot the original signal and a cleaned signal separately.

**Acceptance:** the raw file is never overwritten; every transformation is documented.

## Lab 5 — Linear interpolation

Implement piecewise-linear interpolation and compare it against MATLAB's `interp1` for valid in-range inputs. Test exact endpoints, a single query, unsorted table coordinates, repeated coordinates, and out-of-range queries.

**Acceptance:** the custom function's contract clearly defines each invalid or out-of-range case.

## Lab 6 — FFT frequency identification

Generate a sampled sinusoid with known frequency. Compute its FFT and frequency axis, then estimate the dominant frequency. Repeat with a frequency that does not align with an FFT bin and explain spectral leakage.

**Acceptance:** sampling rate, sample count, frequency resolution, and amplitude scaling are explained.

## Lab 7 — Low-pass filter

Apply a first-order low-pass filter to constant, step, and noisy sine inputs. Compare at least three `alpha` values.

**Acceptance:** explain smoothing, delay, startup behavior, and why one parameter cannot be optimal for every signal.

## Lab 8 — Kalman estimation

Generate ground-truth position/velocity and noisy position observations. Estimate state with a constant-velocity Kalman filter.

**Acceptance:** state and observation models are written down; noise covariance assumptions are recorded; errors are measured against ground truth.

## Lab 9 — Fixed-point quantization

Quantize a floating-point vector to a selected integer scale. Implement rounding and saturation explicitly. Compare with the floating-point reference.

**Acceptance:** demonstrate overflow, clipping, quantization error, and the limits of the selected numeric range.

## Lab 10 — MATLAB/C consistency

Run identical test vectors through MATLAB and C versions of an algorithm. Compare normalized outputs and report first mismatch, maximum absolute error, and RMSE.

**Acceptance:** build instructions, compiler warnings, data types, and tolerances are documented.

## Universal review checklist

- [ ] Normal input tested.
- [ ] Empty and single-element inputs considered.
- [ ] Wrong type and wrong dimensions tested.
- [ ] NaN/Inf policy defined.
- [ ] Units and sampling assumptions stated.
- [ ] Output dimensions checked.
- [ ] Reference or analytical result used where possible.
- [ ] Results reproducible from a clean session.
