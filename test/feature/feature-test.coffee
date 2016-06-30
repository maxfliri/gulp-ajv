child_process = require 'child_process'
expect = require('chai').expect

describe 'feature tests', ->
  this.timeout 5000

  it 'validates files and fails', (done) ->
    child_process.exec 'gulp --gulpfile test/feature/resources/Gulpfile.coffee validate-all', (err, output) ->
      expect(err.code).to.eql(1)
      expect(output).to.contain 'valid.json'
      expect(output).to.contain 'invalid1.json'
      expect(output).to.contain 'invalid2.json'
      done()

  it 'validates files and passes', (done) ->
    child_process.exec 'gulp --gulpfile test/feature/resources/Gulpfile.coffee validate-valid-files', (err, output) ->
      expect(err).to.be.null
      done()

  it 'validates files and shows output without failing', (done) ->
    child_process.exec 'gulp --gulpfile test/feature/resources/Gulpfile.coffee validate-without-failing', (err, output) ->
      expect(err).to.be.null
      expect(output).to.contain 'valid.json'
      expect(output).to.contain 'invalid1.json'
      expect(output).to.contain 'invalid2.json'
      done()
