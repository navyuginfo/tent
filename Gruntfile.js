// Generated on 2013-04-23 using generator-ember 0.2.4
'use strict';
var lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet;
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {
    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        lib: 'lib',
        dist: 'dist',
        test: 'test',
        vendor: 'vendor',
        statics: 'test/static'
    };

    grunt.initConfig({
        yeoman: yeomanConfig,
        watch: {
            ember_templates: {
              files: '<%= yeoman.app %>/templates/**/*.hbs',
              tasks: ['ember_templates', 'livereload']
            },
            coffee: {
                files: ['<%= yeoman.lib %>/coffeescript/**/*.coffee'],
                tasks: ['coffee:tent', 'test']
            },
            coffeeTest: {
                files: ['test/spec/{,*/}*.coffee'],
                tasks: ['coffee:test']
            },
            compass: {
                files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
                tasks: ['compass:server']
            },
            livereload: {
                files: [
                    '<%= yeoman.app %>/*.html',
                    '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js',
                    '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
                ],
                tasks: ['livereload']
            },
            karma_qunit: {
                files: [
                    '<%= yeoman.lib %>/coffeescript/**/*.coffee',
                    '<%= yeoman.app %>/templates/**/*.hbs',
                    '<%= yeoman.test %>/qunit/**/*.coffee'
                ],
                tasks: ['karma-watch-qunit-test']
            },
            karma_mocha: {
                files: [
                    '<%= yeoman.lib %>/coffeescript/**/*.coffee',
                    '<%= yeoman.app %>/templates/**/*.hbs',
                    '<%= yeoman.test %>/mocha/**/*.coffee',
                    '<%= yeoman.test %>/mocha/**/*.js'
                ],
                tasks: ['karma-watch-mocha-test']
            }
        },
        connect: {
            options: {
                port: 9000,
                // change this to '0.0.0.0' to access the server from outside
                hostname: 'localhost'
            },
            livereload: {
                options: {
                    middleware: function (connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, 'app')
                        ];
                    }
                }
            },
            test: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, 'test')
                        ];
                    }
                }
            },
            dist: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, 'dist')
                        ];
                    }
                }
            }
        },
        open: {
            server: {
                path: 'http://localhost:<%= connect.options.port %>/testpad.html'
            }
        },
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/*',
                        '!<%= yeoman.dist %>/.git*'
                    ]
                }]
            },
            test_all: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/*'
                    ]
                }]
            },
            test: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/javascript/tent.js',
                        '<%= yeoman.dist %>/javascript/test.js'
                    ]
                }]
            },
            server: '.tmp'
        },

        minispade: {
            options: {
                renameRequire: true,
                useStrict: false,
                prefixToRemove: '.tmp/scripts/'
            },
            files: {
                src: ['.tmp/scripts/**/*.js'],
                dest: 'dist/app.js'
            }
        },

        neuterall: {
            options: {
                includeSourceURL: false,
                filepathTransform: function(filepath){
                    if (filepath.split('./').length > 1) {
                        return '.tmp/scripts/' + filepath.split('./')[1];
                    } else {
                        return '.tmp/scripts/' + filepath;
                    }
                }
            },
            tent: {
                files: {
                    'dist/javascript/tent.js': ['.tmp/scripts/tent.js']
                }
            },
            qunit_test: {
                files: {
                    'dist/javascript/qunit-test.js': ['.tmp/qunit/test/**/*.js']
                }
            }
        },

        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                'Gruntfile.js',
                '<%= yeoman.app %>/scripts/{,*/}*.js',
                '!<%= yeoman.app %>/scripts/vendor/*',
                'test/spec/{,*/}*.js'
            ]
        },

        karma: {
            options: {
                configFile: 'test/karma/karma.qunit.conf.js'
            },
            unit_mocha_watch: {
                configFile: 'test/karma/karma.mocha.conf.js',
                singleRun: false,
                background: true
            },
            unit_qunit_watch: {
                configFile: 'test/karma/karma.qunit.conf.js',
                singleRun: false,
                background: true
            },
            unit_qunit_ci: {
                configFile: 'test/karma/karma.qunit.conf.js',
                singleRun: true
            },
            qunit_continuous: {
                singleRun: true,
                browsers: ['PhantomJS']
            },
            mocha_continuous: {
                configFile: 'test/karma/karma.mocha.conf.js',
                singleRun: true,
                browsers: ['PhantomJS']
            }
        },

        mocha: {
            all: {
                options: {
                    run: true,
                    urls: ['http://localhost:<%= connect.options.port %>/index.html']
                }
            }
        },


        coffee: {
            tent: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.lib %>/coffeescript',
                    src: '{,*/**/}*.coffee',
                    dest: '.tmp/scripts',
                    ext: '.js'
                }]
            },
            test: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.test %>',
                    src: ['qunit/**/*.coffee'],
                    dest: '.tmp/qunit/test',
                    ext: '.js'
                }]
            }
        },
        compass: {
            options: {
                sassDir: '<%= yeoman.app %>/styles',
                cssDir: '.tmp/styles',
                imagesDir: '<%= yeoman.app %>/images',
                javascriptsDir: '<%= yeoman.app %>/scripts',
                fontsDir: '<%= yeoman.app %>/styles/fonts',
                importPath: 'app/components',
                relativeAssets: true
            },
            dist: {},
            server: {
                options: {
                    debugInfo: true
                }
            }
        },
        // not used since Uglify task does concat,
        // but still available if needed
        concat: {
            options: {
                separator: ';'
            },
            jq: {
                files: {
                    'dist/javascript/jquery.js': ['vendor/jquery/*.js']
                }
            },
            dist: {
                files: {
                    'dist/javascript/vendor.js': ['vendor/modernizr/*.js', 'vendor/handlebars/*.js', 'vendor/ember/*.js', 'vendor/ember-data/*.js', 'vendor/bootstrap/*.js', 'vendor/jqGrid/*.js', 'vendor/accounting/*.js', 'vendor/date/*.js', 'vendor/date-range/*.js', 'vendor/pubsub/*.js', 'vendor/jquery-ui/*.js', 'vendor/html5shiv/*.js', 'vendor/history/*.js', 'vendor/eventlistener/*.js','vendor/headless-ember/*.js']
                }
            }
        },
        // not enabled since usemin task does concat and uglify
        // check index.html to edit your build targets
        // enable this task if you prefer defining your build targets here
        /*uglify: {
            dist: {}
        },*/
        rev: {
            dist: {
                files: {
                    src: [
                        '<%= yeoman.dist %>/scripts/{,*/}*.js',
                        '<%= yeoman.dist %>/styles/{,*/}*.css',
                        '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
                        '<%= yeoman.dist %>/styles/fonts/*'
                    ]
                }
            }
        },
        useminPrepare: {
            html: '<%= yeoman.app %>/index.html',
            options: {
                dest: '<%= yeoman.dist %>'
            }
        },
        usemin: {
            html: ['<%= yeoman.dist %>/{,*/}*.html'],
            css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
            options: {
                dirs: ['<%= yeoman.dist %>']
            }
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        svgmin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.svg',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        cssmin: {
            dist: {
                files: {
                    '<%= yeoman.dist %>/styles/main.css': [
                        '.tmp/styles/{,*/}*.css',
                        '<%= yeoman.app %>/styles/{,*/}*.css'
                    ]
                }
            }
        },
        htmlmin: {
            dist: {
                options: {
                    /*removeCommentsFromCDATA: true,
                    // https://github.com/yeoman/grunt-usemin/issues/44
                    //collapseWhitespace: true,
                    collapseBooleanAttributes: true,
                    removeAttributeQuotes: true,
                    removeRedundantAttributes: true,
                    useShortDoctype: true,
                    removeEmptyAttributes: true,
                    removeOptionalTags: true*/
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.statics %>',
                    src: '*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        // Put files not handled in other tasks here
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,txt}',
                        '.htaccess',
                        'images/{,*/}*.{webp,gif}',
                        'styles/fonts/*'
                    ]
                }]
            }
        },
        concurrent: {
            server: [
                'ember_templates',
                'coffee:tent',
                'compass:server'
            ],
            test: [
                'coffee',
                'compass'
            ],
            dist: [
                //'ember_templates',
                'coffee',
                'minispade',
                //'compass:dist',
                //'imagemin',
                //'svgmin',
                'htmlmin'
            ]
        },

        ember_templates: {
            options: {
                templateName: function (sourceFile) {
                    var templatePath = yeomanConfig.lib + '/coffeescript/template/';
                    return sourceFile.replace(templatePath, '');
                }
            },
            dist: {
                files: {
                    'dist/javascript/compiled-templates.js': '<%= yeoman.lib %>/coffeescript/template/{,*/}*.handlebars'
                }
            }
        }

    });

    grunt.renameTask('regarde', 'watch');

    grunt.registerTask('server', function (target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'open', 'connect:dist:keepalive']);
        }

        grunt.task.run([
            'clean:server',
            'concurrent:server',
            'livereload-start',
            'connect:livereload',
            'open',
            'watch'
        ]);
    });

    grunt.registerTask('test', [
        'clean:server',
        'concurrent:test',
        'connect:test',
        'mocha'
    ]);

    grunt.registerTask('unittest', [
        'qunit'
    ]);

    grunt.registerTask('build', [
        'clean:dist',
        //'useminPrepare',
        'ember_templates',
        'coffeescriptee',
        //'minispade',
        'neuterall',
        'htmlmin',
        //'cssmin',
        'concat',
        //'uglify',
        'copy'
        //'rev',
        //'usemin'
    ]);



    //
    // Start watching all tent and test coffeescript files. 
    // On modification, build all Tent with tests and execute qUnit test suite.
    //    

    grunt.registerTask('karma-watch-qunit', [
        'clean:test_all',
        'concat',
        'karma:unit_qunit_watch',
        'watch:karma_qunit'
    ]);

    grunt.registerTask('karma-watch-qunit-test', [
        'clean:test',
        'coffee:test',
        'coffee:tent',
        'ember_templates',
        'neuterall:tent',
        'neuterall:qunit_test',
        'karma:unit_qunit_watch:run'
    ]);



    //
    // Start watching all tent and test coffeescript files. 
    // On modification, build all Tent with tests and execute mocha test suite.
    //       

    grunt.registerTask('karma-watch-mocha', [
        'clean:test_all',
        'concat',
        'karma:unit_mocha_watch',
        'watch:karma_mocha'
    ]);

    grunt.registerTask('karma-watch-mocha-test', [
        'clean:test',
        'coffee:test',
        'coffee:tent',
        'ember_templates',
        'neuterall:tent',
        'neuterall:qunit_test',
        'karma:unit_mocha_watch:run'
    ]);



    //
    // Immediately build all Tent and test files and execute qUnit test suite
    // 

    grunt.registerTask('karma-qunit-ci', [
        'clean:test',
        'concat',
        'coffee:test',
        'coffee:tent',
        'ember_templates',
        'neuterall:tent',
        'neuterall:qunit_test',
        'karma:qunit_continuous'
    ]);


    //
    // Immediately build all Tent and test files and execute Mocha test suite
    // 

    grunt.registerTask('karma-mocha-ci', [
        'clean:test',
        'concat',
        'coffee:test',
        'coffee:tent',
        'ember_templates',
        'neuterall:tent',
        'neuterall:qunit_test',
        'karma:mocha_continuous'
    ]);

};
