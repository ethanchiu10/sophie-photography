express     = require 'express'
path        = require 'path'

exports = module.exports = (config)->
  app = express()
  app.use express.static( path.join __dirname, "app" )
  app