#######################################################
#
# PicturesCtrl
#
#######################################################

module.exports = [
  "$scope", "$http", "$routeParams", "DataService"
  ($scope, $http, $routeParams, DataService)->
    class PicturesCtrl

      constructor: ()->
        console.log "#### INIT PicturesCtrl"
        @scope = $scope
        $scope.pictures = _.filter DataService.pictures, (pic)-> pic.tags.indexOf($routeParams.id) >= 0
        console.log "Pictures", $scope.pictures

    window.PicturesCtrl = new PicturesCtrl()
]


