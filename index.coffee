# Description:
#   WIP Pokemon
#
# Commands:
#   hubot poke - Spawn a pokemon
#
# Configuration:
#   POKE_ROOMS - Space delimited list of rooms that will be overrun with pokemon.
#

Utils = require './src/utils'
Http = require './src/http/http'
Rarity = require './src/rarity'
Pokemon = require './src/models/pokemon'
WildSpawner = require './src/wild/wild-spawner'

POKE_ROOMS = process.env.POKE_ROOMS.split(' ')
POKE_URL = 'https://pokeapi.co/api/v2'
CACHE_DIR = '/tmp/pokemon'

module.exports = (robot) ->
  http = new Http robot.logger, robot.http.bind(robot), CACHE_DIR

  wildSpawner = new WildSpawner http, POKE_ROOMS, POKE_URL
  wildSpawner.spawnPokemon()

  # robot.respond /poke/i, (msg) ->
  #   poke = Rarity.selectPokemon()
  #   http.getJSON("#{POKE_URL}/pokemon/#{poke.id}/").then (data) ->
  #     pokemon = new Pokemon data
  #     console.log '------------------------------------------------'
  #     console.log data
  #     console.log '------------------------------------------------'
  #     room = Utils.selectRandomFromArray(POKE_ROOMS)
  #     title = "A wild #{Utils.capitalize(pokemon.data.species.name)} has appeared!"
  #     color = 'good'    if pokemon.isCommon()
  #     color = 'warning' if pokemon.isUncommon()
  #     color = 'danger'  if pokemon.isRare()
  #     # something = robot.messageRoom room,
  #     robot.adapter.client.web.chat.postMessage(room, "",
  #       attachments: [
  #         author_name: "Pokemon",
  #         author_icon: "https://upload.wikimedia.org/wikipedia/en/3/39/Pokeball.PNG",
  #         text: "Attempt to catch it with `catch #{pokemon.data.species.name}`!",
  #         color: color,
  #         fallback: title,
  #         title: title,
  #         # thumb_url: "http://guidesmedia.ign.com/guides/059687/images/blackwhite/pokemans_#{poke.id}.gif",
  #         thumb_url: "http://i1265.photobucket.com/albums/jj514/Narcotic-Dementia/" +
  #                    "All%20Pokemon%20Sprites%20Animated/Generation%201/#{pokemon.id}.gif",
  #         fields: [
  #           { title: 'Level', value: 15, short: true },
  #           { title: 'Health', value: pokemon.hp, short: true }
  #         ],
  #         mrkdwn_in: ["text"]
  #       ]
  #     ).then (msg) ->
  #       setTimeout ->
  #         robot.adapter.client.web.chat.update msg.ts, msg.channel, "",
  #           attachments: [
  #             author_name: "Pokemon",
  #             author_icon: "https://upload.wikimedia.org/wikipedia/en/3/39/Pokeball.PNG",
  #             text: "*#{Utils.capitalize(pokemon.data.species.name)}* is in a battle!",
  #             color: color,
  #             thumb_url: "http://i1265.photobucket.com/albums/jj514/Narcotic-Dementia/" +
  #                       "All%20Pokemon%20Sprites%20Animated/Generation%201/#{pokemon.id}.gif",
  #             mrkdwn_in: ["text"]
  #           ]
  #       , 5000
  #       setTimeout ->
  #         robot.adapter.client.web.chat.update msg.ts, msg.channel, "",
  #           attachments: [
  #             author_name: "Pokemon",
  #             author_icon: "https://upload.wikimedia.org/wikipedia/en/3/39/Pokeball.PNG",
  #             text: "*#{Utils.capitalize(pokemon.data.species.name)}* ran away!",
  #             color: color,
  #             mrkdwn_in: ["text"]
  #           ]
  #       , 10000
  #       setTimeout ->
  #         robot.adapter.client.web.chat.delete msg.ts, msg.channel
  #       , 15000
  #   .catch (e) ->
  #     console.error e
