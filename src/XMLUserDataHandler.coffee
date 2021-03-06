OperationType = require './OperationType'

# Represents a handler that gets called when its associated
# node object is being cloned, imported, or renamed.
module.exports = class XMLUserDataHandler


  # Initializes a new instance of `XMLUserDataHandler`
  #
  constructor: () ->

  # Called whenever the node for which this handler is 
  # registered is imported or cloned.
  #
  # `operation` type of operation that is being performed on the node
  # `key` the key for which this handler is being called
  # `data` the data for which this handler is being called
  # `src` the node being cloned, adopted, imported, or renamed
  #       This is null when the node is being deleted.
  # `dst` the node newly created if any, or null
  handle: (operation, key, data, src, dst) ->
