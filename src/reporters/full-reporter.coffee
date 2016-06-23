through = require 'through2'
util    = require 'gulp-util'

describe = (error) ->
    if error.keyword is 'additionalProperties'
        "should NOT have property #{error.params.additionalProperty}"
    else
        error.message

report = (file, logger) ->
  if file.ajv.valid
    logger(util.colors.green(file.relative))
  else
    logger util.colors.red file.relative
    logger util.colors.red "  #{describe error}" for error in file.ajv.errors

transform = (file, enc, callback) ->
  report file

reporter = (opts) ->
  through.obj (file, enc, callback) ->
    report file, opts.logger


module.exports = reporter
