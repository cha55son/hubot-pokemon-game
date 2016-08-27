class Utils
  @selectRandomFromRange: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @selectRandomRoom: (rooms) ->
    rooms[Math.floor(Math.random() * rooms.length)]

  @selectRandomPokemonId: (max) ->
    this.selectRandomFromRange(1, max)

  @getPokemonById: (http, baseUrl, pokeId) ->
    self = this
    http.getJSON("#{baseUrl}/pokemon/#{pokeId}/").then (pokemon) ->
      pokemon.isShiny = false
      if self.selectRandomFromRange(1, 300) == 1
        pokemon.isShiny = true
      pokemon
    .catch (e) ->
      console.error e
      raise e

module.exports = Utils
