%% Sensor signal analysis: outlier detection, smoothing and FFT
% Base MATLAB only. Run from the repository root.
clear; clc; close all;

Fs = 200;                         % Sample rate (Hz)
N = 1000;
t = (0:N-1)' / Fs;
rng(7);                           % Reproducible noise
reference = 2*sin(2*pi*5*t) + 0.4*sin(2*pi*25*t);
measurement = reference + 0.35*randn(N,1);
measurement(350) = measurement(350) + 4; % Inject an outlier

% Robust outlier flag using median absolute deviation (MAD).
med = median(measurement);
madValue = median(abs(measurement - med));
if madValue > 0
    robustScore = 0.6745 * (measurement - med) / madValue;
    outlierMask = abs(robustScore) > 3.5;
else
    robustScore = zeros(size(measurement));
    outlierMask = false(size(measurement));
end

% Moving average with a centered window; edge samples use available data.
windowLength = 9;
smoothSignal = zeros(size(measurement));
halfWindow = floor(windowLength/2);
for k = 1:N
    first = max(1, k-halfWindow);
    last = min(N, k+halfWindow);
    smoothSignal(k) = mean(measurement(first:last));
end

% Single-sided amplitude spectrum. Remove DC before FFT.
signalForFft = measurement - mean(measurement);
Y = fft(signalForFft);
P2 = abs(Y/N);
P1 = P2(1:floor(N/2)+1);
if numel(P1) > 2
    P1(2:end-1) = 2*P1(2:end-1);
end
f = Fs*(0:floor(N/2))/N;

figure('Name','Sensor signal analysis');
subplot(3,1,1);
plot(t, measurement, 'DisplayName','Measurement'); hold on;
plot(t(outlierMask), measurement(outlierMask), 'ro', 'DisplayName','MAD outliers');
plot(t, reference, 'k--', 'DisplayName','Reference');
hold off; grid on; ylabel('Amplitude'); legend('Location','best');
title('Raw signal and robust outlier candidates');

subplot(3,1,2);
plot(t, measurement, 'Color',[0.65 0.65 0.65], 'DisplayName','Measurement'); hold on;
plot(t, smoothSignal, 'b', 'LineWidth',1.2, 'DisplayName','Moving average');
hold off; grid on; ylabel('Amplitude'); legend('Location','best');
title('Smoothing comparison');

subplot(3,1,3);
plot(f, P1); grid on; xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Single-sided amplitude spectrum');

fprintf('MAD outlier candidates: %d\n', nnz(outlierMask));
fprintf('Signal RMS: %.4f\n', sqrt(mean(measurement.^2)));
fprintf('Moving-average window: %d samples (%.3f s)\n', ...
    windowLength, windowLength/Fs);
