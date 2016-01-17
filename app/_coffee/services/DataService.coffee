#######################################################
#
# DataService
#
#######################################################

module.exports = [
  "$rootScope", "$http"
  ($rootScope, $http)->

    class DataService

      constructor: ()->
        console.log "#### INIT DataService"

      get: ()=>
        $http.get('/data/pictures.json').then(
          (response)=>
            @pictures = response.data
            @tags = _.unique _.flatten _.pluck @pictures, 'tags'
            console.log "Pictures", @pictures
            console.log "Tags", @tags
        )


    window.DataService = new DataService()
]