# MATLAB Environment and Engineering Workflow

> Audience: beginners through embedded and algorithm engineers. This guide focuses on a reproducible setup rather than a particular MATLAB release.

## Learning outcomes

- Navigate the Command Window, Editor, Workspace, Current Folder, and figure windows.
- Diagnose path and dependency problems.
- Create a repeatable project layout and capture environment information.
- Distinguish MATLAB language features from optional toolbox features.

## 1. The desktop at a glance

| Area | Purpose | Useful habit |
|---|---|---|
| Command Window | Execute commands interactively | Use for small probes and diagnosis |
| Editor | Write scripts and functions | Save code before running it |
| Workspace | Inspect current variables | Check type, size, and unexpected state |
| Current Folder | Browse project files | Keep inputs and outputs inside a project |
| Figures | Inspect visual results | Label axes and export meaningful plots |

## 2. Essential diagnostic commands

```matlab
pwd                 % current working directory
dir                 % files in the current directory
which mean -all     % all resolved implementations of mean
help mean
doc mean
version
ver                 % installed products/toolboxes
computer
path
```

If MATLAB runs the wrong function, first inspect `which functionName -all`. A user file with the same name as a built-in function can shadow it. Rename the conflicting file and recheck the path.

## 3. Paths and project portability

Avoid machine-specific absolute paths such as `C:\Users\...\Desktop\...`. Prefer paths relative to the project root:

```matlab
projectRoot = pwd;
dataFile = fullfile(projectRoot, "data", "sensor.csv");
assert(isfile(dataFile), "Input file not found: %s", dataFile);
```

When the working directory is not guaranteed to be the project root, derive paths from the current script location where supported by your MATLAB version, or provide a documented project entry script.

## 4. Reproducible environment report

Save as `environment_report.m`:

```matlab
fprintf("MATLAB version: %s\n", version);
fprintf("Platform: %s\n", computer);
fprintf("Working directory: %s\n", pwd);
disp("Installed products:");
ver
```

For team projects, also record required toolboxes, operating system, input data provenance, random seeds, and expected output tolerances. Do not assume that a function is available just because it exists on another machine.

## 5. A recommended project layout

```text
my-matlab-project/
├── README.md
├── data/             # immutable input data or small fixtures
├── src/              # reusable functions
├── scripts/          # entry points and experiments
├── tests/            # automated checks
├── results/          # generated outputs; document how to recreate
└── docs/             # assumptions, diagrams, and experiment notes
```

Separate reusable logic from one-off exploration. Never silently overwrite source data with cleaned output.

## 6. Troubleshooting checklist

1. Read the complete error message and identify the first relevant stack frame.
2. Check the current folder with `pwd`.
3. Check name resolution with `which name -all`.
4. Inspect inputs using `class`, `size`, `numel`, `isfinite`.
5. Reduce the failing case to the smallest reproducible example.
6. Verify the fix against both a normal case and a boundary case.

## Practice

- [ ] Run every diagnostic command above and record its output.
- [ ] Create a project-relative path and deliberately test a missing file.
- [ ] Create a same-named helper file in a temporary folder; inspect how it affects `which`, then remove the conflict.
- [ ] Write a short README explaining how another person can run your project.

## Related pages

- [Learning plan](../StudyPlan.md)
- [Main tutorial](Matlab.md)
- [MATLAB Basics: 100 Questions](../Questions/Matlab-Basics-100.md)
- [Runnable examples](../Src/Examples/README.md)
