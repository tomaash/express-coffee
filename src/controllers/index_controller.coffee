# Just renders index.jade

exports.index = (req, res) ->
#  res.send '<h1>Hello World!</h1>'
  res.render 'index'

exports.partial = (req, res) ->
  name = req.params.name
  res.render "partials/" + name
