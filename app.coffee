express =          require 'express.io'

app = express()
app.http().io()
app.listen APP_PORT

app.configure ->
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session
    secret: 'whatever29^*&3'

  app.use passport.initialize()
  app.use passport.session()

  app.use connect_assets
    jsCompilers:
      jade: jade_assets()

  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/assets'
  app.configure 'development', ->
    app.locals.pretty = true

  app.use express.static(path.join(__dirname, "static"))

  app.use express.favicon()
  app.use app.router
  app.use express.logger()
  app.use partials()



  app.io.route "mongodb_find", (req) ->
  args = req.data
  log.debug 'mongodb_find: ', args
  mongo_find args.collection, args.query, args.options, (items) ->
    req.io.emit 'mongodb_find_result',
      request_number: args.request_number
