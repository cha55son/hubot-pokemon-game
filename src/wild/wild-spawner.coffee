Rarity = require '../rarity'
Utils = require '../utils'

class WildSpawner
  constructor: (@http, @rooms, @pokeUrl) ->

  spawnPokemon: ->
    self = this
    poke = Rarity.selectPokemon()
    @http.getJSON("#{@pokeUrl}/pokemon/#{poke.id}/").then (data) ->
      room = Utils.selectRandomFromArray(self.rooms)

  startSpawner: ->
    self = this
    @interval = setInterval ->
      self.spawnPokemon()
    , 60000

module.exports = WildSpawner
