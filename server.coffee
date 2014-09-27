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

StockController = require './controllers/stock-controller'
stockController = new StockController()

app = express()

app.set 'port', process.env.STOCK_SERVICE_PORT ? process.env.PORT ? 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
# app.use favicon(__dirname + '/public/favicon.ico'
app.use logger('dev')
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
