###

  See: http://jade-lang.com/api/

###
jade = Npm.require 'jade'

###
Renders the specified jade file to HTML asynchronously.

@param filePath: The path to the [.jade] file.
@param options:  The jade render options.
@param callback(err, html): The resulting HTML.

###
Server.render.jadeAsync = (filePath, options = {}, callback) ->

  # Merge in global options.
  for item in _globalJadeOptions
    Object.merge(options, item, false, false)

  # NB: OPTIMIZE: This could be optimized by compiling the templates
  #     and holding them in memory.
  #     See 'compile' section of Jade API.
  #       - http://jade-lang.com/api/
  jade.renderFile filePath, options, (err, html) -> callback?(err, html)





###
Registers the given object as a set of options that are passed
to all jade templates.

  NB: This can be called more than once.

###
Server.render.globalJadeOptions = (options...) -> _globalJadeOptions.push(item) for item in options
_globalJadeOptions = []
