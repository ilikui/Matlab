%% Tests for kalman_position_velocity
clear; clc;
thisFile = mfilename('fullpath');
if isempty(thisFile)
    exampleDir = fullfile(pwd, 'Src', 'Examples');
else
    exampleDir = fileparts(thisFile);
end
addpath(exampleDir);

% Synthetic constant-velocity motion with deterministic measurement noise.
dt = 0.1;
n = 200;
t = (0:n-1)*dt;
truePosition = 2 + 1.5*t;
z = truePosition + 0.2*sin(2*pi*0.7*t);
[xhat, P] = kalman_position_velocity(z, dt, 0.05, 0.04, [1.5; 0], diag([1 1]));

assert(isequal(size(xhat), [2 n]));
assert(isequal(size(P), [2 2 n]));
assert(all(isfinite(xhat(:))) && all(isfinite(P(:))));
assert(all(arrayfun(@(k) min(eig(P(:,:,k))) > -1e-9, 1:n)));
assert(abs(xhat(1,end) - truePosition(end)) < 0.25);
assert(abs(xhat(2,end) - 1.5) < 0.25);

didThrow = false;
try
    kalman_position_velocity(z, 0, 0.05, 0.04, [1.5; 0], eye(2));
catch
    didThrow = true;
end
assert(didThrow, 'A zero sample interval must be rejected.');

fprintf('Position-velocity Kalman tests passed.\n');
