chai  = require 'chai'
es    = require 'event-stream'
fs    = require 'fs'
gutil = require 'gulp-util'

ajv  = require '../src/gulp-ajv'

expect = chai.expect

describe 'gulp-ajv', ->
  describe 'in buffer mode', ->
    it 'should check a valid file', (done) ->
      fs.writeFileSync('schema.json', '{}')
      json = new gutil.File(path: 'test.json', contents: new Buffer('{}'))

      gulpAjv = ajv('schema.json')

      gulpAjv.write(json)

      gulpAjv.once 'data', (file) ->
        expect(file.ajv.valid).to.be.true
        done()

    afterEach ->
      fs.unlinkSync('schema.json')
