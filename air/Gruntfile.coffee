module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    slim:
      dest:
        files: [
          expand: true
          cwd: 'public_html'
          src: ['*.slim', '!_*.slim']
          dest: 'public_html/dest'
          ext: '.html'
        ]

    stylus:
      dest:
        src: ['public_html/css/style.styl']
        dest: 'public_html/dest/css/style.css'
      ie:
        src: 'public_html/css/ie.styl'
        dest: 'public_html/dest/css/ie.css'

    browserify:
      dest:
        files:
          'public_html/dest/js/main.js': 'public_html/js/*.coffee'
        options:
          transform: ['coffeeify', 'debowerify']
          browserifyOptions:
            extensions: ['.coffee']

    uglify:
      dest:
        files:
          'public_html/dest/js/main.min.js':
            'public_html/dest/js/main.js'

    copy:
      image:
        files: [
          expand: true
          cwd: "public_html/image"
          src: "**"
          dest: "public_html/dest/image"
        ]
      jslibs:
        files: [
          expand: true
          cwd: "public_html/js/libs"
          src: "**"
          dest: "public_html/dest/js/libs"
        ]

    clean:
      css: ['public_html/css/*.css']

    connect:
      server:
        options:
          port: 9100
          base: '../../hyaku/front/'

    watch:
      stylus:
        files: ['public_html/css/*.styl', 'public_html/css/**/*.styl']
        tasks: ['stylus', 'clean']
      slim:
        files: ['public_html/*.slim', 'public_html/**/*.slim']
        tasks: ['slim']
      coffee:
        files: ['public_html/js/*.coffee']
        tasks: ['browserify', 'uglify']
      image:
        files: 'public_html/image/*'
        tasks: ['copy']
      jslibs:
        files: 'public_html/js/libs/*'
        tasks: ['copy']
      options:
        livereload: true

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.loadNpmTasks 'grunt-slim'

  grunt.loadNpmTasks 'grunt-contrib-stylus'

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['slim', 'stylus', 'browserify',
                                'uglify', 'clean', 'copy',
                                'connect',  'watch']
