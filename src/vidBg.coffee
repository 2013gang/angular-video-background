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
    playInfo: '='
  compile: (ele, attr) ->
    vid = do ele.children().children
    vidEle = vid.eq 0
    processResources = (resources) ->
      resourceMap = {}
      if angular.isArray resources
        angular.forEach resources, (ele, index) ->
          if angular.isString ele
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
      .eq(0).attr('src', if resourceMap.webm then resourceMap.webm else '')

      vid.children()
      .eq(1).attr('src', if resourceMap.mp4 then resourceMap.mp4 else '')

      vid.children()
      .eq(2).attr('src', if resourceMap.ogv then resourceMap.ogv else '')

      vid.children()
      .eq(3).children().eq(0)
      .attr('value', if resourceMap.swf then resourceMap.swf else '')

    pre: (scope, ele, attr) ->
      scope.posterUrl = if scope.poster then scope.poster else ''
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
      scope.playInfo =
        buffer: 0
        played: 0
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
        vidEle.removeClass 'vidBg-fade'
        do vidEle[0].pause
        appendResourceToDom processResources val
        do vidEle[0].load
        do vidEle[0].play
      , true

      vidEle.on 'progress', ->
          if this.buffered.length > 0
              scope.playInfo.buffer = this.buffered.end(0) / this.duration
              do scope.$apply
      vidEle.on 'timeupdate', ->
        scope.playInfo.played = this.currentTime / this.duration
        do scope.$apply

]
