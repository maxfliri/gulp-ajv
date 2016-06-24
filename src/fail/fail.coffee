through = require 'through2'
util    = require 'gulp-util'

module.exports = () ->
  failed = false

  transform = (file, enc, callback) ->
      failed = true if not file.ajv.valid
      callback null, file

  flush = (callback) ->
      this.emit('error', new util.PluginError('gulp-ajv', 'Failed with validation errors')) if failed
      this.emit('end')
      callback()

  through.obj transform, flush
