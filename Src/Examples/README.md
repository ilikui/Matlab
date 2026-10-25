# MATLAB 可运行示例

本目录将概念笔记转化为可执行的 MATLAB 文件。建议从仓库根目录打开 MATLAB，再按下表运行示例。

## 示例目录

| 文件 | 主题 | 运行方式 |
|---|---|---|
| [basic_arrays.m](basic_arrays.m) | 数组、逻辑索引、统计与绘图 | `run('Src/Examples/basic_arrays.m')` |
| [lowpass_filter.m](lowpass_filter.m) | 一阶低通滤波函数 | 见下方调用示例 |
| [linear_interp_checked.m](linear_interp_checked.m) | 带输入校验的分段线性插值 | 见下方调用示例 |
| [kalman_1d.m](kalman_1d.m) | 一维随机游走模型的 Kalman 滤波 | 见下方调用示例 |
| [kalman_position_velocity.m](kalman_position_velocity.m) | 位置/速度二维状态 Kalman 滤波 | 见下方调用示例 |
| [sensor_signal_analysis.m](sensor_signal_analysis.m) | MAD 异常点候选、移动平均、FFT 频谱 | `run('Src/Examples/sensor_signal_analysis.m')` |
| [compare_fixed_point.m](compare_fixed_point.m) | 量化、饱和与误差指标 | `run('Src/Examples/compare_fixed_point.m')` |
| [compare_reference_outputs.m](compare_reference_outputs.m) | MATLAB 参考输出与候选输出对比 | 见下方调用示例 |
| [compare_lowpass_c.m](compare_lowpass_c.m) | MATLAB 与独立 C 低通实现对比 | 见下方 C 对比流程 |
| [compare_interpolation_c.m](compare_interpolation_c.m) | MATLAB 与独立 C 线性插值实现对比 | 见下方插值对比流程 |
| [test_compare_reference_outputs.m](test_compare_reference_outputs.m) | 参考输出对比函数的回归测试 | `run('Src/Examples/test_compare_reference_outputs.m')` |
| [test_interpolation.m](test_interpolation.m) | 插值端点、形状和非法输入测试 | `run('Src/Examples/test_interpolation.m')` |
| [test_kalman_position_velocity.m](test_kalman_position_velocity.m) | 位置/速度 Kalman 测试 | `run('Src/Examples/test_kalman_position_velocity.m')` |
| [run_tests.m](run_tests.m) | 核心算法的简单回归测试 | `run('Src/Examples/run_tests.m')` |
| [run_all_tests.m](run_all_tests.m) | 统一运行全部测试脚本 | `run('Src/Examples/run_all_tests.m')` |

## 运行示例函数

先把目录加入路径：

```matlab
addpath(fullfile(pwd, 'Src', 'Examples'));

% 一阶低通：alpha 越小，平滑越强，响应越慢
x = [0 0 1 1 1 0 0];
y = lowpass_filter(x, 0.25);

% 插值：采样点必须严格递增
xTable = [0 1 2 3];
yTable = [0 10 20 30];
yq = linear_interp_checked(xTable, yTable, [0.5 1.5 2.5]);

% Kalman：观测为位置，状态采用随机游走模型
z = [10.2 9.8 10.4 10.1 9.9];
[xhat, P] = kalman_1d(z, 0.05, 0.5, 10, 1);

% 位置/速度状态模型：dt 为采样周期，状态为 [位置; 速度]
t = 0:0.1:5;
zPosition = 2 + 1.5*t + 0.1*sin(2*pi*t);
[xState, covariance] = kalman_position_velocity( ...
    zPosition, 0.1, 0.05, 0.04, [2; 1], eye(2));
positionEstimate = xState(1,:);
velocityEstimate = xState(2,:);
```

## MATLAB 与 C 低通滤波对比

目录 [c_reference](c_reference/) 包含不依赖 MATLAB 的 C 低通滤波参考实现、命令行 CSV runner 和独立测试。

