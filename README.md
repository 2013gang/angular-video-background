angular-video-background
========================

> html5 fullscreen video background in angular

[![Build Status](https://travis-ci.org/2013gang/angular-video-background.svg?branch=master)](https://travis-ci.org/2013gang/angular-video-background)

## Description

Eye-catching fullscreen video background is adopted by many modern websites for telling their stories. If you want to tell your own story in angular, you now have a choice. Just provide the video resouces, you can have your stunning video background right away.

## Demo
<a href="https://gang-demo.herokuapp.com/demo" target="_blank">you can see a demo here :)</a>

## Dependency
+ angular (*)

## How to get it

```bower install --save angular-video-background```

or

```npm install --save angular-vidbg```

## Usage

include 3rd dependencies (angular, lodash) and dist/vidBg.js in your js file

include dist/vidBg.css in your css file

then:

```html
<vid-bg resources="resources" poster="poster" full-screen="fullScreen" muted="muted" z-index="zIndex" play-info="playInfo" pause-play="pausePlay"></vid-bg>
```
```js
angular
	.module('demo', ['ngVidBg'])
	.controller('mainCtrl', ['$scope', function ($scope) {
		$scope.resources = [
			'http://techslides.com/demos/sample-videos/small.webm',
			'*.ogv',
			'*.mp4',
			'*.swf'
		];
		$scope.poster = 'http://placehold.it/2000&text=you%20may%20want%20to%20have%20a%20poster';
		$scope.fullScreen = true;
		$scope.muted = true;
		$scope.zIndex = '22';
		$scope.playInfo = {};
		$scope.pausePlay = true;
	}]);
```
Note: .webm, .ogv, .mp4 are the supported resource types. .swf is the fallback resource for environment that does not support the above types.

## options

| attribute         | optional? | example              | description                     		   |
|-------------------|-----------|----------------------|---------------------------------------------------|
| resources         | no        | ['xx.webm','yy.mp4'] | video resources                 		   |
| poster            | yes       | 'zzz.jpg'            | image shown before video loaded 		   |
| full-screen       | yes       | true                 | video will fill the width of its container        |
| pause             | yes       | false                | whether to pause the video                        |

there are a few other configurable options you may also want to use:
`muted`, `control`, `loop`, `auto-play`, `z-index`, `error-msg`

### Features
+ Dynamic change video resources and pause video
+ Show video buffer status and played status

## Coming soon
+ <strike>dynamic video change</strike>
+ <strike>detailed accessible information about your video including loading status, played range, etc.</strike>
+ testing on different browsers/devices
+ how to deal with legacy browsers and mobile

### Credits
  Inspired by <a href="http://demosthenes.info/blog/777/Create-Fullscreen-HTML5-Page-Background-Video" target="_blank">this</a>

  references: <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_HTML5_audio_and_video" target="_blank">[1]</a>, <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video" target="_blank">[2]</a>, <a href="http://diveintohtml5.info/video.html" target="_blank">[3]</a>

### License
  MIT

