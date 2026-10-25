%% Reproducible CSV sensor-data analysis demo
% Run from the repository root:
%   run('Src/Examples/sensor_csv_demo.m')
% Requires base MATLAB only; the included CSV is synthetic teaching data.
repoRoot = fileparts(fileparts(fileparts(mfilename('fullpath'))));
dataFile = fullfile(repoRoot, 'Data', 'sensor_sample.csv');
if ~isfile(dataFile)
    error('sensor_csv_demo:MissingData', 'Sample CSV not found: %s', dataFile);
end
data = readtable(dataFile);
requiredColumns = {'time_s', 'signal_v'};
if ~all(ismember(requiredColumns, data.Properties.VariableNames))
    error('sensor_csv_demo:InvalidColumns', 'CSV must contain columns time_s and signal_v.');
end
time = data.time_s;
signal = data.signal_v;
result = analyze_sensor_data(time, signal, 'WindowSize', 5, 'OutlierThreshold', 3.5);
fprintf('Samples: %d\n', result.stats.count);
fprintf('Mean: %.5f V | Median: %.5f V | Std: %.5f V\n', result.stats.mean, result.stats.median, result.stats.std);
fprintf('Outlier candidates: %d\n', result.stats.outlierCount);
figure('Name', 'CSV Sensor Analysis', 'Color', 'w');
plot(result.time, result.raw, '.-', 'DisplayName', 'Raw samples'); hold on;
plot(result.time, result.smoothed, 'LineWidth', 1.8, 'DisplayName', 'Moving average');
if any(result.outlierMask)
    plot(result.time(result.outlierMask), result.raw(result.outlierMask), 'ro', ...
        'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Outlier candidates');
end
grid on; xlabel('Time (s)'); ylabel('Signal (V)');
title('Sensor CSV: raw signal, smoothing, and outlier candidates');
legend('Location', 'best');
