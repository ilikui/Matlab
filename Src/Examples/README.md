# MATLAB 可运行示例

本目录将概念笔记转化为可执行的 MATLAB 文件。建议从仓库根目录打开 MATLAB，再按下表运行示例。

## 示例目录

| 文件 | 主题 | 运行方式 |
|---|---|---|
| [basic_arrays.m](basic_arrays.m) | 数组、逻辑索引、统计与绘图 | `run('Src/Examples/basic_arrays.m')` |
| [lowpass_filter.m](lowpass_filter.m) | 一阶低通滤波函数 | 见下方调用示例 |
| [linear_interp_checked.m](linear_interp_checked.m) | 带输入校验的分段线性插值 | 见下方调用示例 |
| [kalman_1d.m](kalman_1d.m) | 一维随机游走模型的 Kalman 滤波 | 见下方调用示例 |
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

## 约定与限制

- 这些示例使用 MATLAB 基础语法，不依赖额外工具箱。
- 输入校验不代表适用于所有工程需求；正式工程仍需定义单位、量程、采样周期和错误处理策略。
- `lowpass_filter` 的 `alpha` 是离散递推系数，不是以 Hz 表示的截止频率。
- `linear_interp_checked` 默认拒绝表格范围外的查询值，不做外推。
- `kalman_1d` 使用一维随机游走状态模型，过程噪声与测量噪声方差必须非负，不能替代完整的传感器建模与验证。

## 学习建议

1. 先运行原始示例，观察输出。
2. 改变输入数据、参数和边界值。
3. 阅读函数的输入校验与状态更新逻辑。
4. 运行 `run_tests.m`，再为新增行为补充测试。
5. 对工程算法记录参考结果、误差指标和适用范围。
