%% Sensor time-series mini project
% Toolbox-free example: synthetic sensor data, outlier candidates, smoothing.
clear; clc; close all; rng(21);
addpath(fileparts(mfilename('fullpath')));
fs = 20; time = (0:1/fs:30)';
truth = 25 + 0.8*sin(2*pi*0.25*time) + 0.2*sin(2*pi*0.05*time);
signal = truth + 0.18*randn(size(time)); signal(180) = signal(180)+2.5;
result = analyze_sensor_data(time,signal,'WindowSize',9,'OutlierThreshold',3.5);
fprintf('Samples: %d\n',result.stats.count);
fprintf('Mean: %.4f; standard deviation: %.4f\n',result.stats.mean,result.stats.std);
fprintf('Outlier candidates: %d\n',result.stats.outlierCount);
figure('Name','Sensor analysis project','Color','w');
plot(time,signal,'.','DisplayName','Raw measurement'); hold on;
plot(time,result.smoothed,'LineWidth',1.5,'DisplayName','Moving average');
plot(time(result.outlierMask),signal(result.outlierMask),'ro','MarkerSize',8,'LineWidth',1.5,'DisplayName','Outlier candidate');
grid on; xlabel('Time (s)'); ylabel('Sensor value'); legend('Location','best'); title('Sensor time-series analysis');
% Outlier flags are candidates, not proof of sensor failure. Validate against physical limits.
