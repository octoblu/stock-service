request = require 'request'
_       = require 'lodash'

class StockController
  constructor: ({@timeout}={}) ->
    @timeout ?= 10000
    @timeout = parseInt @timeout

  lastTradePrice: (req, res) =>
    @request req.params.symbol, (error, response, body) =>
      return res.status(500).send(error) if error?
      res.status(response.statusCode).send price: parseFloat(body)

  request: (symbol, callback=->) =>
    options =
      url: 'http://download.finance.yahoo.com/d/quotes.csv'
      timeout: @timeout
      headers:
        'User-Agent': 'Weather-API'
      qs:
        s: symbol.toUpperCase()
        f: 'l1'
    request options, callback

module.exports = StockController
