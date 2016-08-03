chai  = require 'chai'
es    = require 'event-stream'

logger = require '../support/test-logger'
aFile = require '../support/file-builder'

createReporter = require '../../../src/reporter/reporter'

expect = chai.expect

green = (text) -> '\u001b[32m' + text + '\u001b[39m'
red = (text) -> '\u001b[31m' + text + '\u001b[39m'

describe 'full-reporter', ->
  beforeEach ->
    logger.clear()

  it 'should report valid files', () ->
    valid_file = aFile(path: 'a-valid-file', valid: true)

    reporter = createReporter(logger: logger)

    reporter.write(valid_file)

    expect(logger.output()).to.eql green('a-valid-file')

  it 'should report invalid files with errors', () ->
    file = aFile(path: 'an-invalid-file', valid: false, errors: [
      { message: 'first error' }
      { message: 'second error' }
    ])

    reporter = createReporter(logger: logger)

    reporter.write(file)

    expect(logger.output()).to.eql """
                                   #{red('an-invalid-file')}
                                   #{red('  [root] first error')}
                                   #{red('  [root] second error')}
                                   """

  it 'should pass files through', (done) ->
    files = [
      aFile(path: 'a', valid: true),
      aFile(path: 'b', valid: false)
    ]

    streamed = []

    es.readArray(files)
      .pipe(createReporter(logger: logger))
      .on('data', (file) -> streamed.push file)
      .on 'end', ->
        expect(streamed).to.eql files
        done()
