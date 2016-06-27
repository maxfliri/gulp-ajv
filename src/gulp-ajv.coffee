through = require 'through2'
Ajv     = require 'ajv'
fs      = require 'fs'
util    = require 'gulp-util'

validate = (data, schema) ->
    ajv = new Ajv(allErrors: true)
    valid = ajv.validate(schema, data)
    { valid: valid, errors: ajv.errors || [] }

gulpAjv = (schemaFile, encoding = 'utf8') ->
    schema = JSON.parse(fs.readFileSync(schemaFile, encoding))

    transform = (file, enc, callback) ->
        data = JSON.parse file.contents
        file.ajv = validate data, schema
        callback null, file

    through.obj transform

gulpAjv.fullReporter = require('./reporter/reporter')
gulpAjv.fail = require('./fail/fail')

module.exports = gulpAjv
