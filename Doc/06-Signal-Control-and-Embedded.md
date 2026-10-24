# Signal Processing, Control, and Embedded Algorithm Prototyping

MATLAB is useful for developing and validating algorithms before integration into embedded software. A successful prototype must make sampling assumptions and implementation limits explicit.

## 1. Sampling and time axes

For sampling frequency (F_s), the sampling interval is (T_s = 1/F_s).

```matlab
Fs = 1000;
Ts = 1/Fs;
N = 2000;
t = (0:N-1)' * Ts;
signal = sin(2*pi*25*t);
```

Use `N/Fs` as the duration represented by N samples, but note that the last sample occurs at `(N-1)/Fs`. This distinction avoids off-by-one errors in plots and window definitions.

## 2. Frequency analysis

```matlab
Fs = 1000;
N = 1000;
t = (0:N-1)'/Fs;
x = sin(2*pi*50*t);
X = fft(x);
amplitude = abs(X)/N;
singleSided = amplitude(1:N/2+1);
singleSided(2:end-1) = 2*singleSided(2:end-1);
f = (0:N/2)' * Fs/N;
plot(f, singleSided);
grid on;
xlabel('Frequency (Hz)');
ylabel('Amplitude');
```

The single-sided amplitude scaling above assumes an even sample count and a coherent sinusoid for the simplest interpretation. Windowing, leakage, DC, Nyquist handling, and nonstationary signals require additional care.

## 3. Low-pass filtering

A first-order recursive low-pass filter can be expressed as

```text
y[k] = alpha * x[k] + (1 - alpha) * y[k-1]
```

The parameter `alpha` lies between 0 and 1 for the usual smoothing interpretation. Smaller values smooth more strongly but respond more slowly. Startup initialization changes the transient response.

See [lowpass_filter.m](../Src/Examples/lowpass_filter.m) and the C reference implementation under [c_reference](../Src/Examples/c_reference/).

## 4. Kalman filter modeling

A Kalman filter depends on a state model, observation model, process-noise covariance, measurement-noise covariance, and initial uncertainty. These values should have physical justification or be calibrated against representative data.

For a constant-velocity state (x=[p;v]) with sample time (dt):

```matlab
F = [1 dt; 0 1];
H = [1 0];
```

The transition matrix predicts position and velocity; the observation matrix means only position is directly measured. A numerically correct implementation can still produce poor estimates if the model or noise assumptions are inappropriate.

See [kalman_position_velocity.m](../Src/Examples/kalman_position_velocity.m).

## 5. MATLAB-to-C handoff

Before translating an algorithm into C, document:

- Input and output units, ranges, dimensions, and invalid-value policy.
- Initialization, reset behavior, and persistent state.
- Numeric type, scaling, overflow, rounding, and saturation rules.
- Required execution rate, worst-case complexity, and memory budget.
- Reference vectors and acceptable output error.

MATLAB double precision can hide overflow and quantization problems that appear with fixed-width integers. Use explicit quantization and saturation experiments; do not assume a floating-point implementation is equivalent to target code.

## 6. Verification checklist

- [ ] Sampling frequency and units are explicit.
- [ ] Startup, reset, and missing-sample behavior are tested.
- [ ] Inputs include nominal, boundary, and fault cases.
- [ ] MATLAB and C use identical test vectors.
- [ ] Error metrics and tolerances are justified.
- [ ] Toolboxes and release requirements are documented.

## Related pages

- [Sensor signal analysis](../Src/Examples/sensor_signal_analysis.m)
- [Kalman examples](../Src/Examples/README.md)
- [Fixed-point comparison](../Src/Examples/compare_fixed_point.m)
- [MATLAB/C low-pass comparison](../Src/Examples/compare_lowpass_c.m)
