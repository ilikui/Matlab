function y = lowpass_filter(x, alpha)
%LOWPASS_FILTER First-order recursive low-pass filter.
%   Y = LOWPASS_FILTER(X, ALPHA) filters the elements of X in linear order.
%   ALPHA must be a finite scalar in the interval (0, 1].
%   The initial output equals the first input sample.
%
%   This alpha is a discrete recursion coefficient, not a cutoff frequency
%   in Hz. Select it using the sample period and desired filter dynamics.

    if ~isnumeric(x) || ~isreal(x) || ~isvector(x) && ~isempty(x)
        error('lowpass_filter:InvalidInput', ...
            'x must be a real numeric vector or empty.');
    end
    if any(~isfinite(x(:)))
        error('lowpass_filter:NonFiniteInput', ...
            'x must contain only finite values.');
    end
    if ~isnumeric(alpha) || ~isreal(alpha) || ~isscalar(alpha) || ...
            ~isfinite(alpha) || alpha <= 0 || alpha > 1
        error('lowpass_filter:InvalidAlpha', ...
            'alpha must be a finite scalar in the interval (0, 1].');
    end

    % Use floating-point output so integer inputs do not quantize each recursive update.
    y = zeros(size(x), 'like', double(x));
    if isempty(x)
        return;
    end

    y(1) = x(1);
    for k = 2:numel(x)
        y(k) = alpha * x(k) + (1 - alpha) * y(k-1);
    end
end
