Rarity = require '../rarity'
Constants = require '../constants'

class Pokemon
  constructor: (data) ->
    @data = data
    @level = 1

    @id = this.getId data.id
    @hp = this.getStatByName('hp').base_stat
    @moves = this.getMovesForLevel @level
    console.log "MOVES FOR #{data.species.name}"
    console.log @moves

  getId: (id) ->
    idStr = id.toString()
    return idStr        if idStr.length == 3
    return "0#{idStr}"  if idStr.length == 2
    "00#{idStr}"

  getStatByName: (name) ->
    for stat in @data.stats
      if stat.stat.name == name
        return stat
    return false

  getMovesForLevel: (level = 10000) ->
    moves = []
    for move in @data.moves
      for versionGroup in move.version_group_details
        if versionGroup.version_group.name == "red-blue" &&
           versionGroup.move_learn_method.name == "level-up" &&
           parseInt(versionGroup.level_learned_at) <= level
          move.move.level = versionGroup.level_learned_at
          moves.push move.move
    moves

  isCommon: ->
    Constants.POKEMON[@id].rarity == Rarity.RARITY.common

  isUncommon: ->
    Constants.POKEMON[@id].rarity == Rarity.RARITY.uncommon

  isRare: ->
    Constants.POKEMON[@id].rarity == Rarity.RARITY.rare

module.exports = Pokemon
