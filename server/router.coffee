#= base
#= require ./ns.js
Server.routes = routes = null

userAgent = Npm.require 'useragent'
connect   = Npm.require 'connect'
Fiber     = Npm.require 'fibers'
fsPath    = Npm.require 'path'



processRequest = (req, res, next) ->
      if not routes?
        next()
        return # No server-side routes declared...continue to next middleware.

      # Check for a matching route.
      context = new PageJS.Context(req.url)


      for own key, route of routes
        if route.match(context.path, context.params)
          if handler = route[req.method]
            # Matching route found.

            # Store the parameters extracted from the route on the [request] object.
            req.params = context.params
            req.userAgent = userAgent.lookup(req.headers['user-agent'])

            # Add methods to the [response].
            res.send = (params...) -> Server.send(res, params)
            if fnRender = Server.render?.response
              res.render = (fileName, options) -> fnRender(res, fileName, options)

            # Pass execution to the route's handler.
            wasHandled = handler(req, res) isnt false
            if wasHandled
              return

      # No matching route found.
      next()



monitorRequests = (path) ->
  WebApp.connectHandlers
    .use connect.bodyParser()
    .use (req, res, next) ->
        # Create a Fiber to run the HTTP handler in as nothing
        # else is wrapping this in a fiber automatically.
        # This prevents errors when things like synchronous HTTP calls are made.
        Fiber(-> processRequest(req, res, next)).run()


###
Adds a new connect route.
@param path:    The path to match.
@param method:  The HTTP method (GET | PUT | POST | DELETE).

@param handler(req, res): Handles the response
                          Return false if "not handled" so that other
                          routes matches can be checked.

###
Server.addRoute = (path, method, handler) ->
  # Setup initial conditions.
  throw new Error('No handler specified') unless Object.isFunction(handler)

  # Start monitor URL requests (if not already initialized).
  monitorRequests(path) unless routes?

  # Retrieve the route if it already exists.
  routes ?= {}
  route = routes[path]

  # Ensure that a handler for the given method has not already been specified.
  if route?
    if route[method]?
      throw new Error("#{ method } route already declared for path: #{ path }")

  # Create the route (if it does not already exist).
  unless route?
    route = new PageJS.Route(path)
    route[method] = handler
    routes[path] = route

  # Finish up.
  route


# HTTP Verb methods.
Server.get    = (path, handler) -> Server.addRoute(path, 'GET', handler)
Server.put    = (path, handler) -> Server.addRoute(path, 'PUT', handler)
Server.post   = (path, handler) -> Server.addRoute(path, 'POST', handler)
Server.delete = (path, handler) -> Server.addRoute(path, 'DELETE', handler)



###
Resolves the path to the built location of the specified package.
@param packageName: The name of the package.
@param path:        The sub-path to append to the string.
@returns string.
###
Server.packageBuildPath = (packageName, path) ->
  packageName = packageName.replace(/:/g, '_')
  result = fsPath.resolve("./assets/packages/#{ packageName }")
  result = "#{ result }/#{ path.remove(/^\//) }" if Object.isString(path)
  result


