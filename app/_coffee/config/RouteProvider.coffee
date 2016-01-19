



module.exports = [
  "$routeProvider"
  ($routeProvider)->
    console.log "#### INIT RouteProvider"

    dataResolve = (time)->
      ["DataService", (DataService)->
        DataService.get()
      ]



    $routeProvider
      .when('/contact', {
        templateUrl: '/views/contact.html'
        controller: 'ContactCtrl'
      })
      .when('/:id', {
        templateUrl: '/views/pictures.html'
        controller: 'PicturesCtrl'
        resolve: {
          data: dataResolve()
        }
      })
      .when('/', {
        templateUrl: '/views/home.html'
        controller: 'AppCtrl'
      })
      .otherwise({
        redirectTo: '/'
      })



]