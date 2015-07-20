(function() {
  angular.module('ngVidBg', ['vidBgTemplate']).constant('vidBgDefaults', {
    muted: true,
    control: false,
    loop: true,
    autoPlay: true,
    zIndex: -1000,
    errorMsg: 'Your browser does not support the <code>video</code> element.'
  }).directive('vidBg', [
    '$log', 'vidBgDefaults', function($log, vidBgDefaults) {
      return {
        restrict: 'E',
        templateUrl: 'vidBgTemplate.html',
        scope: {
          resources: '=',
          fullScreen: '=',
          poster: '=',
          pausePlay: '=',
          playInfo: '='
        },
        compile: function(ele, attr) {
          var appendResourceToDom, processResources, vid, vidEle;
          vid = ele.children().children();
          vidEle = vid.eq(0);
          processResources = function(resources) {
            var resourceMap;
            resourceMap = {};
            if (angular.isArray(resources)) {
              angular.forEach(resources, function(ele, index) {
                if (angular.isString(ele)) {
                  if (ele.toUpperCase().indexOf('.WEBM', ele.length - '.WEBM'.length) !== -1) {
                    resourceMap.webm = ele;
                  } else if (ele.toUpperCase().indexOf('.MP4', ele.length - '.MP4'.length) !== -1) {
                    resourceMap.mp4 = ele;
                  } else if (ele.toUpperCase().indexOf('.OGV', ele.length - '.OGV'.length) !== -1) {
                    resourceMap.ogv = ele;
                  } else if (ele.toUpperCase().indexOf('.SWF', ele.length - '.SWF'.length) !== -1) {
                    resourceMap.swf = ele;
                  }
                }
              });
            }
            return resourceMap;
          };
          appendResourceToDom = function(resourceMap) {
            vid.children().eq(0).attr('src', resourceMap.webm ? resourceMap.webm : '');
            vid.children().eq(1).attr('src', resourceMap.mp4 ? resourceMap.mp4 : '');
            vid.children().eq(2).attr('src', resourceMap.ogv ? resourceMap.ogv : '');
            return vid.children().eq(3).children().eq(0).attr('value', resourceMap.swf ? resourceMap.swf : '');
          };
          return {
            pre: function(scope, ele, attr) {
              scope.posterUrl = scope.poster ? scope.poster : '';
              scope.resourceMap = processResources(scope.resources);
              scope.muted = (scope.$parent.$eval(attr.muted)) || vidBgDefaults.muted;
              scope.control = (scope.$parent.$eval(attr.control)) || vidBgDefaults.control;
              scope.loop = (scope.$parent.$eval(attr.loop)) || vidBgDefaults.loop;
              scope.autoPlay = (scope.$parent.$eval(attr.autoPlay)) || vidBgDefaults.autoPlay;
              scope.zIndex = +(scope.$parent.$eval(attr.zIndex)) || vidBgDefaults.zIndex;
              scope.errorMsg = (scope.$parent.$eval(attr.errorMsg)) || vidBgDefaults.errorMsg;
              scope.playInfo = {
                buffer: 0,
                played: 0
              };
            },
            post: function(scope, ele, attr) {
              appendResourceToDom(scope.resourceMap);
              if (!scope.loop) {
                vidEle.on('ended', function() {
                  return this.addClass('vidBg-fade');
                });
              }
              scope.$watch('pausePlay', function(val) {
                if (val) {
                  vidEle.addClass('vidBg-fade');
                  return vidEle[0].pause();
                } else {
                  vidEle.removeClass('vidBg-fade');
                  return vidEle[0].play();
                }
              });
              scope.$watch('resources', function(val) {
                vidEle.removeClass('vidBg-fade');
                vidEle[0].pause();
                appendResourceToDom(processResources(val));
                vidEle[0].load();
                return vidEle[0].play();
              }, true);
              vidEle.on('progress', function() {
                if (this.buffered.length > 0) {
                  scope.playInfo.buffer = this.buffered.end(0) / this.duration;
                  return scope.$apply();
                }
              });
              return vidEle.on('timeupdate', function() {
                scope.playInfo.played = this.currentTime / this.duration;
                return scope.$apply();
              });
            }
          };
        }
      };
    }
  ]);

}).call(this);

(function(module) {
try {
  module = angular.module('vidBgTemplate');
} catch (e) {
  module = angular.module('vidBgTemplate', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('vidBgTemplate.html',
    '<div class="vidBg-container">\n' +
    '	<video muted="{{muted}}" autoplay="{{autoPlay}}" loop="{{loop}}" class="vidBg-body"\n' +
    '		ng-style="{ \'background\': \'url(\' + posterUrl + \') #000 no-repeat center center fixed\', \'z-index\': zIndex}"\n' +
    '		ng-class="{ \'vidBg-fullScreen\' : fullScreen, \'vidBg-autoWidth\' : !fullScreen }">\n' +
    '		<source type="video/webm">\n' +
    '		<source type="video/mp4">\n' +
    '		<source type="video/ogg">\n' +
    '		<object type="application/x-shockwave-flash" data="{{resourceMap.flash}}">\n' +
    '			<param name="movie" />\n' +
    '			<p>Download video as <a href="{{resourceMap.mp4}}">MP4</a>, <a href="{{resourceMap.webm}}">WebM</a>, or <a href="{{resourceMap.ogv}}">Ogg</a>.</p>\n' +
    '		</object>\n' +
    '		<div>{{errorMsg}}</div>\n' +
    '	</video>\n' +
    '</div>');
}]);
})();
