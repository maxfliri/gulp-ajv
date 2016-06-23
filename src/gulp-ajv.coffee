through = require 'through2'
Ajv     = require 'ajv'
fs      = require 'fs'
util    = require 'gulp-util'

validate = (data, schema) ->
    ajv = new Ajv(allErrors: true)
    valid = ajv.validate(schema, data)
    { valid: valid, errors: ajv.errors || [] }

gulpAjv = (schemaFile, encoding = 'utf8') ->
    failed = false
    schema = JSON.parse(fs.readFileSync(schemaFile, encoding))

    transform = (file, enc, callback) ->
        data = JSON.parse file.contents
        file.ajv = validate data, schema
        failed = true if not file.ajv.valid
        callback null, file

    flush = (callback) ->
        if failed
            this.emit 'error', new util.PluginError('gulp-ajv', 'Failed with validation errors')
        else
            callback()

    through.obj transform, flush

module.exports = gulpAjv
