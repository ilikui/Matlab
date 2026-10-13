%% Run all MATLAB example regression tests from one entry point
% Run from the repository root:
%   run('Src/Examples/run_all_tests.m')
% Tests use base MATLAB only. A MATLAB runtime is required to execute them.
%
% The test scripts use CLEAR, so do not store the directory in a workspace
% variable that must survive between RUN calls. Recompute the path each time.

addpath(fullfile(fileparts(mfilename('fullpath'))));

fprintf('\n=== Core example tests ===\n');
run(fullfile(fileparts(mfilename('fullpath')), 'run_tests.m'));

fprintf('\n=== Reference output comparison tests ===\n');
run(fullfile(fileparts(mfilename('fullpath')), 'test_compare_reference_outputs.m'));

fprintf('\n=== Interpolation boundary tests ===\n');
run(fullfile(fileparts(mfilename('fullpath')), 'test_interpolation.m'));

fprintf('\n=== Position-velocity Kalman tests ===\n');
run(fullfile(fileparts(mfilename('fullpath')), 'test_kalman_position_velocity.m'));

fprintf('\nAll test scripts completed without assertion errors.\n');
