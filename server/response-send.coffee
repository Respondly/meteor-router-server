###
Send a response.

Examples:

   res.send({ some: 'json' })
   res.send('<p>some html</p>')
   res.send(404, 'Sorry, cant find that')
   res.send(404)

@param res: The server response.
@param params {Mixed}
                [0] body or status
                [1] body
                [2] options
                      - contentType (optional).
###
Server.send = (res, params) ->
  # Setup initial conditions.
  statusCode = 200
  body = ''

  # Extract parameters.
  if params.length is 1
    if Object.isNumber(params[0])
      statusCode = params[0]
    else
      body = params[0]

  if params.length >= 2
    statusCode = params[0]
    body = params[1]
    options = params[2]

  options ?= {}

  # Determine the content type.
  if options.contentType?
    contentType = options.contentType

  else if Object.isString(body)
    contentType = 'text/html' # Assume HTML for strings.
  else if Util.isObject(body)
    contentType = 'application/json'
    body = JSON.stringify(body)

  else
    contentType = 'text/plain'
    body = body?.toString()

  # Write the response.
  body ?= ''
  res.writeHead(statusCode, { 'Content-Type': contentType })
  res.end(body, 'utf-8')

  # Finish up.
  true

