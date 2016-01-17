express     = require 'express'
path        = require 'path'

pkg           = require './package.json'
Backend       = require './'

app = express()
app.use Backend(pkg.config)
server = app.listen pkg.config.server.port, ()->
  console.log "%s started at http://localhost:%s", pkg.name, server.address().port