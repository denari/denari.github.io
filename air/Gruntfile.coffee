module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    slim:
      dest:
        files: [
          expand: true
          cwd: 'src'
          src: ['*.slim', '!_*.slim']
          dest: ''
          ext: '.html'
        ]

    stylus:
      dest:
        src: ['src/css/style.styl']
        dest: 'css/style.css'
      ie:
        src: 'src/css/ie.styl'
        dest: 'css/ie.css'

    browserify:
      dest:
        files:
          'js/main.js': 'src/js/*.coffee'
        options:
          transform: ['coffeeify', 'debowerify']
          browserifyOptions:
            extensions: ['.coffee']

    uglify:
      dest:
        files:
          'js/main.min.js':
            'js/main.js'

    copy:
      image:
        files: [
          expand: true
          cwd: "src/image"
          src: "**"
          dest: "image"
        ]

    clean:
      css: ['src/css/*.css']

    connect:
      server:
        options:
          port: 9100
          base: ''

    watch:
      stylus:
        files: ['src/css/*.styl', 'src/css/**/*.styl']
        tasks: ['stylus', 'clean']
      slim:
        files: ['src/*.slim', 'src/**/*.slim']
        tasks: ['slim']
      coffee:
        files: ['src/js/*.coffee']
        tasks: ['browserify', 'uglify']
      image:
        files: 'src/image/*'
        tasks: ['copy']
      jslibs:
        files: 'src/js/libs/*'
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
