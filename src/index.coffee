express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'

#### Basic application initialization
# Create app instance.
app = express()

# Define Port
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000

# Config module exports has `setEnvironment` function that sets app settings depending on environment.
config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env

# db_config = "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"
# mongoose.connect db_config
#if app.settings.env != 'production'
#  mongoose.connect 'mongodb://localhost/example'
#else
#  console.log('If you are running in production, you may want to modify the mongoose connect path')

if app.settings.env == 'development'
  mongoose.connect 'mongodb://localhost/boilerplate-dev'
else if app.settings.env == 'testing'
  mongoose.connect 'mongodb://localhost/boilerplate-test'
else
  mongoose.connect 'mongodb://localhost/boilerplate-prod'

#### View initialization
# Add Connect Assets.
app.use assets()
js.root = '/'
css.root = '/'

# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')
app.use '/components', express.static(process.cwd() + '/assets/components')

# Express Session
store = new express.session.MemoryStore
app.use express.cookieParser()
app.use express.session(
  secret: 'shhh'
  store: store
)

# Set View Engine.
app.set 'view engine', 'jade'

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html) parses JSON or XML bodies into `req.body` object
app.use express.bodyParser()
app.use express.methodOverride()

#### Finalization
# Initialize routes
routes = require './routes'
routes(app)

# Export application object
module.exports = app

