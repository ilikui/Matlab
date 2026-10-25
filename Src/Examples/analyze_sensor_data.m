function result = analyze_sensor_data(time, signal, options)
%ANALYZE_SENSOR_DATA Basic sensor time-series analysis without toolboxes.
arguments
    time (:,1) double {mustBeFinite,mustBeNonempty}
    signal (:,1) double {mustBeFinite,mustBeNonempty}
    options.WindowSize (1,1) double {mustBeInteger,mustBePositive} = 5
    options.OutlierThreshold (1,1) double {mustBePositive} = 3.5
end
if numel(time) ~= numel(signal), error('analyze_sensor_data:LengthMismatch','TIME and SIGNAL must have equal lengths.'); end
if numel(time) < 3, error('analyze_sensor_data:TooFewSamples','At least 3 samples are required.'); end
if any(diff(time) <= 0), error('analyze_sensor_data:NonIncreasingTime','TIME must be strictly increasing.'); end
windowSize = min(options.WindowSize,numel(signal));
center = median(signal); madValue = median(abs(signal-center));
if madValue == 0
    robustScore = zeros(size(signal)); robustScore(signal ~= center) = Inf;
else
    robustScore = abs(signal-center)./(1.4826*madValue);
end
outlierMask = robustScore > options.OutlierThreshold;
smoothed = movmean(signal,windowSize);
result = struct('time',time,'raw',signal,'smoothed',smoothed, ...
    'outlierMask',outlierMask,'robustScore',robustScore, ...
    'stats',struct('count',numel(signal),'mean',mean(signal), ...
    'median',median(signal),'std',std(signal),'min',min(signal), ...
    'max',max(signal),'outlierCount',nnz(outlierMask)));
end
