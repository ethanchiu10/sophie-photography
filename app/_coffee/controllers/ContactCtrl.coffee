#######################################################
#
# ContactCtrl
#
#######################################################

module.exports = [
  "$scope", "$http", "$routeParams", "$location"
  ($scope, $http, $routeParams, $location)->
    class ContactCtrl

      constructor: ()->
        console.log "#### INIT ContactCtrl"
        @scope = $scope


    window.ContactCtrl = new ContactCtrl()
]