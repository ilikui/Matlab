function report = compare_interpolation_c(executablePath, tolerance)
%COMPARE_INTERPOLATION_C Compare MATLAB interpolation with a C reference.
%   REPORT = COMPARE_INTERPOLATION_C(EXECUTABLEPATH, TOLERANCE) writes a
%   deterministic lookup table and query vector to temporary CSV files,
%   invokes linear_interp_cli, and compares its output with
%   linear_interp_checked. Compile the C runner first; this function does
%   not compile C source files automatically.
%
%   The runner accepts: linear_interp_cli table.csv queries.csv output.csv

    if nargin < 1 || isempty(executablePath)
        error('compare_interpolation_c:MissingExecutable', ...
            'Provide the path to the compiled linear_interp_cli program.');
    end
    if nargin < 2 || isempty(tolerance)
        tolerance = 1e-10;
    end
    if ~ischar(executablePath) || isempty(executablePath)
        error('compare_interpolation_c:InvalidExecutable', ...
            'executablePath must be a non-empty character vector.');
    end
    if ~isnumeric(tolerance) || ~isscalar(tolerance) || ...
            ~isfinite(tolerance) || tolerance < 0
        error('compare_interpolation_c:InvalidTolerance', ...
            'tolerance must be a finite, non-negative scalar.');
    end

    % Include irregular spacing and unsorted queries to exercise segment
    % selection independently of query ordering.
    x = [0 1 3 4];
    y = [0 10 30 20];
    xq = [4 0.5 2 0 3.5 3];
    expected = linear_interp_checked(x, y, xq);

    tempBase = tempname;
    tableFile = [tempBase '_table.csv'];
    queryFile = [tempBase '_queries.csv'];
    outputFile = [tempBase '_output.csv'];
    cleanup = onCleanup(@() cleanupFiles( ...
        tableFile, queryFile, outputFile)); %#ok<NASGU>

    dlmwrite(tableFile, [x(:) y(:)], 'delimiter', ',', 'precision', '%.17g');
    dlmwrite(queryFile, xq(:), 'delimiter', ',', 'precision', '%.17g');

    command = [quoteArg(executablePath) ' ' quoteArg(tableFile) ' ' ...
        quoteArg(queryFile) ' ' quoteArg(outputFile)];
    [exitCode, commandOutput] = system(command);
    if exitCode ~= 0
        error('compare_interpolation_c:RunnerFailed', ...
            'C interpolation runner failed (exit code %d): %s', ...
            exitCode, commandOutput);
    end
    if exist(outputFile, 'file') ~= 2
        error('compare_interpolation_c:MissingOutput', ...
            'C runner returned success but did not create output CSV.');
    end

    actual = dlmread(outputFile, ',');
    actual = actual(:);
    expected = expected(:);
    if numel(actual) ~= numel(expected)
        error('compare_interpolation_c:SizeMismatch', ...
            'C output contains %d values; expected %d.', ...
            numel(actual), numel(expected));
    end

    difference = actual - expected;
    report = compare_reference_outputs(expected, actual, tolerance);
    report.algorithm = 'piecewise_linear_interpolation';
    report.executable = executablePath;
    report.commandOutput = commandOutput;
    report.sampleCount = numel(expected);
    report.maxAbsError = max(abs(difference));
    if isempty(difference)
        report.maxAbsError = 0;
    end
end

function result = quoteArg(value)
% Quote one command-line argument for common Windows and POSIX shells.
    value = strrep(value, '"', '""');
    result = ['"' value '"'];
end

function cleanupFiles(varargin)
    for k = 1:nargin
        if exist(varargin{k}, 'file') == 2
            delete(varargin{k});
        end
    end
end
