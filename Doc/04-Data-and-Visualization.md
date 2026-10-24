# Data Import, Analysis, and Visualization

The goal of data analysis is not just to create a plot; it is to preserve provenance, make transformations explicit, and produce interpretable results.

## 1. Import and preserve raw data

Use an explicit input path and keep raw data immutable. Functions such as `readtable`, `readmatrix`, `readcell`, `load`, and `readlines` serve different formats; verify their availability and options in the installed release.

```matlab
inputFile = fullfile(pwd, "data", "measurements.csv");
assert(isfile(inputFile), "Missing input file: %s", inputFile);
T = readtable(inputFile);
disp(T(1:min(5, height(T)), :));
```

Record units, sampling interval, sensor identity, and any filtering or exclusion rules. Never discard outliers without documenting why.

## 2. Basic quality checks

```matlab
x = T.Value;
fprintf("Samples: %d\n", numel(x));
fprintf("Missing values: %d\n", sum(ismissing(x)));
if isnumeric(x)
    fprintf("Non-finite values: %d\n", sum(~isfinite(x)));
end
```

A missing value, an impossible sensor reading, and a genuine extreme event are different phenomena. The decision to remove, flag, interpolate, or retain a sample should follow domain requirements.

## 3. Descriptive statistics

```matlab
x = [10.1 10.2 9.9 10.0 10.3];
stats.count = numel(x);
stats.mean = mean(x);
stats.median = median(x);
stats.stdSample = std(x);  % sample standard deviation by default
stats.minimum = min(x);
stats.maximum = max(x);
```

State the convention used for variance/standard deviation and whether NaNs are allowed. Report units alongside values.

## 4. Plot with context

```matlab
Fs = 100;
t = (0:999)' / Fs;
x = sin(2*pi*2*t) + 0.1*randn(size(t));

figure;
plot(t, x, 'LineWidth', 1);
grid on;
xlabel('Time (s)');
ylabel('Amplitude (unit)');
title('Measured signal');
```

A professional plot includes a descriptive title, units, readable labels, legend where needed, and an explanation of the data source. For reproducible random examples, set `rng(1)`.

## 5. Compare methods honestly

When comparing algorithms, use the same input data and clearly report the metric. Common metrics include mean absolute error (MAE), root mean square error (RMSE), maximum absolute error, runtime, and memory. Do not compare outputs from different data windows or preprocessing pipelines without stating the difference.

```matlab
reference = [1.0 2.0 3.0];
candidate = [1.1 1.9 3.2];
errorVector = candidate - reference;
mae = mean(abs(errorVector));
rmse = sqrt(mean(errorVector.^2));
maxAbsError = max(abs(errorVector));
```

## 6. Export results

Export figures and summary tables to a dedicated output folder. Include enough metadata to reproduce the result: script version, input filename, parameters, and software version. Avoid writing outputs over raw input files.

## Practice lab

- Import a CSV file and check schema, missing values, and finite values.
- Plot the raw signal before applying any transformation.
- Apply one documented cleaning rule and plot the result alongside the raw data.
- Calculate MAE and RMSE for two algorithms on the same samples.
- Write a short report describing assumptions and limitations.

## Related pages

- [Runnable examples](../Src/Examples/README.md)
- [Learning plan](../StudyPlan.md)
- [Signal analysis example](../Src/Examples/sensor_signal_analysis.m)
