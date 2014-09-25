request = require 'request'
_       = require 'lodash'

class StockController
  lastTradePrice: (req, res) =>
    @request req.params.symbol, (error, response, body) =>
      return res.status(500).send(error) if error?
      res.status(response.statusCode).send price: parseFloat(body)

  request: (symbol, callback=->) =>
    options =
      url: 'http://download.finance.yahoo.com/d/quotes.csv'
      qs:
        s: symbol
        f: 'l1'
    request options, callback

module.exports = StockController
