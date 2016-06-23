chai  = require 'chai'
es    = require 'event-stream'
gutil = require 'gulp-util'

logger = require '../support/test-logger'
reporter = require '../../src/reporters/full-reporter'

expect = chai.expect

green = (text) -> '\u001b[32m' + text + '\u001b[39m'

describe 'full-reporter', ->
  it 'should log valid files', () ->
    valid_file = new gutil.File(path: 'a-valid-file')
    valid_file.ajv = { valid: true }

    reporter = reporter(logger: logger)

    reporter.write(valid_file)

    expect(logger.output()).to.eql green('a-valid-file') + '\n'
