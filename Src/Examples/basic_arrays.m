%% MATLAB 基础示例：数组、逻辑索引、统计与绘图
% 在 MATLAB 中运行本脚本。只使用基础 MATLAB 功能。

clear; clc; close all;

% 1. 创建一组模拟传感器采样值
Fs = 100;                         % 采样率，Hz
N = 500;
t = (0:N-1) / Fs;                 % 时间轴，秒
signal = 20 + 2*sin(2*pi*1.5*t) + 0.25*cos(2*pi*12*t);

% 2. 注入一个超限样本，演示逻辑索引
signal(120) = 26.5;
limit = 24;
overLimitMask = signal > limit;
overLimitIndex = find(overLimitMask);

% 3. 统计量
stats.mean = mean(signal);
stats.minimum = min(signal);
stats.maximum = max(signal);
stats.overLimitCount = nnz(overLimitMask);

fprintf('Mean: %.3f\n', stats.mean);
fprintf('Min: %.3f\n', stats.minimum);
fprintf('Max: %.3f\n', stats.maximum);
fprintf('Over-limit samples: %d\n', stats.overLimitCount);
fprintf('First over-limit indices: ');
disp(overLimitIndex(1:min(5, numel(overLimitIndex))));

% 4. 绘图并标注单位
figure('Name', 'Basic sensor data example');
plot(t, signal, 'DisplayName', 'Sensor signal');
hold on;
yline(limit, '--', 'Limit', 'DisplayName', 'Threshold');
plot(t(overLimitMask), signal(overLimitMask), 'ro', ...
    'DisplayName', 'Over-limit samples');
hold off;
grid on;
xlabel('Time (s)');
ylabel('Measurement (unit)');
title('Sensor data: indexing and statistics');
legend('Location', 'best');

% 5. 尺寸检查：时间轴与信号必须一一对应
assert(numel(t) == numel(signal), 'Time and signal lengths must match.');
