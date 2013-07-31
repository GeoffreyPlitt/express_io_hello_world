express = require 'express.io'
path = require 'path'

APP_PORT = 8080

app = express()
app.http().io()
app.listen APP_PORT

app.configure ->
  app.configure 'development', ->
    app.locals.pretty = true

  app.use express.static(path.join(__dirname, "static"))

  app.use app.router
  app.use express.logger()

  app.io.route "ping", (req) ->
    console.log 'got ping'
    req.io.emit 'pong',
      result: req.data
    console.log 'sent pong'

  app.io.route "ping2", (req) ->
    console.log 'got ping2'
    req.io.emit 'pong2',
      result: req.data
    console.log 'sent pong2'