使用 GCC 或 Clang，在仓库根目录编译并运行 C 测试：

```sh
cc -std=c99 -Wall -Wextra -Wpedantic -O2 \
  Src/Examples/c_reference/lowpass_ref.c \
  Src/Examples/c_reference/test_lowpass_ref.c -lm -o lowpass_test
./lowpass_test

cc -std=c99 -Wall -Wextra -Wpedantic -O2 \
  Src/Examples/c_reference/lowpass_ref.c \
  Src/Examples/c_reference/lowpass_cli.c -lm -o lowpass_cli
```

Windows 若使用 MinGW-w64，可把输出文件名改为 `lowpass_test.exe` 和 `lowpass_cli.exe`。也可在其他 C99 兼容编译器下编译。编译器必须支持标准数学库。

然后在 MATLAB 中指定可执行程序路径：

```matlab
addpath(fullfile(pwd, 'Src', 'Examples'));
report = compare_lowpass_c(fullfile(pwd, 'lowpass_cli'), 1e-10);
disp(report);
assert(report.pass, 'MATLAB and C outputs exceed tolerance.');
```

在 Windows 上将路径末尾改为 `lowpass_cli.exe`。比较工具会生成临时 CSV 输入文件，运行 C 程序，读取结果并计算误差；临时文件会在函数结束时清理。若命令行工具运行失败，函数会报告非零退出码和命令输出。

该流程比较的是相同递推公式在双精度浮点数下的结果，不代表已经验证定点实现、目标 MCU 编译器行为、实时性或硬件传感器链路。

## MATLAB 与 C 线性插值对比

C 参考实现位于 [c_reference/linear_interp_ref.c](c_reference/linear_interp_ref.c)，包含严格递增表格检查、有限值检查、查询范围检查和二分查找。查询点可以乱序；表格范围外的查询会返回错误，不执行外推。

在仓库根目录编译并运行独立 C 测试与命令行工具：

```sh
cc -std=c99 -Wall -Wextra -Wpedantic -O2 \
  Src/Examples/c_reference/linear_interp_ref.c \
  Src/Examples/c_reference/test_linear_interp_ref.c -lm -o interp_test
./interp_test

cc -std=c99 -Wall -Wextra -Wpedantic -O2 \
  Src/Examples/c_reference/linear_interp_ref.c \
  Src/Examples/c_reference/linear_interp_cli.c -lm -o linear_interp_cli
```

命令行输入格式：表格 CSV 每行两列 `x,y`；查询 CSV 每行一个查询值；输出 CSV 每行一个插值结果。然后在 MATLAB 中执行：

```matlab
addpath(fullfile(pwd, 'Src', 'Examples'));
report = compare_interpolation_c(fullfile(pwd, 'linear_interp_cli'), 1e-10);
disp(report);
assert(report.pass, 'MATLAB and C interpolation outputs exceed tolerance.');
```

Windows 下请使用 `linear_interp_cli.exe` 等对应可执行文件名。该对比脚本会使用不等间距查表点及乱序查询值，并清理临时 CSV。当前测试覆盖端点、分段插值、乱序查询、重复节点、非有限表值、越界查询及空查询列表。

## 参考输出与 C 算法对比

将 MATLAB 参考输出和从 C 程序导出的候选输出整理为相同尺寸的数值数组：

```matlab
addpath(fullfile(pwd, 'Src', 'Examples'));
reference = [0.1 0.2 0.3 0.4];
candidate = [0.1 0.1999 0.3002 0.4];
report = compare_reference_outputs(reference, candidate, 1e-3);
disp(report);
```

报告包含最大绝对误差、RMSE、超出容差的样本数和是否通过。示例使用绝对容差；量纲不同或参考值接近零时，应依据项目需求增加相对误差或逐信号容差。

## 约定与限制

