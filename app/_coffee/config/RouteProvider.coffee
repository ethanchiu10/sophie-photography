



module.exports = [
  "$routeProvider"
  ($routeProvider)->
    console.log "#### INIT RouteProvider"

    $routeProvider
      .when('/:id', {
        templateUrl: '/views/home.html'
        controller: 'AppCtrl'
      })
      .when('/', {
        templateUrl: '/views/home.html'
        controller: 'AppCtrl'
      })
      .otherwise({
        redirectTo: '/'
      })



]