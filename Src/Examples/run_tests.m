%% Lightweight regression tests for the example functions
% Run from the repository root:
%   run('Src/Examples/run_tests.m')
% No additional toolbox is required.

clear; clc;
thisFile = mfilename('fullpath');
if isempty(thisFile)
    exampleDir = fullfile(pwd, 'Src', 'Examples');
else
    exampleDir = fileparts(thisFile);
end
addpath(exampleDir);

passed = 0;

% Test 1: low-pass output length, initialization and alpha=1 identity.
x = [0 1 2 3];
y = lowpass_filter(x, 1);
assert(isequal(y, x), 'alpha=1 should pass the input through.');
assert(numel(lowpass_filter(x, 0.2)) == numel(x), ...
    'Low-pass output length should match input.');
passed = passed + 1;

% Test 2: empty input is supported.
assert(isempty(lowpass_filter([], 0.5)), ...
    'Empty input should produce empty output.');
passed = passed + 1;

% Test 3: linear interpolation reproduces a line exactly.
xTable = [0 1 2 3];
yTable = 2*xTable + 1;
actual = linear_interp_checked(xTable, yTable, [0 0.5 2.5 3]);
expected = [1 2 6 7];
assert(max(abs(actual - expected)) < 1e-12, ...
    'Linear interpolation result differs from expected values.');
passed = passed + 1;

% Test 4: duplicate interpolation knots must be rejected.
didThrow = false;
try
    linear_interp_checked([0 1 1], [0 1 2], 0.5);
catch
    didThrow = true;
end
assert(didThrow, 'Duplicate x values should raise an error.');
passed = passed + 1;

% Test 5: out-of-range interpolation must be rejected.
didThrow = false;
try
    linear_interp_checked([0 1], [0 1], 1.1);
catch
    didThrow = true;
end
assert(didThrow, 'Out-of-range query should raise an error.');
passed = passed + 1;

% Test 6: Kalman estimate remains finite and approaches constant signal.
z = [10.2 9.8 10.4 10.1 9.9];
[xhat, P] = kalman_1d(z, 0.01, 0.25, 10, 1);
assert(all(isfinite(xhat)) && all(isfinite(P)), ...
    'Kalman outputs must be finite.');
assert(abs(xhat(end) - 10) < 0.5, ...
    'Kalman estimate should remain close to the constant signal.');
assert(all(P >= 0), 'Covariance values must be non-negative.');
passed = passed + 1;

fprintf('All %d MATLAB example tests passed.\n', passed);
