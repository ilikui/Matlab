function report = compare_lowpass_c(executablePath, tolerance)
%COMPARE_LOWPASS_C Compare lowpass_filter with a compiled C reference runner.
%   REPORT = COMPARE_LOWPASS_C(EXECUTABLEPATH, TOLERANCE) invokes the
%   executable built from c_reference/lowpass_cli.c, sends deterministic
%   test data through a temporary CSV file, and compares the C result with
%   MATLAB. The executable accepts:
%       lowpass_cli input.csv output.csv alpha
%
%   Build instructions are in Src/Examples/README.md. This function requires
%   a working C compiler to build the runner manually; it does not compile C.
%   The executable path must point to an already-built lowpass_cli program.

    if nargin < 2 || isempty(tolerance)
        tolerance = 1e-10;
    end
    if ~(ischar(executablePath) || (isstring(executablePath) && isscalar(executablePath)))
        error('compare_lowpass_c:InvalidExecutable', ...
            'executablePath must be a character vector or scalar string.');
    end
    executablePath = char(executablePath);
    if exist(executablePath, 'file') ~= 2
        error('compare_lowpass_c:ExecutableNotFound', ...
            'The specified C executable was not found.');
    end
    validateattributes(tolerance, {'numeric'}, ...
        {'real','scalar','finite','nonnegative'}, mfilename, 'tolerance');

    x = [0; 1; 1; 0; -0.25; 0.75; 0.1; 0.1];
    alpha = 0.35;
    matlabOutput = lowpass_filter(x, alpha);

    inputFile = [tempname, '.csv'];
    outputFile = [tempname, '.csv'];
    cleanup = onCleanup(@() cleanupFiles(inputFile, outputFile)); %#ok<NASGU>
    writematrix(x, inputFile);

    % Quote paths for spaces. MATLAB uses the host shell to launch the runner.
    command = sprintf('"%s" "%s" "%s" %.17g', ...
        executablePath, inputFile, outputFile, alpha);
    [status, commandOutput] = system(command);
    if status ~= 0
        error('compare_lowpass_c:RunnerFailed', ...
            'C runner failed (status %d): %s', status, commandOutput);
    end
    if exist(outputFile, 'file') ~= 2
        error('compare_lowpass_c:MissingOutput', ...
            'C runner did not create its output file.');
    end
    cOutput = readmatrix(outputFile);
    if ~isvector(cOutput) || numel(cOutput) ~= numel(matlabOutput) || ...
            any(~isfinite(cOutput(:)))
        error('compare_lowpass_c:InvalidOutput', ...
            'C output must be a finite vector with the expected sample count.');
    end

    report = compare_reference_outputs(matlabOutput(:), cOutput(:), tolerance);
    report.algorithm = 'first-order low-pass';
    report.alpha = alpha;
    report.matlabOutput = matlabOutput(:);
    report.cOutput = cOutput(:);
    report.commandOutput = commandOutput;
end

function cleanupFiles(inputFile, outputFile)
    if exist(inputFile, 'file') == 2
        delete(inputFile);
    end
    if exist(outputFile, 'file') == 2
        delete(outputFile);
    end
end
