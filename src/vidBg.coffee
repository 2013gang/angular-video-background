angular
.module 'ngVidBg', ['vidBgTemplate']
.constant 'vidBgDefaults',
  muted: true
  loop: true
  fullScreen: true
  notSupportErrorMsg: '<span>Sorry, your browser/device
  does not support html5 video</span>'
.directive 'vidBg', ['$log', 'vidBgDefaults', ($log, vidBgDefaults) ->
  restrict: 'E'
  templateUrl: 'vidBgTemplate.html'
  scope:
    resources: '@'
    fallbackPic: '@'
    params: '@'
  compile: (ele, attr) ->
    pre: (scope, ele, attr) ->
      # generate resouces array
    post: (scope, ele, attr) ->
]
