function run_smoke_tests()
%RUN_SMOKE_TESTS Lightweight tests using MATLAB base functionality only.
% From repository root: addpath('Tests'); run_smoke_tests
fprintf('Running MATLAB repository smoke tests...\n');
testInterpolation(); testFftPeak(); testKalmanRecursion();
fprintf('All MATLAB smoke tests passed.\n');
end

function testInterpolation()
x = [0;1;2;3]; y = 2*x+1; xq = [0.5;1.5;2.5];
yq = interp1(x,y,xq,'linear'); expected = 2*xq+1;
assert(max(abs(yq-expected)) < 1e-10,'Linear interpolation test failed.');
end

function testFftPeak()
fs = 800; N = 800; t = (0:N-1)'/fs; x = sin(2*pi*40*t);
spectrum = abs(fft(x))/N;
[~,idx] = max(spectrum(2:floor(N/2)+1)); idx = idx+1;
frequency = (idx-1)*fs/N;
assert(abs(frequency-40) < 1e-10,'FFT peak test failed.');
end

function testKalmanRecursion()
z = 5*ones(100,1); q = 0.01; r = 1; x = z(1); p = 1;
for k = 2:numel(z)
    pPred = p+q; gain = pPred/(pPred+r);
    x = x+gain*(z(k)-x); p = (1-gain)*pPred;
end
assert(isfinite(x) && isfinite(p),'Kalman state became non-finite.');
assert(abs(x-5) < 0.1,'Kalman estimate did not converge.');
assert(p >= 0,'Kalman covariance must be non-negative.');
end
