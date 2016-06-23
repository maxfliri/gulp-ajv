output = []

logger = (msg) ->
  output.push msg

logger.output = () ->
  output.join '\n'

module.exports = logger
