_ = require 'underscore'

XMLFragment = require './XMLFragment'
XMLStringifier = require './XMLStringifier'

# Represents an XML builder
class XMLBuilder


  # Initializes a new instance of `XMLBuilder`
  # and creates the XML prolog
  #
  # `name` name of the root element
  #
  # `xmldec.version` A version number string, e.g. 1.0
  # `xmldec.encoding` Encoding declaration, e.g. UTF-8
  # `xmldec.standalone` standalone document declaration: true or false
  #
  # `doctype.ext` the external subset containing markup declarations
  #
  # `options.headless` whether XML declaration and doctype will be included: true or false
  # `options.allowSurrogateChars` whether surrogates will be allowed: true or false
  # `options.stringify` a set of functions to use for converting values to strings
  constructor: (name, xmldec, doctype, options) ->
    if not name?
      throw new Error "Root element needs a name"

    @children = []
    @rootObject = null

    options = _.extend { 'version': '1.0' }, xmldec, doctype, options
    @stringify = new XMLStringifier options

    name = @stringify.eleName name

    if not options?.headless
      decatts = {}

      if options.version?
        decatts.version = @stringify.xmlVersion options.version

      if options.encoding?
        decatts.encoding = @stringify.xmlEncoding options.encoding

      if options.standalone?
        decatts.standalone = @stringify.xmlStandalone options.standalone

      child = new XMLFragment @, '?xml', decatts
      @children.push child

      docatts = {}
      if options.ext?
        docatts.ext = @stringify.xmlExternalSubset options.ext

      if not _.isEmpty docatts
        docatts.name = name
        child = new XMLFragment @, '!DOCTYPE', docatts
        @children.push child

    root = new XMLFragment @, name, {}
    root.isRoot = true
    root.documentObject = @
    @children.push root
    @rootObject = root


  # Gets the root node
  root: () ->
    @rootObject


  # Ends the document and converts string
  end: (options) ->
    toString(options)


  # Converts the XML document to string
  #
  # `options.pretty` pretty prints the result
  # `options.indent` indentation for pretty print
  # `options.newline` newline sequence for pretty print
  toString: (options) ->
    r = ''
    for child in @children
      r += child.toString options
    r


module.exports = XMLBuilder

