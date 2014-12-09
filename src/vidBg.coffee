_ = require 'lodash'

angular
.module 'ngVidBg', ['vidBgTemplate']
.constant 'vidBgDefaults',
  muted: true
  loop: true
  autoPlay: true
  fullScreen: true
  zIndex: -1000
  poster: null
  notSupportErrorMsg: 'Your browser does not support the
  <code>video</code> element.'
.directive 'vidBg', ['$log', 'vidBgDefaults', ($log, vidBgDefaults) ->
  restrict: 'E'
  templateUrl: 'vidBgTemplate.html'
  scope:
    resources: '='
    params: '='
  compile: (ele, attr) ->
    pre: (scope, ele, attr) ->
      scope.resourceMap = {}
      if _.isArray scope.resources
        _.each scope.resources, (ele, index) ->
          if _.isString ele
            if ele.toUpperCase().indexOf(
              '.WEBM', ele.length - '.WEBM'.length) isnt -1
              scope.resourceMap.webm = ele
            else if ele.toUpperCase().indexOf(
              '.MP4', ele.length - '.MP4'.length) isnt -1
              scope.resourceMap.mp4 = ele
            else if ele.toUpperCase().indexOf(
              '.OGV', ele.length - '.OGV'.length) isnt -1
              scope.resourceMap.ogv = ele
      scope.notSupportErrorMsg = vidBgDefaults.notSupportErrorMsg
    post: (scope, ele, attr) ->
      ele.children().children().children()
      .eq(0).attr('src', scope.resourceMap.webm)

      ele.children().children().children()
      .eq(1).attr('src', scope.resourceMap.mp4)

      ele.children().children().children()
      .eq(2).attr('src', scope.resourceMap.ogv)
]
