output = []

logger = (msg) ->
  output.push msg

logger.output = () ->
  output.join '\n'

logger.clear = () ->
  output = []

module.exports = logger
