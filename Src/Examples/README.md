# MATLAB 可运行示例

本目录将概念笔记转化为可执行的 MATLAB 文件。建议从仓库根目录打开 MATLAB，再按下表运行示例。

## 示例目录

| 文件 | 主题 | 运行方式 |
|---|---|---|
| [basic_arrays.m](basic_arrays.m) | 数组、逻辑索引、统计与绘图 | `run('Src/Examples/basic_arrays.m')` |
| [lowpass_filter.m](lowpass_filter.m) | 一阶低通滤波函数 | 见下方调用示例 |
| [linear_interp_checked.m](linear_interp_checked.m) | 带输入校验的分段线性插值 | 见下方调用示例 |
| [kalman_1d.m](kalman_1d.m) | 一维随机游走模型的 Kalman 滤波 | 见下方调用示例 |
| [sensor_signal_analysis.m](sensor_signal_analysis.m) | MAD 异常点候选、移动平均、FFT 频谱 | `run('Src/Examples/sensor_signal_analysis.m')` |
| [compare_fixed_point.m](compare_fixed_point.m) | 量化、饱和与误差指标 | `run('Src/Examples/compare_fixed_point.m')` |
| [compare_reference_outputs.m](compare_reference_outputs.m) | MATLAB 参考输出与候选输出对比 | 见下方调用示例 |
| [test_compare_reference_outputs.m](test_compare_reference_outputs.m) | 参考输出对比函数的回归测试 | `run('Src/Examples/test_compare_reference_outputs.m')` |
| [run_tests.m](run_tests.m) | 核心算法的简单回归测试 | `run('Src/Examples/run_tests.m')` |

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
```

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
- `sensor_signal_analysis.m` 的 MAD 检测用于演示鲁棒异常点候选识别；实际阈值应根据数据分布和误报成本标定。
- `compare_fixed_point.m` 仅模拟量化和饱和；实际 C 实现还需核对有符号类型、移位、舍入、溢出和中间结果位宽。

## 学习建议

1. 先运行原始示例，观察输出。
2. 改变输入数据、参数和边界值。
3. 阅读函数的输入校验与状态更新逻辑。
4. 运行 `run_tests.m`，再为新增行为补充测试。
5. 对工程算法记录参考结果、误差指标和适用范围。
