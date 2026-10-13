function [xhat, Pout] = kalman_1d(z, Q, R, x0, P0)
%KALMAN_1D Kalman filter for a scalar random-walk state model.
%   [XHAT, POUT] = KALMAN_1D(Z, Q, R, X0, P0) estimates a scalar state
%   observed directly with unit observation gain:
%       x(k) = x(k-1) + w(k)
%       z(k) = x(k) + v(k)
%   Q and R are non-negative process-noise and measurement-noise variances.
%   x0 is the prior state estimate before processing z(1), and P0 is its
%   non-negative prior error variance.
%
%   This educational example assumes constant Q and R and a scalar model.
%   It is not a drop-in replacement for a project-specific estimator.

    if ~isnumeric(z) || ~isreal(z) || ~isvector(z) || isempty(z) || ...
            any(~isfinite(z(:)))
        error('kalman_1d:InvalidMeasurements', ...
            'z must be a non-empty finite real numeric vector.');
    end
    validateattributes(Q, {'numeric'}, ...
        {'real','scalar','finite','nonnegative'}, mfilename, 'Q');
    validateattributes(R, {'numeric'}, ...
        {'real','scalar','finite','nonnegative','positive'}, mfilename, 'R');
    validateattributes(x0, {'numeric'}, ...
        {'real','scalar','finite'}, mfilename, 'x0');
    validateattributes(P0, {'numeric'}, ...
        {'real','scalar','finite','nonnegative'}, mfilename, 'P0');

    zShape = size(z);
    z = z(:);
    xhatColumn = zeros(size(z));
    Pcolumn = zeros(size(z));
    xPrior = x0;
    PPrior = P0;

    for k = 1:numel(z)
        % Prediction for a random-walk model.
        xPred = xPrior;
        PPred = PPrior + Q;

        % Measurement update, observation gain H = 1.
        K = PPred / (PPred + R);
        xPost = xPred + K * (z(k) - xPred);
        PPost = (1 - K) * PPred;

        xhatColumn(k) = xPost;
        Pcolumn(k) = max(PPost, 0); % guard tiny negative round-off
        xPrior = xPost;
        PPrior = Pcolumn(k);
    end

    xhat = reshape(xhatColumn, zShape);
    Pout = reshape(Pcolumn, zShape);
end
