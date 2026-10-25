function tests = test_sensor_analysis_project
tests = functiontests(localfunctions);
end
function testOutputShapeAndStats(testCase)
t = (0:9)'; x = 2*t; r = analyze_sensor_data(t,x,'WindowSize',3);
verifySize(testCase,r.smoothed,size(x)); verifyEqual(testCase,r.stats.count,10);
verifyEqual(testCase,r.stats.mean,mean(x),'AbsTol',1e-12); verifyEqual(testCase,r.stats.outlierCount,0);
end
function testInjectedOutlierIsFlagged(testCase)
t = (0:19)'; x = sin(t/3); x(11) = x(11)+10;
r = analyze_sensor_data(t,x,'OutlierThreshold',3.5); verifyTrue(testCase,r.outlierMask(11));
end
function testRejectsNonIncreasingTime(testCase)
t = [0;1;1;3]; x = [1;2;3;4];
verifyError(testCase,@() analyze_sensor_data(t,x),'analyze_sensor_data:NonIncreasingTime');
end
function testRejectsLengthMismatch(testCase)
verifyError(testCase,@() analyze_sensor_data((1:4)',(1:3)'), 'analyze_sensor_data:LengthMismatch');
end
