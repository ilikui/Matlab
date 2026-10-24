# Arrays, Matrices, and Linear Algebra

Arrays are MATLAB's central data structure. Correct array shape is often as important as the numerical value.

## 1. Construct and inspect arrays

```matlab
row = [1 2 3];
column = [1; 2; 3];
Z = zeros(3, 4);
O = ones(2, 3);
I = eye(3);
x = linspace(0, 1, 11);

size(row)
numel(Z)
ndims(Z)
```

Preallocate arrays when filling them repeatedly in a loop:

```matlab
n = 1000;
y = zeros(1, n);
for k = 1:n
    y(k) = sin(k / 20);
end
```

Preallocation can reduce repeated memory allocation and makes the intended output size explicit.

## 2. Reshape and dimension rules

```matlab
A = reshape(1:12, 3, 4); % fills column by column
columnMajor = A(:);
rowSums = sum(A, 2);
columnSums = sum(A, 1);
```

Always check which dimension an operation reduces. `sum(A,1)` returns column sums; `sum(A,2)` returns row sums. For empty and singleton dimensions, inspect the result with `size`.

## 3. Solve linear systems correctly

For a system (A x = b), use the backslash operator:

```matlab
A = [3 1; 1 2];
b = [9; 8];
x = A \ b;
residual = A*x - b;
fprintf("Residual norm: %.3g\n", norm(residual));
```

Avoid `inv(A)*b` for ordinary linear-system solving. Backslash selects an appropriate solution method and is usually clearer and more numerically reliable. Check rank, conditioning, and residuals when the problem is sensitive.

## 4. Matrix multiplication versus element-wise operations

```matlab
A = [1 2; 3 4];
B = [5 6; 7 8];
matrixProduct = A * B;
elementProduct = A .* B;
elementQuotient = A ./ B;
elementPower = A .^ 2;
```

If an operation fails, inspect `size(A)` and `size(B)` before changing the data. Do not transpose arrays randomly to suppress a dimension error.

## 5. Tables, structures, and cells

- Use a **numeric matrix** for homogeneous numeric data with consistent meaning.
- Use a **table** for column-oriented records with named variables and mixed types.
- Use a **structure** for a named group of related fields.
- Use a **cell array** when elements have different types or sizes.

Example:

```matlab
records = table(["A"; "B"], [23.1; 24.0], ...
    'VariableNames', {'Sensor', 'Temperature'});
sensor.id = 3;
sensor.samples = [1.1 1.2 1.3];
mixed = {42, "ready", [1 2 3]};
```

## 6. Common mistakes

| Mistake | Why it happens | Safer approach |
|---|---|---|
| Using `length` for matrix dimensions | It returns the largest dimension | Use `size` or `numel` |
| Confusing `A'` with `A.'` | Complex conjugation is overlooked | Choose based on mathematical intent |
| Using `*` for per-element products | Matrix algebra rules differ | Use `.*` when element-wise behavior is intended |
| Assuming row-major order | MATLAB linear indexing is column-major | Test with a small matrix |
| Building arrays one item at a time | Repeated reallocation | Preallocate when size is known |

## 7. Practice lab

Given a sensor matrix whose rows are channels and columns are time samples:

1. Compute each channel's mean and standard deviation.
2. Find samples above a channel-specific threshold.
3. Normalize each channel without modifying the original input.
4. Solve a small linear system and calculate the residual norm.
5. Test a one-row matrix, one-column matrix, and empty input.

## Related pages

- [Language fundamentals](01-Language-Fundamentals.md)
- [Functions and testing](03-Functions-and-Testing.md)
- [MATLAB Basics: 100 Questions](../Questions/Matlab-Basics-100.md)
