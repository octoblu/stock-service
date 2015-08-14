#!/usr/bin/env coffee

express        = require 'express'
path           = require 'path'
favicon        = require 'serve-favicon'
logger         = require 'morgan'
methodOverride = require 'method-override'
session        = require 'express-session'
bodyParser     = require 'body-parser'
multer         = require 'multer'
errorHandler   = require 'errorhandler'
meshbluHealthcheck = require 'express-meshblu-healthcheck'

StockController = require './controllers/stock-controller'
stockController = new StockController()

app = express()

app.use meshbluHealthcheck()

if process.env.AIRBRAKE_KEY
  airbrake = require('airbrake').createClient process.env.AIRBRAKE_KEY
  app.use airbrake.expressHandler()
else
  process.on 'uncaughtException', (error) =>
    console.error error.message, error.stack

app.set 'port', process.env.STOCK_SERVICE_PORT ? process.env.PORT ? 80
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
# app.use favicon(__dirname + '/public/favicon.ico'
# app.use logger('dev')
app.use logger('dev', skip: (req, res) -> res.statusCode < 400)
app.use methodOverride()
app.use session(resave: true, saveUninitialized: true, secret: 'uwotm8')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use multer()
app.use express.static(path.join(__dirname, 'public'))

app.use errorHandler()

app.get '/last-trade-price/:symbol', stockController.lastTradePrice

app.listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"
