%% Run all MATLAB example regression tests from one entry point
% Run from the repository root:
%   run('Src/Examples/run_all_tests.m')
% Tests use base MATLAB only. A MATLAB runtime is required to execute them.

thisFile = mfilename('fullpath');
if isempty(thisFile)
    exampleDir = fullfile(pwd, 'Src', 'Examples');
else
    exampleDir = fileparts(thisFile);
end
addpath(exampleDir);

fprintf('\n=== Core example tests ===\n');
run(fullfile(exampleDir, 'run_tests.m'));

fprintf('\n=== Reference output comparison tests ===\n');
run(fullfile(exampleDir, 'test_compare_reference_outputs.m'));

fprintf('\n=== Interpolation boundary tests ===\n');
run(fullfile(exampleDir, 'test_interpolation.m'));

fprintf('\n=== Position-velocity Kalman tests ===\n');
run(fullfile(exampleDir, 'test_kalman_position_velocity.m'));

fprintf('\nAll test scripts completed without assertion errors.\n');
