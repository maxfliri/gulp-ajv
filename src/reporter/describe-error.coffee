path = (error) ->
  if error.dataPath
      error.dataPath
  else
      "[root]"

message = (error) ->
    if error.keyword is 'additionalProperties'
        "should NOT have property '#{error.params.additionalProperty}'"
    else
        error.message

describe = (error) ->
    "#{path(error)} #{message(error)}"

module.exports = describe
