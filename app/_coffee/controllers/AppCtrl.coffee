#######################################################
#
# AppCtrl
#
#######################################################

module.exports = [
  "$scope", "$http", "$routeParams"
  ($scope, $http, $routeParams)->
    class AppCtrl

      constructor: ()->
        console.log "#### INIT AppCtrl"
        @scope = $scope
        @init()
        $scope.toggleFilter = @toggleFilter
        $scope.pictureFilter = @pictureFilter

      init: ()->
        $http.get('data/pictures.json').then(
          (response)=>
            $scope.pictures = response.data
            # $scope.tags = _.unique _.flatten _.pluck $scope.pictures, 'tags'
            $scope.tags = [
              "superstructure"
              "sails"
              "subject"
              "souls"
              "slop"
            ]
        )

        $scope.filter = $routeParams.id

      toggleFilter: (tag)->
        if $scope.filter == tag
          $scope.filter = null
        else
          $scope.filter = tag
        console.log 'filter', $scope.filter

      pictureFilter: (pic)->
        return true if !$scope.filter?
        pic.tags.indexOf($scope.filter) >= 0



    window.AppCtrl = new AppCtrl()
]