describe = (error) ->
    if error.keyword is 'additionalProperties'
        "should NOT have property #{error.params.additionalProperty}"
    else
        error.message

module.exports = describe
