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
    vid = do ele.children().children
    vidEle = vid.eq 0
    processResources = (resources) ->
      resourceMap = {}
      if _.isArray resources
        _.each resources, (ele, index) ->
          if _.isString ele
            if ele.toUpperCase().indexOf(
              '.WEBM', ele.length - '.WEBM'.length) isnt -1
              resourceMap.webm = ele
              return
            else if ele.toUpperCase().indexOf(
              '.MP4', ele.length - '.MP4'.length) isnt -1
              resourceMap.mp4 = ele
              return
            else if ele.toUpperCase().indexOf(
              '.OGV', ele.length - '.OGV'.length) isnt -1
              resourceMap.ogv = ele
              return
            else if ele.toUpperCase().indexOf(
              '.SWF', ele.length - '.SWF'.length) isnt -1
              resourceMap.swf = ele
              return
      return resourceMap
    appendResourceToDom = (resourceMap) ->
      # Need to mannually add src because of
      # https://docs.angularjs.org/api/ng/service/$sce
      vid.children()
      .eq(0).attr('src', resourceMap.webm)

      vid.children()
      .eq(1).attr('src', resourceMap.mp4)

      vid.children()
      .eq(2).attr('src', resourceMap.ogv)

      vid.children()
      .eq(3).children().eq(0).attr('value', resourceMap.swf)

    pre: (scope, ele, attr) ->
      scope.resourceMap = processResources scope.resources
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
      return

    post: (scope, ele, attr) ->
      appendResourceToDom scope.resourceMap
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
      scope.$watch 'resources', (val) ->
        do vidEle[0].pause
        appendResourceToDom processResources val
        do vidEle[0].load
        do vidEle[0].play
]
