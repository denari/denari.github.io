# requires/dd
gulp       = require 'gulp'
jade       = require 'gulp-jade'
data       = require 'gulp-data'
stylus     = require 'gulp-stylus'
server     = require 'gulp-webserver'
koutoswiss = require 'kouto-swiss'
plumber    = require 'gulp-plumber'
riot       = require 'gulp-riot'
browserify = require 'browserify'
riotify    = require 'riotify'
coffeeify  = require 'coffeeify'
source     = require 'vinyl-source-stream'

# configures
src_dir  = 'src'
dest_dir = '.'

# tasks
gulp.task 'default', ->
  gulp.run 'jade'
  gulp.run 'stylus'
  gulp.run 'riot'
  gulp.run 'copy/images'
  gulp.run 'server'
  gulp.run 'watch'

gulp.task 'jade', ->
  gulp.src src_dir + '/*.jade'
    .pipe plumber()
    .pipe data (file) ->
      relativePath: file.history[0].replace file.base, ''
    .pipe jade
      pretty : true
    .pipe gulp.dest dest_dir

gulp.task 'stylus', ->
  gulp.src src_dir + '/styles/style.styl'
    .pipe plumber()
    .pipe stylus
      use : koutoswiss()
    .pipe gulp.dest dest_dir + '/styles'

gulp.task 'riot', ->
  browserify
      entries : [src_dir + '/scripts/main.coffee']
    .transform coffeeify, {}
    .transform riotify, {}
    .bundle()
    .pipe source 'main.js'
    .pipe gulp.dest dest_dir + '/scripts'

gulp.task 'copy/images', ->
  gulp.src src_dir + '/images/**'
    .pipe gulp.dest dest_dir + '/images'

gulp.task 'server', ->
  gulp.src dest_dir
    .pipe server
      livereload : true
      # open       : true
      port       : 9200

gulp.task 'watch', ->
  gulp.watch(src_dir + '/*.jade', ['jade'])
  gulp.watch(src_dir + '/**/*.jade', ['jade'])
  gulp.watch(src_dir + '/markdowns/*.md', ['jade'])
  gulp.watch(src_dir + '/styles/style.styl', ['stylus'])
  gulp.watch(src_dir + '/styles/**/*.styl', ['stylus'])
  gulp.watch(src_dir + '/scripts/**', ['riot'])
  gulp.watch(src_dir + '/images/**', ['copy/images'])
