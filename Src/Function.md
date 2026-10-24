# MATLAB Function Index

> A practical index of commonly used MATLAB functions. This is a learning aid, not a replacement for the official documentation. Availability, syntax, and behavior can vary by release and toolbox.

## How to use this index

1. Search for the task, not only a function name.
2. Run `help functionName`, `doc functionName`, and `which functionName -all`.
3. Check input type, dimensions, missing-value behavior, and toolbox dependency.
4. Test a small example before applying a function to production data.

## Environment and diagnostics

| Function / command | Purpose | Typical use |
|---|---|---|
| `help`, `doc` | Read function documentation | `help mean` |
| `which` | Resolve a function on the path | `which mean -all` |
| `ver`, `version` | Inspect MATLAB and installed products | Record environment |
| `pwd`, `cd`, `dir` | Working directory and files | Diagnose relative paths |
| `addpath`, `rmpath`, `path` | Manage search path | Configure project folders |
| `dbstop if error` | Stop at the point of an error | Interactive debugging |
| `assert`, `error`, `warning` | Validate assumptions and report failures | Defensive functions |

## Data types and array inspection

| Function | Purpose | Example |
|---|---|---|
| `class` | Return data type | `class(x)` |
| `size` | Dimensions | `size(A)` |
| `numel` | Number of elements | `numel(A)` |
| `ndims` | Number of dimensions | `ndims(A)` |
| `length` | Largest dimension | Use `size` when a specific dimension matters |
| `whos` | Inspect variables and memory | `whos` |
| `reshape` | Change shape without changing element order | `reshape(1:12,3,4)` |
| `permute`, `squeeze` | Reorder or remove singleton dimensions | Inspect output dimensions |
| `cell`, `struct`, `table` | Create heterogeneous or named data containers | Match the data model |
| `datetime`, `duration`, `categorical` | Time and category data types | Check release and import options |

## Array creation and indexing

| Function / syntax | Purpose | Notes |
|---|---|---|
| `zeros`, `ones`, `eye` | Initialize arrays | Preallocate when output size is known |
| `nan`, `inf` | Special numeric values | Define how algorithms handle them |
| `linspace`, `logspace`, `:` | Generate sequences | `linspace` fixes point count |
| `find` | Return indices matching a condition | Logical indexing may be clearer for selection |
| `sort`, `unique`, `ismember` | Ordering and membership | Check stable-order requirements |
| `repmat`, `repelem` | Repeat values or arrays | Implicit expansion may be simpler in newer releases |
| `cat`, `vertcat`, `horzcat` | Concatenate arrays | Non-concatenated dimensions must agree |

## Mathematics and statistics

| Function | Purpose | Notes |
|---|---|---|
| `sum`, `mean`, `median` | Aggregate values | Specify dimension when clarity matters |
| `std`, `var` | Standard deviation and variance | Understand sample/population normalization |
| `min`, `max`, `range` | Extremes and spread | Decide how NaN values are treated |
| `abs`, `sign`, `sqrt`, `exp`, `log` | Element-wise mathematical functions | Domain and overflow matter |
| `round`, `floor`, `ceil`, `fix` | Rounding modes | Choose deliberately for quantization |
| `dot`, `cross`, `norm` | Vector operations and norms | Check dimensions |
| `rank`, `det`, `eig`, `cond` | Matrix diagnostics | `det` is not a general solver |
| `mldivide` / `\\` | Solve linear systems | Prefer `A\\b` over `inv(A)*b` |
| `polyfit`, `polyval` | Polynomial fitting and evaluation | Validate residuals and extrapolation |
| `interp1` | One-dimensional interpolation | Define out-of-range policy |

## File input and output

| Function | Purpose | Notes |
|---|---|---|
| `readtable`, `writetable` | Table data | Inspect imported variable names and types |
| `readmatrix`, `writematrix` | Numeric matrices | Confirm header and missing-value handling |
| `readcell`, `writecell` | Mixed cell data | Prefer tables for named tabular records |
| `load`, `save` | MAT-file data | Avoid loading untrusted files blindly |
| `fopen`, `fprintf`, `fscanf`, `fclose` | Formatted file operations | Check file identifier and cleanup |
| `isfile`, `isfolder`, `fullfile` | Portable path handling | Avoid hard-coded absolute paths |

## Plotting and visualization

| Function | Purpose | Notes |
|---|---|---|
| `plot`, `scatter`, `stairs` | 2-D visualization | Match chart type to data |
| `subplot`, `tiledlayout`, `nexttile` | Arrange plots | `tiledlayout` is newer than legacy `subplot` |
| `xlabel`, `ylabel`, `title`, `legend` | Explain the plot | Include units and context |
| `grid`, `xlim`, `ylim` | Improve readability | Avoid misleading axis ranges |
| `imagesc`, `surf`, `mesh` | Matrix and 3-D visualization | State color scale and axes |
| `exportgraphics`, `saveas`, `print` | Export figures | Check release support and output quality |

## Signal processing and control

| Function / product | Purpose | Dependency note |
|---|---|---|
| `fft`, `ifft`, `fftshift` | Frequency-domain analysis | Core MATLAB functions |
| `filter`, `conv`, `movmean` | Filtering and moving averages | Confirm edge and initial-state behavior |
| `butter`, `filtfilt`, `pwelch` | Filter design and spectral estimation | Typically Signal Processing Toolbox |
| `tf`, `ss`, `step`, `lsim` | Control-system modeling and simulation | Typically Control System Toolbox |
| `kalman` | Kalman estimator design | Toolbox/function availability varies; repository examples also illustrate custom implementations |
| Simulink | Block-diagram simulation and model-based design | Separate product/license |

## Programming, performance, and tests

| Function / command | Purpose | Notes |
|---|---|---|
| `tic`, `toc`, `timeit` | Measure runtime | Benchmark representative inputs |
| `profile`, `profview` | Find performance bottlenecks | Optimize measured hotspots |
| `inputParser`, `arguments` | Parse/validate function inputs | `arguments` blocks require newer releases |
| `try`, `catch`, `rethrow` | Handle expected failures | Do not swallow errors silently |
| `matlab.unittest` | Unit testing framework | Framework details vary by release |
| `rng` | Control random number generation | Record seed for reproducibility |
| `coder` / MATLAB Coder | Generate C/C++ from supported MATLAB code | Separate product; code-generation restrictions apply |

## Repository examples

- [Runnable examples and test commands](Examples/README.md)
- [Checked interpolation](Examples/linear_interp_checked.m)
- [Low-pass filter](Examples/lowpass_filter.m)
- [Kalman filter examples](Examples/kalman_1d.m)
- [Sensor signal analysis](Examples/sensor_signal_analysis.m)
- [Fixed-point comparison](Examples/compare_fixed_point.m)
- [MATLAB/C comparison](Examples/compare_lowpass_c.m)

## Official reference

Use [MathWorks documentation](https://www.mathworks.com/help/matlab/) for authoritative syntax and release-specific behavior. For any toolbox-specific function, check both the function page and the installed product list.
