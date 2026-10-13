%% Boundary and shape tests for linear_interp_checked
clear; clc;
thisFile = mfilename('fullpath');
if isempty(thisFile)
    exampleDir = fullfile(pwd, 'Src', 'Examples');
else
    exampleDir = fileparts(thisFile);
end
addpath(exampleDir);

% Exact endpoints and linear midpoint.
x = [0 1 2];
y = [5 7 9];
assert(isequal(linear_interp_checked(x, y, [0 1 2]), [5 7 9]));
assert(abs(linear_interp_checked(x, y, 0.5) - 6) < 1e-12);

% Query shape must be preserved.
q = [0.25 0.5; 1.25 1.75];
result = linear_interp_checked(x, y, q);
assert(isequal(size(result), size(q)));
assert(max(abs(result(:) - (5 + 2*q(:)))) < 1e-12);

% Invalid tables and queries must fail.
assertThrows(@() linear_interp_checked([0 2 1], [0 2 1], 0.5));
assertThrows(@() linear_interp_checked([0 NaN], [0 1], 0.5));
assertThrows(@() linear_interp_checked([0 1], [0 Inf], 0.5));
assertThrows(@() linear_interp_checked([0 1], [0 1], -eps));
assertThrows(@() linear_interp_checked([0 1], [0 1], NaN));

fprintf('Interpolation boundary tests passed.\n');

function assertThrows(callback)
    didThrow = false;
    try
        callback();
    catch
        didThrow = true;
    end
    assert(didThrow, 'Expected invalid input to raise an error.');
end
