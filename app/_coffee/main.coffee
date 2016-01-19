#######################################################
#
# MAIN
#
#######################################################


#######################################################
# Require
#######################################################
window.$ = require 'jquery'
window._ = require 'underscore'

require 'angular'
require 'angular-route'
require 'angular-animate'


#######################################################
# Setup
#######################################################
app = angular.module('app', ['ngRoute', 'ngAnimate'])

app.factory       'DataService',          require('./services/DataService')

app.directive     'blast',                require('./directives/Blast')

app.controller    'AppCtrl',              require('./controllers/AppCtrl')
app.controller    'PicturesCtrl',         require('./controllers/PicturesCtrl')
app.controller    'ContactCtrl',          require('./controllers/ContactCtrl')

app.config require('./config/RouteProvider')