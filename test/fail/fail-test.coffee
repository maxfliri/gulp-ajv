chai  = require 'chai'
es    = require 'event-stream'
gutil = require 'gulp-util'

aFile = require '../support/file-builder'

fail = require '../../src/fail/fail'

describe 'fail', ->
  it 'should emit an error when some files are invalid', (done) ->
    file = aFile(valid: false)

    es.readArray([file])
      .pipe(fail())
      .once 'error', (error) ->
        chai.expect(error).to.have.property('message', 'Failed with validation errors')
        done()
      .once 'end', ->
        chai.assert.fail('error event expected')
        done()

  it 'should emit no error when all files are valid', (done) ->
    file = aFile(valid: true)

    es.readArray([file])
      .pipe(fail())
      .once 'error', (error) ->
        chai.assert.fail('unexpected error event')
        done()
      .once 'end', -> done()

  it 'should emit an error after all files in the stream', (done) ->
    files = [
      aFile(path: 'f1', valid: false)
      aFile(path: 'f2', valid: true)
      aFile(path: 'f3', valid: true)
    ]

    streamed = []

    es.readArray(files)
      .pipe(fail())
      .on 'data', (file) -> streamed.push(file.relative)
      .on 'error', (error) ->
        chai.expect(streamed).to.eql ['f1', 'f2', 'f3']
        done()
      .on 'end', ->
        chai.assert.fail('error event expected')
        done()
