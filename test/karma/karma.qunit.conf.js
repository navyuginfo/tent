// Karma configuration
// Generated on Tue May 07 2013 16:59:16 GMT+0100 (IST)


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser

files = [
  QUNIT,
  QUNIT_ADAPTER,
  '../../dist/javascript/jquery.js',
  '../../test/static/javascript/sinon-1.3.4.js',
  '../../test/static/javascript/sinon-qunit-1.0.0.js',
  '../../dist/javascript/vendor.js',
  '../../dist/javascript/compiled-templates.js',
  '../../dist/javascript/tent.js',
  '../../dist/javascript/qunit-test.js'
];

// list of files to exclude
exclude = [];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['dots'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = false;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = true;
