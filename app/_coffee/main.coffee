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
require 'angular-touch'
require 'angular-swipe/src/angular-swipe'


#######################################################
# Setup
#######################################################
app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'swipe'])

app.factory       'DataService',          require('./services/DataService')

app.directive     'blast',                require('./directives/Blast')

app.controller    'AppCtrl',              require('./controllers/AppCtrl')