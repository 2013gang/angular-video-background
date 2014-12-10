_ = require 'lodash'

angular
.module 'ngVidBg', ['vidBgTemplate']
.constant 'vidBgDefaults',
  muted: true
  control: false
  loop: true
  autoPlay: true
  zIndex: -1000
  errorMsg: 'Your browser does not support the
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
            else if ele.toUpperCase().indexOf(
              '.SWF', ele.length - '.SWF'.length) isnt -1
              scope.resourceMap.swf = ele
      scope.muted = (scope.$parent.$eval attr.muted) ||
        vidBgDefaults.muted
      scope.control = (scope.$parent.$eval attr.control) ||
        vidBgDefaults.control
      scope.loop = (scope.$parent.$eval attr.loop) ||
        vidBgDefaults.loop
      scope.autoPlay = (scope.$parent.$eval attr.autoPlay) ||
        vidBgDefaults.autoPlay
      scope.zIndex = +(scope.$parent.$eval attr.zIndex) ||
        vidBgDefaults.zIndex
      scope.errorMsg = (scope.$parent.$eval attr.errorMsg) ||
        vidBgDefaults.errorMsg

      scope.fullScreen = scope.params.fullScreen
      scope.poster = scope.params.poster || ''

    post: (scope, ele, attr) ->
      # Need to mannually add src because of
      # https://docs.angularjs.org/api/ng/service/$sce
      ele.children().children().children()
      .eq(0).attr('src', scope.resourceMap.webm)

      ele.children().children().children()
      .eq(1).attr('src', scope.resourceMap.mp4)

      ele.children().children().children()
      .eq(2).attr('src', scope.resourceMap.ogv)

      ele.children().children().children()
      .eq(3).children().eq(0).attr('value', scope.resourceMap.swf)
]
