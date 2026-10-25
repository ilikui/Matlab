%% One-dimensional Kalman filter demo
% Dependency: MATLAB base functions only.
clear; clc; close all; rng(7);
N = 200; dt = 0.1; time = (0:N-1)'*dt;
truePosition = 0.5*time + 0.8*sin(0.15*time);
measurementStd = 1.2;
measurement = truePosition + measurementStd*randn(N,1);
processVariance = 0.03; measurementVariance = measurementStd^2;
xEstimate = zeros(N,1); pEstimate = zeros(N,1);
xEstimate(1) = measurement(1); pEstimate(1) = 1;
for k = 2:N
    % Prediction
    xPred = xEstimate(k-1); pPred = pEstimate(k-1)+processVariance;
    % Measurement update
    gain = pPred/(pPred+measurementVariance);
    xEstimate(k) = xPred + gain*(measurement(k)-xPred);
    pEstimate(k) = (1-gain)*pPred;
end
rmseMeasurement = sqrt(mean((measurement-truePosition).^2));
rmseEstimate = sqrt(mean((xEstimate-truePosition).^2));
fprintf('Measurement RMSE: %.4f\n',rmseMeasurement);
fprintf('Kalman estimate RMSE: %.4f\n',rmseEstimate);
figure('Name','1-D Kalman filter','Color','w');
plot(time,truePosition,'k-','LineWidth',1.5); hold on;
plot(time,measurement,'.','MarkerSize',7); plot(time,xEstimate,'b-','LineWidth',1.4);
grid on; xlabel('Time (s)'); ylabel('Position');
legend('Ground truth','Noisy measurement','Kalman estimate','Location','best');
title('One-dimensional Kalman filter');
% Q is model/process uncertainty; R is measurement noise variance.
% Real projects need representative-data tuning and model validation.
