function [xhat, Pout] = kalman_position_velocity(z, dt, accelVar, R, x0, P0)
%KALMAN_POSITION_VELOCITY Constant-velocity Kalman filter with position input.
%   Z contains position measurements. State is [position; velocity].
%   DT is the positive sample interval, ACCELVAR is continuous-step
%   acceleration-noise variance used in the discrete white-acceleration model,
%   R is the positive position measurement variance, X0 is a 2-element prior
%   state, and P0 is a 2-by-2 prior covariance matrix.
%
%   XHAT is 2-by-N and POUT is 2-by-2-by-N. This is an educational model:
%   units of position, velocity, dt, accelVar and R must be consistent.

    if ~isnumeric(z) || ~isreal(z) || ~isvector(z) || isempty(z) || ...
            any(~isfinite(z(:)))
        error('kalman_position_velocity:InvalidMeasurements', ...
            'z must be a non-empty finite real numeric vector.');
    end
    validateattributes(dt, {'numeric'}, ...
        {'real','scalar','finite','positive'}, mfilename, 'dt');
    validateattributes(accelVar, {'numeric'}, ...
        {'real','scalar','finite','nonnegative'}, mfilename, 'accelVar');
    validateattributes(R, {'numeric'}, ...
        {'real','scalar','finite','positive'}, mfilename, 'R');

    if ~isnumeric(x0) || ~isreal(x0) || numel(x0) ~= 2 || ...
            any(~isfinite(x0(:)))
        error('kalman_position_velocity:InvalidInitialState', ...
            'x0 must contain two finite real values [position; velocity].');
    end
    if ~isnumeric(P0) || ~isreal(P0) || ~isequal(size(P0), [2 2]) || ...
            any(~isfinite(P0(:)))
        error('kalman_position_velocity:InvalidInitialCovariance', ...
            'P0 must be a finite real 2-by-2 matrix.');
    end
    if norm(double(P0 - P0.'), 'fro') > 1e-10
        error('kalman_position_velocity:NonSymmetricCovariance', ...
            'P0 must be symmetric.');
    end
    if min(eig(double((P0 + P0.')/2))) < -1e-10
        error('kalman_position_velocity:InvalidCovariance', ...
            'P0 must be positive semidefinite.');
    end

    z = double(z(:));
    n = numel(z);
    F = [1 dt; 0 1];
    G = [0.5*dt^2; dt];
    Q = (G * G.') * double(accelVar);
    H = [1 0];
    I = eye(2);

    x = double(x0(:));
    P = double((P0 + P0.')/2);
    xhat = zeros(2, n);
    Pout = zeros(2, 2, n);

    for k = 1:n
        xPred = F * x;
        PPred = F * P * F.' + Q;

        innovation = z(k) - H*xPred;
        S = H*PPred*H.' + R;
        K = (PPred*H.') / S;
        x = xPred + K*innovation;

        % Joseph form improves numerical covariance symmetry/positivity.
        A = I - K*H;
        P = A*PPred*A.' + K*R*K.';
        P = (P + P.')/2;

        xhat(:,k) = x;
        Pout(:,:,k) = P;
    end
end
