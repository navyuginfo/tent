/*
 * grunt-neuterall
 * 
 *
 * Copyright (c) 2013 Niall Fallon
 * Licensed under the MIT license.
 */

'use strict';

var path = require('path');

module.exports = function(grunt) {

  grunt.registerMultiTask('neuterall', 'Concatenate files in the order you require', function() {

    // track required files for this task.
    // once a file has been required it will be added to this array
    // which will be checked before attempting to add a file.
    // each file can be required only once.
    var required = [];

    // the bufffer that we appened to over this run.
    var out = [];

    // matches `require('some/path/file');` statements.
    // no need to include a .js as this will be appended for you.
    var requireSplitter = /^\s*(require\([\'||\"].*[\'||\"]\));+\n*/m;
    var requireMatcher = /^require\([\'||\"](.*)[\'||\"]\)/m;
    
    // add mustache style delimiters
    grunt.template.addDelimiters('neuter', '{%', '%}');
    
    var options = this.options({
      filepathTransform: function(filepath){ return filepath; },
      template: "(function() {\n\n{%= src %}\n\n})();",
      separator: "\n\n",
      includeSourceURL: false,
      skipFiles: []
    });

    // a poor man's Set
    var skipFiles = {};
    options.skipFiles.forEach(function(file){
      skipFiles[file] = true;
    });

    var finder = function(filepath, parent){
      //console.log('** filepath = ' + filepath);
      //console.log('** parent   = ' + parent);

      if (parent && (parent+"").indexOf('/') > -1) {
        var parentPath = parent.substring(0, parent.lastIndexOf('/'));
        filepath = path.join(parentPath,filepath);
        //console.log('************* joining --  ' + filepath);
      } 
      //console.log('=========== '+filepath);

      // Ignore templates. They will be included in a templates file
      if (filepath.indexOf('template/') > -1) {
        return '';
      }

      if (!grunt.file.exists(filepath)) {
        filepath = filepath.split('.js')[0] + '/index.js';
      }
      if (!grunt.file.exists(filepath)) {
        grunt.log.error('Source file "' + filepath + '" not found.');
        return '';
      }

      // once a file has been required its source will
      // never be written to the resulting destination file again.
      if (required.indexOf(filepath) === -1) {
        required.push(filepath);

        var src = grunt.file.read(filepath);

        // if a file should not be nuetered
        // it is part of the skipFiles option
        // and is simply included
        if (skipFiles[filepath]) {
          out.push({filepath: filepath, src: src});
        } else {
          
          // split the source into code sections
          // these will be either require(...) statements
          // or blocks of code.
          var sections = src.split(requireSplitter);

          // loop through sections appending to out buffer.
          sections.forEach(function(section){
            if (!section.length) { return; }

            // if the section is a require statement
            // recursively call find again. Otherwise
            // push the code section onto the buffer.
            // apply the filepathTransform for matched files.
            var match = requireMatcher.exec(section);
            if (match) {
              finder(match[1] + '.js', filepath);
            } else {
              out.push({filepath: filepath, src: section});
            }
          });    
        }
      }
    };

    // kick off the process. Find code sections, combine them
    // in the correct order by wrapping in the template
    // which defaults to a functional closure.
    this.files.forEach(function(file) {
      grunt.file.expand({nonull: true}, file.src).map(finder, this, file);

      var outStr = out.map(function(section){
        var templateData = {
          data: section,
          delimiters:'neuter'
        };

        if (options.includeSourceURL) {
          return "eval(" + JSON.stringify(grunt.template.process(options.template, templateData) + "//@ sourceURL=" + section.filepath) +")";
        } else {
          return grunt.template.process(options.template, templateData);
        }
      }).join(options.separator);

      console.log('writing to ' + file.dest);
      grunt.file.write(file.dest, outStr);
    });
  });

};
