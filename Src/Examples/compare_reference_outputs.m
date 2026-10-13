function report = compare_reference_outputs(reference, candidate, tolerance)
%COMPARE_REFERENCE_OUTPUTS Compare candidate values with a reference vector.
%   REPORT = COMPARE_REFERENCE_OUTPUTS(REFERENCE, CANDIDATE, TOLERANCE)
%   calculates maximum absolute error, RMSE, and mismatch count using an
%   absolute tolerance. Inputs must be real numeric arrays of equal size.
%
%   This is useful for comparing MATLAB outputs with values exported by a C
%   implementation. Choose tolerance from requirements and numeric format.

    if ~isnumeric(reference) || ~isreal(reference) || ...
            ~isnumeric(candidate) || ~isreal(candidate)
        error('compare_reference_outputs:InvalidType', ...
            'Inputs must be real numeric arrays.');
    end
    if ~isequal(size(reference), size(candidate))
        error('compare_reference_outputs:SizeMismatch', ...
            'Reference and candidate must have identical dimensions.');
    end
    if isempty(reference)
        error('compare_reference_outputs:EmptyInput', ...
            'Inputs must not be empty.');
    end
    if any(~isfinite(reference(:))) || any(~isfinite(candidate(:)))
        error('compare_reference_outputs:NonFiniteInput', ...
            'Inputs must contain only finite values.');
    end
    if ~isnumeric(tolerance) || ~isreal(tolerance) || ...
            ~isscalar(tolerance) || ~isfinite(tolerance) || tolerance < 0
        error('compare_reference_outputs:InvalidTolerance', ...
            'Tolerance must be a finite non-negative scalar.');
    end

    difference = double(candidate(:)) - double(reference(:));
    absError = abs(difference);
    report.sampleCount = numel(reference);
    report.maxAbsoluteError = max(absError);
    report.rmse = sqrt(mean(difference.^2));
    report.mismatchCount = nnz(absError > tolerance);
    report.tolerance = tolerance;
    report.pass = report.mismatchCount == 0;
end
