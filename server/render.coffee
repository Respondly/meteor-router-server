fs      = Npm.require 'fs'
fsPath  = Npm.require 'path'



###
Renders a web [response] using the appropriate renderer for the given file.

  See: http://jade-lang.com/api/

  This method is typically called from a curried function attached to the
  server [response] object, attached wtihin the [core-router] server package.

@param res:       The server response.
@param filePath:  The path to the file to render.
@param options:   Locals and rendering options. (See Jade API)

###
Server.render.response = (res, filePath, options) ->

  shortFilePath = -> filePath.substring(fsPath.resolve('.').length, filePath.length)

  errResult = (err, message) ->
    result =
      code:     500
      error:    message

    # Don't leak these details on production
    if Server.isDev()
      result.file = shortFilePath()
      result.message = err?.message

    result


  # HTML - Jade.
  if filePath.endsWith('.jade')
    return Server.render.jadeAsync filePath, options, (err, html) ->
              if err
                res.send 500, errResult(err, "Failed to render HTML.")
              else
                res.send(html)


  # CSS - Stylus.
  if filePath.endsWith('.styl')
    return Server.render.stylusAsync filePath, (err, css) ->
              if err
                res.send 500, errResult(err, "Failed to render CSS stylesheet.")
              else
                res.send 200, css, contentType:'text/css'


  # Render format not supported.
  else
    res.send 500, errResult(err, "Couldn't render.")
    return





