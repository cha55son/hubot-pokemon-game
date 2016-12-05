HttpCache = require './http-cache'

class Http
  constructor: (logger, http, cachePath) ->
    @logger = logger
    @http = http
    @cache = new HttpCache cachePath, @logger

  getJSON: (url) ->
    self = this
    new Promise (resolve, reject) ->
      if self.cache.exists url
        self.logger.debug "Http.getJSON: Cache hit for #{url}"
        return resolve(JSON.parse(self.cache.retrieve(url)))
      self.logger.debug "Http.requestJSON: Requesting #{url}..."
      self.http(url).get() (err, res, body) ->
        return reject(err) if err
        switch res.statusCode
          when 200
            try
              # Ensure the json parse is successful before caching.
              json = JSON.parse(body)
              self.cache.store url, body
              resolve json
            catch e
              self.logger.error "Http.requestJSON: There was an error parsing the JSON. [#{e}]"
              reject(e)
          else
            self.logger.error "Http.requestJSON: There was an error contacting the pokemon api. [#{err}]"
            reject(err)

module.exports = Http
