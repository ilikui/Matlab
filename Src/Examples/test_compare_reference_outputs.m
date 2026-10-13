%% Tests for compare_reference_outputs
clear; clc;
exampleDir = fileparts(mfilename('fullpath'));
if isempty(exampleDir)
    exampleDir = fullfile(pwd, 'Src', 'Examples');
end
addpath(exampleDir);

ref = [0 1 2 3];
same = compare_reference_outputs(ref, ref, 0);
assert(same.pass && same.maxAbsoluteError == 0 && same.rmse == 0);

candidate = [0 1.001 1.999 3.02];
report = compare_reference_outputs(ref, candidate, 0.01);
assert(~report.pass);
assert(report.mismatchCount == 1);
assert(report.maxAbsoluteError > 0.019 && report.maxAbsoluteError < 0.021);

didThrow = false;
try
    compare_reference_outputs([1 2], [1 2 3], 0.1);
catch
    didThrow = true;
end
assert(didThrow, 'Different input dimensions must raise an error.');

didThrow = false;
try
    compare_reference_outputs([1 NaN], [1 2], 0.1);
catch
    didThrow = true;
end
assert(didThrow, 'Non-finite values must raise an error.');

fprintf('Reference comparison tests passed.\n');
