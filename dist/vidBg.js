(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
angular.module('ngVidBg', ['vidBgTemplate']).constant('vidBgDefaults', {
  muted: true,
  loop: true,
  fullScreen: true,
  notSupportErrorMsg: '<span>Sorry, your browser/device does not support html5 video</span>'
}).directive('vidBg', [
  '$log', 'vidBgDefaults', function($log, vidBgDefaults) {
    return {
      restrict: 'E',
      templateUrl: 'vidBgTemplate.html',
      scope: {
        resources: '@',
        fallbackPic: '@',
        params: '@'
      },
      compile: function(ele, attr) {
        return {
          pre: function(scope, ele, attr) {},
          post: function(scope, ele, attr) {}
        };
      }
    };
  }
]);



},{}]},{},[1]);
angular.module('vidBgTemplate', ['vidBgTemplate.html']);

angular.module("vidBgTemplate.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("vidBgTemplate.html",
    "<video autoplay loop poster=\"http://placehold.it/350x150\" id=\"bgvid\">\n" +
    "\n" +
    "	<source src=\"http://techslides.com/demos/sample-videos/small.webm\" type=\"video/webm\">\n" +
    "\n" +
    "	<source src=\"http://techslides.com/demos/sample-videos/small.mp4\" type=\"video/mp4\">\n" +
    "\n" +
    "</video>");
}]);
