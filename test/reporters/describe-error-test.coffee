chai = require 'chai'

desc = require '../../src/reporters/describe-error'

expect = chai.expect

describe 'describe-error', ->

  it 'should describe a generic error', ->
    error =
      message: 'generic error'

    description = desc error

    expect(description).to.eql 'generic error'

  it 'should describe an additional property error', ->
    error =
      keyword: 'additionalProperties'
      params:
        additionalProperty: 'foo'

    description = desc error

    expect(description).to.eql 'should NOT have property foo'
