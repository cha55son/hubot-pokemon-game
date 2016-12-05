fs = require 'fs'

class HttpCache
  constructor: (@path, @logger) ->
    unless fs.existsSync(@path)
      @logger.info "HttpCache.constructor: Creating cache directory at #{@path}"
      fs.mkdirSync(@path)

  exists: (key) ->
    path = this._getPath(key)
    @logger.debug "HttpCache.exists: Checking for file #{path}"
    this._fileExists path

  store: (key, val) ->
    path = this._getPath(key)
    @logger.debug "HttpCache.store: Storing file at #{path}"
    fs.writeFileSync(path, val)

  retrieve: (key) ->
    path = this._getPath(key)
    @logger.debug "HttpCache.retrieve: Reading file at #{path}"
    fs.readFileSync(path, { encoding: 'utf8' })

  _getPath: (key) ->
    @path + '/' + this._hashStr(key)

  _hashStr: (str) ->
    str += ''
    hash = 0
    len = str.length
    return hash if str.length == 0
    for i in [0...len - 1] by 1
      chr = str.charCodeAt i
      hash = ((hash << 5) - hash) + chr
      hash |= 0
    Math.abs(hash).toString()

  _fileExists: (path) ->
    try
      fs.statSync(path)
      return true
    catch e
      return false


module.exports = HttpCache
