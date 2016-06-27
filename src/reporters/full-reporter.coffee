through = require 'through2'
util    = require 'gulp-util'

describe = require './describe-error'

report = (file, logger) ->
  if file.ajv.valid
    logger(util.colors.green(file.relative))
  else
    logger util.colors.red file.relative
    logger util.colors.red "  #{describe error}" for error in file.ajv.errors

reporter = (opts = {}) ->
  console.log opts
  through.obj (file, enc, callback) ->
    report file, (opts.logger || util.log)
    callback null, file

module.exports = reporter
