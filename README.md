<!--
  MATLAB Learning & Engineering Practice
  A structured, hands-on repository for numerical computing and algorithm validation.
-->

<div align="center">

# MATLAB · Learning & Engineering Lab

**From mathematical fundamentals to reproducible experiments and engineering-grade algorithm validation.**

[![MATLAB](https://img.shields.io/badge/MATLAB-Scientific%20Computing-orange?style=flat-square&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Learning Path](https://img.shields.io/badge/Learning-Structured-blue?style=flat-square)](StudyPlan.md)
[![Examples](https://img.shields.io/badge/Examples-Hands--on-success?style=flat-square)](Src/Examples/README.md)
[![Documentation](https://img.shields.io/badge/Docs-Mermaid%20%2B%20Markdown-7B68EE?style=flat-square)](https://mermaid.js.org/)

<br/>

![MATLAB Learning Banner](Imge/CH000/Banner.jpg)

*Learn the language. Understand the mathematics. Validate the algorithm. Make the result reproducible.*

</div>

---

## Overview

This repository is a structured learning and practice space for **MATLAB programming, scientific computing, data analysis, signal processing, control-system exploration, and embedded-algorithm verification**.

It combines progressive learning notes, a staged study plan, a question-driven knowledge base, reusable examples, and engineering-oriented validation exercises. The aim is not merely to collect syntax, but to build a workflow that moves from understanding a concept to implementing it, testing it, and explaining its limitations.

> **Learning principle:** Every important concept should lead to an experiment; every algorithm should have explicit assumptions, boundary conditions, and a way to verify its results.

## Start Here

| If you want to… | Start with | What you will find |
|---|---|---|
| Plan a complete learning journey | [Study Plan](StudyPlan.md) | Stages, weekly practice, checkpoints, and projects |
| Learn MATLAB fundamentals | [MATLAB Tutorial](Doc/Matlab.md) | Environment, syntax, arrays, matrices, and plotting |
| Practice through focused questions | [MATLAB Basics — 100 Questions](Questions/Matlab-Basics-100.md) | Topic-based questions, explanations, and examples |
| Run and inspect practical code | [Examples & Tests](Src/Examples/README.md) | Filtering, interpolation, Kalman filtering, FFT, quantization, and MATLAB/C comparisons |
| Look up commonly used functions | [Function Reference](Src/Function.md) | A practical function index |
| Explore recommended reading | [Books](Books/Books.txt) | Books and further learning resources |
| Study native-code integration and debugging | [GDB / MEX Notes](Src/Program/gcc/gdb.md) | Related notes for debugging and native-code workflows |

## Learning Architecture

The repository is organized around a progression from fundamentals to applied engineering. Follow the full route, or jump into an individual topic when you need a targeted reference.

```mermaid
flowchart TD
    A["01 · Environment & Help"] --> B["02 · Language Fundamentals"]
    B --> C["03 · Arrays & Matrix Computing"]
    C --> D["04 · Functions & Data Processing"]
    D --> E["05 · Visualization & Reporting"]
    E --> F["06 · Numerical Methods"]
    F --> G["07 · Signal Processing"]
    F --> H["08 · Control Systems"]
    G --> I["09 · Algorithm Modeling"]
    H --> I
    I --> J["10 · Simulink & System Simulation"]
    J --> K["11 · MATLAB / C Cross-Validation"]
    K --> L["12 · Reproducible Engineering Practice"]
```

### Core Knowledge Areas

<div align="center">

| Fundamentals | Modeling & Analysis | Engineering Practice |
|:---:|:---:|:---:|
| Syntax, arrays, matrices | Numerical computation | Testable examples |
| Functions, scripts, data types | Filtering and FFT | Boundary-condition checks |
| Plotting and visualization | Interpolation and Kalman filters | MATLAB/C comparison |
| Tables, files, and data handling | Control-system exploration | Reproducible results |

</div>

## Practical Workbench

The [examples directory](Src/Examples/README.md) is the recommended starting point for hands-on practice.

| Topic | Practice focus |
|---|---|
| Arrays and statistics | Data construction, indexing, and summary operations |
| Low-pass filtering | Signal smoothing and response inspection |
| Linear interpolation | Interpolation behavior and input constraints |
| Kalman filtering | One-dimensional and position–velocity estimation |
| Sensor data and FFT | Outlier inspection and frequency-domain analysis |
| Fixed-point quantization | Quantization error and numerical representation |
| MATLAB / C comparison | Reference behavior, output comparison, and regression checks |

### A Typical Algorithm-Validation Workflow

```mermaid
flowchart LR
    A["Define the problem"] --> B["Document assumptions"]
    B --> C["Build MATLAB reference"]
    C --> D["Create test vectors"]
    D --> E["Check normal & boundary cases"]
    E --> F["Compare outputs"]
    F --> G{"Within tolerance?"}
    G -- Yes --> H["Record results"]
    G -- No --> I["Investigate the difference"]
    I --> C
    H --> J["Regression test"]
```

For embedded or performance-sensitive algorithms, MATLAB can serve as a readable reference model before comparing a C implementation. Define numeric precision, units, initial conditions, saturation behavior, and tolerances explicitly; matching plots alone is not sufficient evidence of equivalence.

## Recommended Study Method

1. **Understand** — Read the concept and identify the mathematical or programming principle.
2. **Implement** — Write a small example that can be run independently.
3. **Visualize** — Plot intermediate and final results to make behavior observable.
4. **Challenge** — Test empty inputs, boundary values, unexpected dimensions, and noisy data where applicable.
5. **Compare** — Validate against a known result, a reference implementation, or a documented expectation.
6. **Record** — Keep the assumptions, execution steps, expected output, and conclusions with the code.

## Quick Start

1. Install MATLAB, or use an available MATLAB environment compatible with the examples.
2. Clone or download this repository.
3. Open the repository in MATLAB and navigate to the relevant example directory.
4. Read the example's instructions before running it; check any toolbox or version requirements.
5. Run the script or function and compare the result with the documented expectation.

```bash
git clone https://github.com/ilikui/Matlab.git
cd Matlab
```

Start with [the examples guide](Src/Examples/README.md) for the most direct route to executable practice.

> **Compatibility note:** Some legacy notes may target MATLAB R2018b or depend on specific toolboxes. The installed MATLAB release and its official documentation take precedence. Check each example's requirements before execution.

## Repository Map

```text
Matlab/
├── README.md                 # Project overview and navigation
├── StudyPlan.md              # Structured learning roadmap
├── Doc/                      # Tutorials and conceptual notes
├── Questions/                # Question-driven practice
├── Src/
│   ├── Examples/             # Runnable examples and validation exercises
│   ├── Function.md           # Function reference
│   └── Program/              # Native-code and debugging notes
├── Books/                    # Recommended reading
└── Imge/                     # Learning and documentation images
```

The tree above highlights the main entry points; consult the repository directories for the complete and current file list.

## Official Resources

- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [Get Started with MATLAB](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html)
- [Simulink Documentation](https://www.mathworks.com/help/simulink/)
- [MATLAB Examples](https://www.mathworks.com/help/matlab/examples.html)
- [MATLAB Answers](https://www.mathworks.com/matlabcentral/answers/)

## Contributing & Continuous Improvement

Learning material is most useful when it is clear, testable, and maintainable. Improvements are welcome in the form of corrected explanations, runnable examples, better visualizations, additional exercises, and reproducible validation cases.

When adding an example, aim to include:

- **Purpose:** the problem the example demonstrates.
- **Requirements:** MATLAB release and toolbox dependencies, if any.
- **Inputs and outputs:** expected shapes, units, and data types.
- **Execution:** clear steps to run the example.
- **Validation:** expected behavior, tolerances, and edge cases.
- **Limitations:** assumptions and known constraints.

## License

See [LICENSE](LICENSE) for the license terms applicable to this repository.

---

<div align="center">

**Understand the math. Write the model. Verify the result.**

*An evolving, practical reference for MATLAB learning and engineering exploration.*

</div>

## Documentation Library

The repository now includes focused guides that can be read independently or followed in order.

| Guide | What it covers |
|---|---|
| [Environment & Workflow](Doc/00-Environment-and-Workflow.md) | Paths, diagnostics, reproducible project setup |
| [Language Fundamentals](Doc/01-Language-Fundamentals.md) | Types, operators, indexing, control flow |
| [Arrays & Matrices](Doc/02-Arrays-Matrices.md) | Dimensions, matrix algebra, data containers |
| [Functions & Testing](Doc/03-Functions-and-Testing.md) | Contracts, validation, regression tests |
| [Data & Visualization](Doc/04-Data-and-Visualization.md) | Import, cleaning, statistics, plots, export |
| [Numerical Methods](Doc/05-Numerical-Methods.md) | Solvers, interpolation, error metrics |
| [Signal, Control & Embedded](Doc/06-Signal-Control-and-Embedded.md) | FFT, filters, Kalman models, MATLAB/C handoff |
| [Engineering Project Portfolio](Doc/07-Project-Portfolio.md) | Progressive practical projects |
| [Practice Labs](Questions/MATLAB-Practice-Labs.md) | Ten hands-on labs with acceptance criteria |
| [Function Index](Src/Function.md) | Searchable reference to common functions |

## Expanded Learning Resources

To make the repository easier to use as a complete curriculum, two practical indexes are available:

| Resource | Purpose |
|---|---|
| [Advanced MATLAB — 100 Questions](Questions/MATLAB-Advanced-100.md) | Deepen understanding of array semantics, debugging, data quality, numerical methods, signal processing, testing, and algorithm delivery |
| [Engineering Project Roadmap](Projects/README.md) | Turn concepts into portfolio projects with clear deliverables and acceptance criteria |

### Suggested Route: Learn → Practice → Verify → Deliver

```mermaid
flowchart LR
    A[Read a concept] --> B[Run a minimal example]
    B --> C[Change inputs and test boundaries]
    C --> D[Measure error and performance]
    D --> E[Document assumptions and results]
    E --> F[Package as a reproducible project]
```

### What to Add When Contributing

- **Learning notes:** explain the concept, common mistakes, and version-specific behavior.
- **Runnable code:** avoid hidden workspace dependencies; include sample inputs or a deterministic data generator.
- **Tests:** cover nominal, boundary, invalid-input, and numerical-tolerance cases.
- **Evidence:** provide expected output, plots, error metrics, or a reference comparison.
- **Navigation:** link the new material from the relevant tutorial, example index, or question bank.

These resources complement the existing [study plan](StudyPlan.md), [practice labs](Questions/MATLAB-Practice-Labs.md), and [executable examples](Src/Examples/README.md).


## Advanced Practice & Project Portfolio

For the next step beyond the core tutorial, use the focused advanced question bank and the project-first practice guide:

- [MATLAB Advanced — 100 Questions](Questions/MATLAB-Advanced-100.md): language semantics, debugging, data workflows, numerical methods, signal/control, and engineering delivery.
- [Project Portfolio & Acceptance Criteria](Projects/README.md): progressively build data-cleaning, interpolation, FFT, filtering, Kalman, control, and MATLAB/C validation projects.
- [Standalone FFT Demo](Src/Examples/signal_fft_demo.m): a minimal frequency-domain example.
- [Standalone Kalman Demo](Src/Examples/kalman_1d_demo.m): a minimal state-estimation example.
- [Smoke Tests](Tests/run_smoke_tests.m): small checks for interpolation, FFT peak detection, and Kalman recursion.

```mermaid
flowchart LR
    A[Read concept] --> B[Run example]
    B --> C[Change input and parameters]
    C --> D[Run tests]
    D --> E[Document assumptions and error]
    E --> F[Extend into a project]
```

The standalone demonstrations are educational starting points. Their presence does not imply they have been executed on every MATLAB release or validated for production use; run the tests in your own environment and adapt assumptions to the target application.
