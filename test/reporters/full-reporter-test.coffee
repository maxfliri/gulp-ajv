chai  = require 'chai'
es    = require 'event-stream'
gutil = require 'gulp-util'

logger = require '../support/test-logger'
fullReporter = require '../../src/reporters/full-reporter'

expect = chai.expect

green = (text) -> '\u001b[32m' + text + '\u001b[39m'
red = (text) -> '\u001b[31m' + text + '\u001b[39m'

describe 'full-reporter', ->
  beforeEach ->
    logger.clear()

  it 'should report valid files', () ->
    valid_file = new gutil.File(path: 'a-valid-file')
    valid_file.ajv = { valid: true }

    reporter = fullReporter(logger: logger)

    reporter.write(valid_file)

    expect(logger.output()).to.eql green('a-valid-file')

  it 'should report invalid files with errors', () ->
    file = new gutil.File(path: 'an-invalid-file')
    file.ajv =
      valid: false
      errors: [
        { message: 'first error' }
        { message: 'second error' }
      ]

    reporter = fullReporter(logger: logger)

    reporter.write(file)

    expect(logger.output()).to.eql """
                                   #{red('an-invalid-file')}
                                   #{red('  first error')}
                                   #{red('  second error')}
                                   """
