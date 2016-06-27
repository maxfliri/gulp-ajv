gutil = require 'gulp-util'

buildAjv = (opts) ->
  if Boolean(opts.valid)
    { valid: true }
  else
    {
      valid: false
      errors: opts.errors || []
    }

fileBuilder = (opts = {}) ->
  f = new gutil.File(path: opts.path || 'anypath')
  f.ajv = buildAjv(opts)
  f

module.exports = fileBuilder
