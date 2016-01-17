module.exports = [
  ()->
    {
      restrict: 'A',
      transclude: true
      scope: {content: '='},
      link: ( scope, element, attr, ctrl, transclude )->
        transclude( scope, (clone, scope) ->
          scope.text = clone.html()
        )
        element.html scope.text.replace(/[A-z]/g, "<span class='chara'>" + '$&' + "</span>")
    }
]