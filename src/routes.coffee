#### Routes

module.exports = (app) ->

  handler = (ns, controller, action) ->
    genericRouter = (req, res) ->
      ctlFile = "./controllers/" + ns + req.param("controller") + "_controller"
      try
        genericAction = req.param("action") || 'index'
        responseHandler = require(ctlFile)[genericAction]
        throw new Error if !responseHandler
      catch e
        responseHandler = (req, res) ->
          res.send "Handler not found for " + ns + req.param("controller") + "#" + req.param("action")
          res.statusCode = 404
      responseHandler req, res
    handlerNotFound = (req, res) ->
      res.send "Handler not found for " + ns + controller + "#" + action
      res.statusCode = 404
    try
      ctlFile = "./controllers/" + ns + controller + "_controller"
      responseHandler = require(ctlFile)[action]
    if controller
      return responseHandler or handlerNotFound
    else
      return genericRouter

  RailwayRoutes = require('railway-routes')
  map = new RailwayRoutes.Map(app, handler)

  map.root 'index#index'

  map.resource 'private'
  map.resources 'users'
  map.resources 'posts'
  map.resources 'trips'

  map.all '/:controller'
  map.all '/:controller/:action'
  map.all '/:controller/:action/:id'

#  # simple session authorization
#  checkAuth = (req, res, next) ->
#    unless req.session.authorized
#      res.statusCode = 401
#      res.render '401', 401
#    else
#      next()
#
#
#  app.all '/private', checkAuth, (req, res, next) ->
#    routeMvc('private', 'index', req, res, next)
#
#  #   - _/_ -> controllers/index/index method
#  app.all '/', (req, res, next) ->
#    routeMvc('index', 'index', req, res, next)
#
#  #   - _/**:controller**_  -> controllers/***:controller***/index method
#  app.all '/:controller', (req, res, next) ->
#    routeMvc(req.params.controller, 'index', req, res, next)
#
#  #   - _/**:controller**/**:method**_ -> controllers/***:controller***/***:method*** method
#  app.all '/:controller/:method', (req, res, next) ->
#    routeMvc(req.params.controller, req.params.method, req, res, next)
#
#  #   - _/**:controller**/**:method**/**:id**_ -> controllers/***:controller***/***:method*** method with ***:id*** param passed
#  app.all '/:controller/:method/:id', (req, res, next) ->
#    routeMvc(req.params.controller, req.params.method, req, res, next)
#
#  # If all else failed, show 404 page
#  app.all '/*', (req, res) ->
#    console.warn "error 404: ", req.url
#    res.statusCode = 404
#    res.render '404', 404
#
## render the page based on controller name, method and id
#routeMvc = (controllerName, methodName, req, res, next) ->
#  controllerName = 'index' if not controllerName?
#  controller = null
#  try
#    controller = require "./controllers/" + controllerName
#  catch e
#    console.warn "controller not found: " + controllerName, e
#    next()
#    return
#  data = null
#  if typeof controller[methodName] is 'function'
#    actionMethod = controller[methodName].bind controller
#    actionMethod req, res, next
#  else
#    console.warn 'method not found: ' + methodName
#    next()
