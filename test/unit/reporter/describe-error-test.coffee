chai = require 'chai'

desc = require '../../../src/reporter/describe-error'

expect = chai.expect

describe 'describe-error', ->
  
  it 'should describe an error on the root object', ->
    error =
      dataPath: ''
      message: 'has an error'

    description = desc error

    expect(description).to.eql '[root] has an error'

  it 'should describe an error on a nested property', ->
    error =
      dataPath: '.someprop'
      message: 'is invalid'

    description = desc error

    expect(description).to.eql '.someprop is invalid'

  it 'should describe an additional property error', ->
    error =
      keyword: 'additionalProperties'
      dataPath: '.someprop'
      params:
        additionalProperty: 'foo'

    description = desc error

    expect(description).to.eql ".someprop should NOT have property 'foo'"
