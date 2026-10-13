# MATLAB 学习与实践库

> 从 MATLAB 基础语法出发，逐步掌握矩阵计算、数据分析、可视化、算法验证，并延伸到信号处理、控制系统、Simulink 与工程代码生成。

![MATLAB](Imge/CH000/Banner.jpg)

## 学习入口

| 入口 | 内容 | 适合场景 |
|---|---|---|
| [学习路线与实践计划](StudyPlan.md) | 分阶段路线、每周执行法、自测清单、项目练习 | 规划学习、检查进度 |
| [MATLAB 基础教程](Doc/Matlab.md) | 界面、帮助系统、基础语法、数组与绘图 | 查阅已有笔记 |
| [推荐书目](Books/Books.txt) | MATLAB 相关书籍 | 系统阅读与拓展 |
| [函数参考](Src/Function.md) | 常用函数整理 | 编程时快速查询 |
| [GDB / MEX 相关资料](Src/Program/gcc/gdb.md) | 调试与 MEX 扩展相关记录 | MATLAB 与原生代码交互 |

## 学习路线

```mermaid
flowchart LR
    A[环境与帮助] --> B[语言基础]
    B --> C[数组与矩阵]
    C --> D[函数与数据处理]
    D --> E[可视化]
    E --> F[数值计算]
    F --> G[信号处理与控制]
    G --> H[Simulink]
    H --> I[工程验证与代码生成]
```

## 推荐实践方向

- **科学计算**：矩阵运算、数值方法、数据拟合与优化。
- **数据分析**：文件导入、清洗、统计、可视化和报告生成。
- **信号处理**：采样、滤波、FFT、传感器数据分析。
- **控制系统**：系统响应、控制器参数分析与 Simulink 仿真。
- **嵌入式算法验证**：建立 MATLAB 参考模型，与 C 实现进行输入输出对比。

## 学习原则

1. 每个知识点都配套可运行示例，不只堆积概念。
2. 每个算法都记录输入、输出、假设、边界条件和验证方法。
3. 优先使用向量化表达，但以可读性和正确性为先。
4. 涉及版本差异或工具箱依赖时，在示例中明确标注。
5. 项目应尽量做到可复现：提供运行步骤、测试数据和预期结果。

## 官方资料

- [MATLAB 官方文档](https://www.mathworks.com/help/matlab/)
- [MATLAB 入门教程](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html)
- [Simulink 官方文档](https://www.mathworks.com/help/simulink/)

> 旧资料中部分内容基于 MATLAB R2018b。请以实际安装版本的官方文档为准，并在学习过程中逐步补齐代码示例、测试和项目练习。
