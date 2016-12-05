Utils = require './utils'
Constants = require './constants'

# Add the pokemon to their respective rarity groups
for name, rarity of Constants.RARITY
  for id, pokemon of Constants.POKEMON
    if pokemon.rarity == rarity
      pokemon.id = id
      rarity.pokemon.push pokemon

class Rarity
  @RARITY: Constants.RARITY

  @selectPokemon: ->
    rarity = this.selectRarity()
    poke = Utils.selectRandomFromArray(rarity.pokemon)

  @selectRarity: ->
    rand = parseInt(Math.random() * 100)
    if rand <= this.RARITY.common.chance
      this.RARITY.common
    else if  rand <= (this.RARITY.common.chance + this.RARITY.uncommon.chance)
      this.RARITY.uncommon
    else
      this.RARITY.rare

# DEBUGGING --------------------------------------------------------------
# total = Object.keys(Constants.POKEMON).length
# console.log "Total Pokemon: #{total}"
#
# for name, rarity of Constants.RARITY
#   console.log "#{name}: contain #{rarity.pokemon.length} pokemon"
#   for pokemon, i in rarity.pokemon
#     console.log "    #{i}: #{pokemon.name}"
#
# iterations = 10000
# common = 0
# uncommon = 0
# rare = 0
# for i in [1...iterations]
#   poke = Rarity.selectPokemon()
#   common++ if poke.rarity == Rarity.RARITY.common
#   uncommon++ if poke.rarity == Rarity.RARITY.uncommon
#   rare++ if poke.rarity == Rarity.RARITY.rare
#
# console.log "Found #{common} common pokemon #{parseInt((common / iterations) * 100)}%"
# console.log "Found #{uncommon} uncommon pokemon #{parseInt((uncommon / iterations) * 100)}%"
# console.log "Found #{rare} rare pokemon #{parseInt((rare / iterations) * 100)}%"

module.exports = Rarity
