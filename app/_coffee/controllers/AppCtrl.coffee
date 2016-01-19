#######################################################
#
# AppCtrl
#
#######################################################

module.exports = [
  "$scope", "$http", "$routeParams", "$location"
  ($scope, $http, $routeParams, $location)->
    class AppCtrl

      constructor: ()->
        console.log "#### INIT AppCtrl"
        @scope = $scope
        $scope.goto = @goto
        $scope.tags = [
          "superstructure"
          "sails"
          "subject"
          "souls"
          "slop"
        ]

        $scope.$on '$routeChangeSuccess', ( evt, currRoute, prevRoute )=>
        #   $scope.path = $routeParams.id
          $scope.path = currRoute?.$$route?.originalPath
          console.log "AppCtrl.scope.path", $scope.path

      goto: (path)->
        $location.path "/#{path}"

    window.AppCtrl = new AppCtrl()
]