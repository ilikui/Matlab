# Functions, Error Handling, and Testing

A useful MATLAB function has a clear contract: inputs, outputs, assumptions, errors, and examples.

## 1. Script or function?

Use scripts as documented entry points for experiments and reports. Use functions for reusable transformations and algorithms. A function should not silently depend on variables in the base workspace.

```matlab
function y = scale_signal(x, gain)
%SCALE_SIGNAL Multiply a numeric signal by a finite scalar gain.
    narginchk(2, 2);
    validateattributes(x, {'numeric'}, {'real', 'vector', 'finite'});
    validateattributes(gain, {'numeric'}, {'real', 'scalar', 'finite'});
    y = x .* gain;
end
```

Save this as `scale_signal.m`. Depending on MATLAB release, some validation options and string behavior may differ; use the installed documentation as the final reference.

## 2. Input validation and explicit contracts

Validation should reject inputs that violate assumptions, not guess what the caller intended. Document whether row and column vectors are both accepted, whether empty input is valid, and how non-finite values are handled.

```matlab
function y = safe_mean(x)
    narginchk(1, 1);
    if ~isnumeric(x) || ~isreal(x) || isempty(x) || any(~isfinite(x(:)))
        error("safe_mean:InvalidInput", ...
            "Input must be a nonempty, real, finite numeric array.");
    end
    y = mean(x(:));
end
```

## 3. Testing strategy

Test at several levels:

1. **Nominal case** — representative valid data.
2. **Boundary case** — minimum/maximum allowed values, single element, endpoints.
3. **Invalid case** — wrong type, wrong shape, missing values, duplicate samples.
4. **Invariant** — output dimensions, monotonicity, conservation, or bounded range.
5. **Regression case** — an input that previously exposed a bug.

Example with basic assertions:

```matlab
assert(isequal(scale_signal([1 2 3], 2), [2 4 6]));
assert(isequal(size(scale_signal([1; 2], 3)), [2 1]));

didThrow = false;
try
    scale_signal([1 NaN], 2);
catch
    didThrow = true;
end
assert(didThrow, "Expected invalid input to be rejected.");
```

For larger projects, use MATLAB's unit testing framework where available; simple assertion scripts are useful for lightweight, toolbox-free examples.

## 4. Numerical comparison

Do not test floating-point outputs with exact equality unless the algorithm is expected to be exact for the given data.

```matlab
actual = [1.000000001 2.0];
expected = [1.0 2.0];
absTol = 1e-8;
assert(max(abs(actual - expected)) <= absTol);
```

Choose tolerances based on the physical units and algorithm requirements. Also compare output shape, finite-value status, and behavior under edge conditions.

## 5. Debugging workflow

- Set a breakpoint at the first line where the state becomes incorrect.
- Inspect the input types and dimensions.
- Step through one iteration at a time.
- Use `dbstop if error` during interactive diagnosis.
- Remove temporary state assumptions before committing the fix.
- Preserve a failing test before changing the implementation.

## 6. Practice

Create a function for linear interpolation that checks: numeric finite samples, equal table lengths, strictly increasing sample positions, query input shape, and out-of-range policy. Test exact endpoints, interior points, a single query, repeated table positions, and empty input. Decide whether out-of-range queries should error, clamp, or extrapolate, and document that decision.

## Related pages

- [Runnable examples](../Src/Examples/README.md)
- [Learning plan](../StudyPlan.md)
- [MATLAB Basics: 100 Questions](../Questions/Matlab-Basics-100.md)
