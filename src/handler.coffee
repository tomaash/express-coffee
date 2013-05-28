#### Route handler

module.exports = (ns, controller, action) ->
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
#      console.log(ns)
#      console.log(controller)
#      console.log(action)
      ctlFile = "./controllers/" + ns + controller + "_controller"
#      console.log(ctlFile)
      responseHandler = require(ctlFile)[action]
    if controller
      return responseHandler or handlerNotFound
    else
      return genericRouter