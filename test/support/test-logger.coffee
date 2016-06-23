output = ''

logger = (msg) ->
  output += msg + '\n'

logger.output = () ->
  output

module.exports = logger
