%% Floating-point versus fixed-point-style quantization
% This example demonstrates scaling, rounding, saturation and error metrics.
% It is a numeric simulation, not a substitute for target C compiler tests.
clear; clc; close all;

N = 1000;
t = linspace(0, 1, N);
reference = 0.8*sin(2*pi*3*t) + 0.15*cos(2*pi*11*t);

fractionBits = 12;
scale = 2^fractionBits;
minValue = -1;
maxValue = 1 - 1/scale;

% Quantize to a signed normalized range with saturation.
quantized = round(reference * scale) / scale;
quantized = min(max(quantized, minValue), maxValue);
errorSignal = quantized - reference;

maxAbsError = max(abs(errorSignal));
rmse = sqrt(mean(errorSignal.^2));
relativeRms = rmse / max(sqrt(mean(reference.^2)), eps);

figure('Name','Quantization comparison');
subplot(2,1,1);
plot(t, reference, 'DisplayName','Reference'); hold on;
stairs(t, quantized, 'DisplayName','Quantized');
hold off; grid on; ylabel('Amplitude'); legend('Location','best');
title('Reference and quantized signal');
subplot(2,1,2);
plot(t, errorSignal); grid on;
xlabel('Time (s)'); ylabel('Error');
title('Quantization error');

fprintf('Fraction bits: %d\n', fractionBits);
fprintf('Representable range: [%.6f, %.6f]\n', minValue, maxValue);
fprintf('Max absolute error: %.8g\n', maxAbsError);
fprintf('RMSE: %.8g\n', rmse);
fprintf('Relative RMS error: %.8g\n', relativeRms);

% Engineering notes:
% 1. This example models quantization and saturation, not every C integer rule.
% 2. Real implementations must specify rounding, overflow/wrap, intermediate
%    widths, signedness and compiler behavior, then compare target outputs.
