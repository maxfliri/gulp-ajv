through = require 'through2'
Ajv     = require 'ajv'
fs      = require 'fs'
util    = require 'gulp-util'

describe = (error) ->
    if error.keyword is 'additionalProperties'
        "should NOT have property #{error.params.additionalProperty}"
    else
        error.message

report = (file) ->
    if file.ajv.valid
        util.log util.colors.green file.relative
    else
        util.log util.colors.red file.relative
        util.log util.colors.red "  #{describe error}" for error in file.ajv.errors

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
        report file
        callback null, file

    flush = (callback) ->
        if failed
            this.emit 'error', new util.PluginError('gulp-ajv', 'Failed with validation errors')
        else
            callback()

    through.obj transform, flush

module.exports = gulpAjv
