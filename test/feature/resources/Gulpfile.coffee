gulp  = require 'gulp'
debug = require 'gulp-debug'

ajv   = require '../../..'

gulp.task 'validate-all', ->
  gulp.src(['json/*.json'])
    .pipe(ajv('./project.schema'))
    .pipe(ajv.fullReporter())
    .pipe(ajv.fail())

gulp.task 'validate-valid-files', ->
  gulp.src('json/valid-project.json')
    .pipe(ajv('./project.schema'))
    .pipe(ajv.fullReporter())
    .pipe(ajv.fail())

gulp.task 'validate-without-failing', ->
  gulp.src(['json/*.json'])
    .pipe(ajv('./project.schema'))
    .pipe(ajv.fullReporter())

gulp.task 'default', ['validate-all']
