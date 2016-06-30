gulp  = require 'gulp'
mocha = require 'gulp-mocha'
sequence = require 'run-sequence'

gulp.task 'unit-tests', ->
  gulp.src(['test/unit/**/*.coffee'], read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'feature-tests', ->
  gulp.src(['test/feature/**/*.coffee'], read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'test', (done) ->
  sequence('unit-tests', 'feature-tests', done)

gulp.task 'default', ['test']
