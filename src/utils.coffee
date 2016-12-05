class Utils
  @selectRandomFromRange: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @selectRandomFromArray: (arr) ->
    arr[Math.floor(Math.random() * arr.length)]

  @capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()

module.exports = Utils
