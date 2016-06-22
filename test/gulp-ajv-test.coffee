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
        expect(file.ajv.errors).to.be.empty
        done()

    it 'should report an invalid file', (done) ->
      fs.writeFileSync('schema.json', JSON.stringify({ properties: {id: { type: "number" }}}))

      json = new gutil.File(path: 'test.json', contents: new Buffer(JSON.stringify({id: "abcd"})))

      gulpAjv = ajv('schema.json')

      gulpAjv.write(json)

      gulpAjv.once 'data', (file) ->
        expect(file.ajv.valid).to.be.false
        expect(file.ajv.errors).to.have.lengthOf 1
        done()

    afterEach ->
      fs.unlinkSync('schema.json')