- 这些示例使用 MATLAB 基础语法，不依赖额外工具箱。
- 输入校验不代表适用于所有工程需求；正式工程仍需定义单位、量程、采样周期和错误处理策略。
- `lowpass_filter` 的 `alpha` 是离散递推系数，不是以 Hz 表示的截止频率。
- `linear_interp_checked` 默认拒绝表格范围外的查询值，不做外推。
- `kalman_1d` 使用一维随机游走状态模型，过程噪声与测量噪声方差必须非负，不能替代完整的传感器建模与验证。
- `kalman_position_velocity` 使用常速度状态转移模型，输入为位置测量，输出状态为位置和速度；所有单位、采样周期和噪声方差必须一致。
- `run_all_tests.m` 统一运行现有测试脚本。它报告的是脚本是否执行到末尾，并不替代目标 MATLAB 版本和目标平台上的验证。
- `sensor_signal_analysis.m` 的 MAD 检测用于演示鲁棒异常点候选识别；实际阈值应根据数据分布和误报成本标定。
- `compare_fixed_point.m` 仅模拟量化和饱和；实际 C 实现还需核对有符号类型、移位、舍入、溢出和中间结果位宽。
- `compare_lowpass_c.m` 和 `compare_interpolation_c.m` 都需要先用 C99 编译器构建各自的命令行程序；MATLAB 函数本身不会自动编译 C 文件。

## 学习建议

1. 先运行原始示例，观察输出。
2. 改变输入数据、参数和边界值。
3. 阅读函数的输入校验与状态更新逻辑。
4. 运行 `run_tests.m`，再为新增行为补充测试。
5. 对工程算法记录参考结果、误差指标和适用范围。


## Additional Standalone Demonstrations

| File | Focus | Run |
|---|---|---|
| [signal_fft_demo.m](signal_fft_demo.m) | FFT amplitude spectrum and dominant-frequency identification | `run('Src/Examples/signal_fft_demo.m')` |
| [kalman_1d_demo.m](kalman_1d_demo.m) | A self-contained 1-D Kalman filter with RMSE reporting | `run('Src/Examples/kalman_1d_demo.m')` |
| [run_smoke_tests.m](../../../Tests/run_smoke_tests.m) | Lightweight checks for interpolation, FFT peak detection, and Kalman recursion | `addpath('Tests'); run_smoke_tests` |

These additions complement, rather than replace, the existing examples and the broader `run_all_tests.m` suite. They are designed to be small entry points for readers who want to understand an algorithm before exploring the more complete implementations above. The smoke tests use MATLAB base functionality; run them in your installed MATLAB version before relying on the results in an engineering workflow.


## Sensor Time-Series Mini Project

![Sensor Time-Series Analysis Workflow](../../Imge/Sensor-Analysis-Workflow.svg)

- [sensor_analysis_project.m](sensor_analysis_project.m) generates repeatable synthetic sensor data, injects an abnormal sample, plots raw and smoothed signals, and marks robust outlier candidates.
- [analyze_sensor_data.m](analyze_sensor_data.m) is the reusable analysis function. It validates vector lengths and monotonic time, computes moving-average smoothing, reports descriptive statistics, and flags candidate outliers using a median absolute deviation (MAD)-based score.
- [test_sensor_analysis_project.m](../../../Tests/test_sensor_analysis_project.m) contains function-based tests for output shape/statistics, outlier detection, non-increasing timestamps, and mismatched input lengths.

Run from the repository root:

```matlab
addpath('Src/Examples');
run('Src/Examples/sensor_analysis_project.m');
results = runtests('Tests/test_sensor_analysis_project.m');
disp(results);
assert(all([results.Passed]), 'One or more sensor-analysis tests failed.');
```

This project intentionally generates its own data, so no external CSV is required. MAD flags are statistical candidates rather than confirmed faults; validate thresholds against sensor physics, operating modes, and representative measurements.
