###

  See: http://learnboost.github.io/stylus/docs/js.html

###
fs      = Npm.require 'fs'
fsPath  = Npm.require 'path'
stylus  = Npm.require 'stylus'
nib     = Npm.require 'nib'


###
Registers path(s) of directories that contain stylus mixins.
@param dir:  Path(s) to the mixin folders.
###
Server.render.stylusMixins = (dir...) -> _stylusMixins.push(item) for item in dir
_stylusMixins = []





###
Renders the specified stylus file to CSS asynchronously.

@param filePath: The path to the [.styl] file.
@param callback(err, css): The resulting CSS.

###
Server.render.stylusAsync = (filePath, callback) ->
  fs.readFile filePath, 'utf8', (err, stylusText) ->
    if err
      callback?(err)
    else
      # Create the renderer.
      renderer = stylus(stylusText)
          .set('filename', filePath)
          .include(nib.path)

      # Add mixin folders.
      for dir in _stylusMixins
        renderer.include(dir)

      # Render the stylus as CSS.
      renderer.render (err, css) -> callback?(err, css)



# PRIVATE --------------------------------------------------------------------------


Meteor.startup ->
  # Add the 'core' mixins by default.
  Server.render.stylusMixins(fsPath.resolve('./assets/packages/core/shared/css_mixins'))

