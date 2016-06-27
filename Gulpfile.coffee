gulp  = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'unit-tests', ->
  gulp.src(['test/unit/**/*.coffee'], read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'test', ['unit-tests']

gulp.task 'default', ['test']
