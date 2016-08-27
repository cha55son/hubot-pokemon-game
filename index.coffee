# Description:
#   WIP Pokemon
#
# Commands:
#   hubot poke - Show me a pokemon
#
# Configuration:
#   POKE_ROOMS - Space delimited list of rooms that will be overrun with pokemon.
#

Http = require './src/http'
Utils = require './src/utils'

ROBOT = null
POKE_ROOMS = process.env.POKE_ROOMS.split(' ')
POKE_MAX_ID = 151
POKE_URL = 'https://pokeapi.co/api/v2'
CACHE_DIR = '/tmp/pokemon'

http = null

module.exports = (_robot) ->
  ROBOT = _robot
  http = new Http ROBOT.logger, ROBOT.http.bind(ROBOT), CACHE_DIR

  ROBOT.respond /poke/i, (msg) ->
    pokeId = Utils.selectRandomPokemonId POKE_MAX_ID
    Utils.getPokemonById(http, POKE_URL, pokeId).then (poke) ->
      console.log '------------------------------------------------'
      console.log poke
      console.log '------------------------------------------------'
      ROBOT.messageRoom Utils.selectRandomRoom(POKE_ROOMS), """
      name: #{poke.species.name}
      shiny: #{poke.isShiny}
      #{poke.sprites.front_default}
      #{poke.sprites.back_default}
      #{poke.sprites.front_shiny}
      #{poke.sprites.back_shiny}
      """
