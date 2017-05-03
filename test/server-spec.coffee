{describe,beforeEach,it,expect} = global
request = require 'request'

process.env.PORT = 0xdead

require '../'

describe 'Server', ->
  describe '/healthcheck', ->
    beforeEach (done) ->
      request.get "http://localhost:#{0xdead}/healthcheck", { json: true }, (error, @response, @body) =>
        done error

    it 'should respond with a 200', ->
      expect(@response.statusCode).to.equal 200

    it 'should respond with online true', ->
      expect(@body).to.deep.equal online: true

  describe '/last-trade-price/CTXS', ->
    beforeEach (done) ->
      request.get "http://localhost:#{0xdead}/last-trade-price/CTXS", { json: true }, (error, @response, @body) =>
        done error

    it 'should respond with a 200', ->
      expect(@response.statusCode).to.equal 200

    it 'should respond with a price', ->
      expect(@body.price).to.exist

  describe '/stocks/CTXS/last-trade-price', ->
    beforeEach (done) ->
      request.get "http://localhost:#{0xdead}/stocks/CTXS/last-trade-price", { json: true }, (error, @response, @body) =>
        done error

    it 'should respond with a 200', ->
      expect(@response.statusCode).to.equal 200

    it 'should respond with a price', ->
      expect(@body.price).to.exist

  describe '/stocks/CTXS', ->
    beforeEach (done) ->
      request.get "http://localhost:#{0xdead}/stocks/CTXS", { json: true }, (error, @response, @body) =>
        done error

    it 'should respond with a 200', ->
      expect(@response.statusCode).to.equal 200
