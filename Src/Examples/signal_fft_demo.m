%% Signal FFT demo: identify dominant frequency components
% Dependency: MATLAB base functions only (no Signal Processing Toolbox).
% Run this script from the MATLAB Editor or command window.

clear; clc; close all;
fs = 1000; duration = 2;
t = (0:1/fs:duration-1/fs).';
f1 = 50; f2 = 120;
x = 0.8*sin(2*pi*f1*t) + 0.35*sin(2*pi*f2*t);
N = numel(x); X = fft(x); P2 = abs(X/N);
P1 = P2(1:floor(N/2)+1);
if numel(P1) > 2, P1(2:end-1) = 2*P1(2:end-1); end
f = fs*(0:floor(N/2))/N;
[~, peakIndex] = max(P1(2:end)); peakIndex = peakIndex + 1;
dominantFrequency = f(peakIndex);
fprintf('Expected tones: %g Hz and %g Hz\n', f1, f2);
fprintf('Largest non-DC FFT peak: %.2f Hz\n', dominantFrequency);
figure('Name','FFT signal analysis','Color','w');
subplot(2,1,1); plot(t,x,'LineWidth',1); grid on;
xlabel('Time (s)'); ylabel('Amplitude'); title('Synthetic signal: 50 Hz + 120 Hz');
subplot(2,1,2); plot(f,P1,'LineWidth',1); grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude'); title('Single-sided amplitude spectrum'); xlim([0 200]);
% Exercises: change fs and duration; add noise/windowing; use measured sensor data.
