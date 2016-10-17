path           = require 'path'
express        = require 'express'
octobluExpress = require 'express-octoblu'
methodOverride = require 'method-override'

PORT = process.env.PORT ? 80

app = octobluExpress()
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use express.static path.join(__dirname, 'public')

StockController = require './controllers/stock-controller'
stockController = new StockController { timeout: process.env.REQUEST_TIMEOUT }

app.get '/last-trade-price/:symbol', stockController.lastTradePrice

server = app.listen PORT, ->
  console.log "Stock service listening on port #{server.address().port}"

process.on 'SIGTERM', =>
  console.log 'Dying a clean, honorable death'
  return process.exit 0 unless server?.close?
  server.close =>
    process.exit 0
