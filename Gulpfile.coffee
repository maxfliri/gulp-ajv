gulp = require 'gulp'

coffee     = require 'gulp-coffee'
del        = require 'del'
mocha      = require 'gulp-mocha'
sequence   = require 'run-sequence'
sourcemaps = require 'gulp-sourcemaps'

gulp.task 'unit-tests', ->
  gulp.src(['test/unit/**/*.coffee'], read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'feature-tests', ->
  gulp.src(['test/feature/**/*.coffee'], read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'test', (done) ->
  sequence('unit-tests', 'feature-tests', done)

gulp.task 'compile', ->
  gulp.src('./src/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./lib'));

gulp.task 'clean', ->
  del ['lib/**/*']

gulp.task 'default', (done) ->
  sequence('clean', 'compile', 'test', done)
