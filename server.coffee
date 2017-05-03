path           = require 'path'
express        = require 'express'
octobluExpress = require 'express-octoblu'
SigtermHandler = require 'sigterm-handler'

PORT = process.env.PORT ? 80

app = octobluExpress()
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use express.static path.join(__dirname, 'public')

StockController = require './controllers/stock-controller'
stockController = new StockController {}

app.get '/last-trade-price/:symbol', stockController.lastTradePrice
app.get '/stocks/:symbol/last-trade-price', stockController.lastTradePrice
app.get '/stocks/:symbol', stockController.stockInfo

server = app.listen PORT, =>
  console.log "Stock service listening on port #{server.address().port}"

sigtermHandler = new SigtermHandler { events: [ 'SIGTERM', 'SIGINT' ] }
sigtermHandler.register server.close
