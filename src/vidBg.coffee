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
    fullScreen: '='
    poster: '='
    pausePlay: '='
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

    post: (scope, ele, attr) ->
      # Need to mannually add src because of
      # https://docs.angularjs.org/api/ng/service/$sce
      vid = do ele.children().children
      vidEle = vid.eq 0
      vid.children()
      .eq(0).attr('src', scope.resourceMap.webm)

      vid.children()
      .eq(1).attr('src', scope.resourceMap.mp4)

      vid.children()
      .eq(2).attr('src', scope.resourceMap.ogv)

      vid.children()
      .eq(3).children().eq(0).attr('value', scope.resourceMap.swf)

      if !scope.loop
        vidEle.on 'ended', ->
          this.addClass 'vidBg-fade'

      scope.$watch 'pausePlay', (val) ->
        if (val)
          vidEle.addClass 'vidBg-fade'
          do vidEle[0].pause
        else
          vidEle.removeClass 'vidBg-fade'
          do vidEle[0].play
]
