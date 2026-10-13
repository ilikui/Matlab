function yq = linear_interp_checked(x, y, xq)
%LINEAR_INTERP_CHECKED Piecewise linear interpolation with input checks.
%   YQ = LINEAR_INTERP_CHECKED(X, Y, XQ) interpolates the samples in Y at
%   query points XQ. X must be a finite, strictly increasing real vector;
%   Y must be a finite real vector of the same length. Extrapolation is
%   intentionally rejected.
%
%   The output has the same shape as XQ. At least two table points are
%   required. The function does not silently sort the input table.

    if ~isnumeric(x) || ~isreal(x) || ~isvector(x)
        error('linear_interp_checked:InvalidX', ...
            'x must be a real numeric vector.');
    end
    if ~isnumeric(y) || ~isreal(y) || ~isvector(y)
        error('linear_interp_checked:InvalidY', ...
            'y must be a real numeric vector.');
    end
    if numel(x) ~= numel(y) || numel(x) < 2
        error('linear_interp_checked:SizeMismatch', ...
            'x and y must have equal lengths of at least two samples.');
    end
    if any(~isfinite(x(:))) || any(~isfinite(y(:)))
        error('linear_interp_checked:NonFiniteTable', ...
            'x and y must contain only finite values.');
    end
    if any(diff(x(:)) <= 0)
        error('linear_interp_checked:NonIncreasingX', ...
            'x must be strictly increasing with no duplicate points.');
    end
    if ~isnumeric(xq) || ~isreal(xq) || any(~isfinite(xq(:)))
        error('linear_interp_checked:InvalidQuery', ...
            'xq must contain finite real numeric query points.');
    end
    if any(xq(:) < x(1)) || any(xq(:) > x(end))
        error('linear_interp_checked:OutOfRange', ...
            'Query points must lie within the table range.');
    end

    x = x(:);
    y = y(:);
    queryShape = size(xq);
    q = xq(:);
    yqColumn = interp1(x, y, q, 'linear');
    yq = reshape(yqColumn, queryShape);
end
