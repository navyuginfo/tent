module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['mocha'],
    files: [
      '../../test/karma/lib/chai.js',
    '../../dist/javascript/jquery.js',
    //'test/static/javascript/sinon-1.3.4.js',
    //'test/static/javascript/sinon-qunit-1.0.0.js',
    //'dist/javascript/vendor.js',
    //'dist/javascript/compiled-templates.js',
    //'dist/javascript/tent.js',
    //'.tmp/test/lib/test_helpers.js',
    '../../test/mocha/tests/test.js'
    ],
    // list of files to exclude
    exclude: [],
    reporters: ['dots'],
    port: 9876,
    runnerPort: 9100,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    browsers: ['PhantomJS'],
    captureTimeout: 60000,
    singleRun: true
  });
};

  
 


