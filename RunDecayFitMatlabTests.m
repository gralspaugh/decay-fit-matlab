import matlab.unittest.TestRunner
import matlab.unittest.Verbosity
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat

% Add source folder to MATLAB search path
addpath('src')

% Create a test suite
suite = testsuite(append(pwd,'test'),'IncludeSubFolders',true);

% Create a test runner that displays progress
runner = TestRunner.withTextOutput('OutputDetail',Verbosity.Detailed);

% Create CodeCoverage plugin
sourceFolder = 'src';
reportFile = 'coberatura.xml';
reportFormat = CoberaturaFormat(reportFile);
p = CodeCoveragePlugin.forFolder(sourceFolder,'IncludingSubFolders',true,'Producing',reportFormat);
runner.addPlugin(p);

% Run the tests and fail if any fail
results = runner.run(suite);
nfailed = nnz([results.Failed]);
assert(nfailed == 0,[num2str(nfailed) 'test(s) failed.'])