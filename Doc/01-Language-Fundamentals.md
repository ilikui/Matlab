# MATLAB Language Fundamentals

## 1. Variables and types

MATLAB creates or updates a variable through assignment. The value determines its type unless you explicitly convert it.

```matlab
temperature = 23.5;          % double by default
sampleCount = uint16(120);    % unsigned integer
enabled = true;               % logical
label = 'sensor_A';            % character vector
message = "sensor online";    % string (newer releases)
payload = {1, "left", true};  % cell array
sensor.id = 7;                % structure field
```

Use `class(x)`, `size(x)`, `numel(x)`, and `whos` to inspect data. Choose a type based on range, precision, memory, and interfaces—not merely habit.

## 2. Operators: matrix versus element-wise

```matlab
A = [1 2; 3 4];
B = [10 20; 30 40];

C1 = A * B;    % matrix multiplication
C2 = A .* B;   % element-wise multiplication
C3 = A .^ 2;   % square each element
```

The dimensions must satisfy the mathematical rules for matrix multiplication. Element-wise operations require compatible array sizes; implicit expansion depends on MATLAB release. When portability matters, explicitly check dimensions.

## 3. Indexing and logical masks

MATLAB indexing starts at 1 and linear indexing follows column-major order.

```matlab
A = [10 20 30; 40 50 60];
firstColumn = A(:, 1);
secondRow = A(2, :);
linearSecond = A(2);       % 40, column-major order

x = [2 5 8 11 14];
mask = x >= 8;
selected = x(mask);        % [8 11 14]
indices = find(mask);      % [3 4 5]
```

Use logical masks when the intent is to select values; use `find` when index positions themselves are needed.

## 4. Control flow

```matlab
score = 82;
if score >= 90
    grade = "A";
elseif score >= 80
    grade = "B";
else
    grade = "Needs review";
end

total = 0;
for k = 1:10
    total = total + k;
end

while total < 100
    total = total + 1;
end
```

Prefer vectorized operations when they make intent clearer, but do not sacrifice correctness or readability merely to remove a loop.

## 5. Missing, invalid, and non-finite values

```matlab
x = [1 NaN 3 Inf -Inf];
nanMask = isnan(x);
finiteMask = isfinite(x);
valid = x(finiteMask);
```

Missing data is a domain decision. Replacing `NaN` with zero may bias statistics or alter a signal. Document whether invalid values are rejected, removed, interpolated, or preserved.

## 6. Floating-point comparisons

Many decimal fractions cannot be represented exactly in binary floating point.

```matlab
a = 0.1 + 0.2;
b = 0.3;
isEqual = (a == b);                 % may be false
isClose = abs(a - b) <= 1e-12;      % tolerance must fit the problem
```

A tolerance should come from the scale, units, and error budget of the problem. For vectors, use a norm or maximum absolute error and report the chosen tolerance.

## 7. Exercises

1. Build a vector from 0 to 100 and select all values divisible by 7.
2. Given a matrix, return its row sums, column means, and elements above a threshold.
3. Create a function that validates a vector is numeric, real, nonempty, and finite.
4. Demonstrate the difference between `'` and `.'` using a complex-valued matrix.
5. Test empty arrays, scalar inputs, `NaN`, `Inf`, and incompatible dimensions.

## Completion criteria

- You can predict the output dimensions before running code.
- You can explain each use of `*`, `.*`, `^`, and `.^`.
- You can choose an explicit policy for invalid data.
- You can reduce a failure to a small, repeatable test.

## Related pages

- [MATLAB Basics: 100 Questions](../Questions/Matlab-Basics-100.md)
- [Arrays and matrix operations](02-Arrays-Matrices.md)
- [Learning plan](../StudyPlan.md)
