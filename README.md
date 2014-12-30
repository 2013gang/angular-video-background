angular-video-background
========================

> html5 fullscreen video background in angular

## Description

Eye-catching fullscreen video background is adopted by many modern websites for telling their stories. If you want to tell your own story in angular, you now have a choice. Just provide the video resouces, you can have your stunning video background right away.

## Demo
A demo can be viewed at: https://gang-demo.herokuapp.com/

## Dependency
+ angular (*)
+ lodash (*)

## How to get it

```bower install --save angular-video-background```

## Usage

include dist/vidBg.js and dist/vidBg.css in your js and css file and then:

```html
<vid-bg resources="resources" poster="poster" full-screen="fullScreen" muted="muted" z-index="zIndex"></vid-bg>
```
```js
angular
	.module('demo', ['ngVidBg'])
	.controller('mainCtrl', ['$scope', function ($scope) {
		$scope.resources = [
			'http://techslides.com/demos/sample-videos/small.webm',
			'http://techslides.com/demos/sample-videos/small.ogv',
			'http://techslides.com/demos/sample-videos/small.mp4',
			'http://www.msfw.com/accessibility/presentations/flash2009/SkinUnderPlaySeekCaption.swf'
		],
		$scope.poster = 'http://placehold.it/2000&text=you%20may%20want%20to%20have%20a%20poster',
		$scope.fullScreen = true,
		$scope.muted = true,
		$scope.zIndex = '22'
	}]);
```

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
+ dynamic change video resources and pause video

## Coming soon
+ <strike>dynamic video change</strike>
+ detailed accessible information about your video including loading status, played range, etc.
+ testing on different browsers/devices
+ how to deal with legacy browsers and mobile

### Credits
  I started to have this idea from [turn's website] (http://turn.com/)
  inspired by [this] (http://demosthenes.info/blog/777/Create-Fullscreen-HTML5-Page-Background-Video)
  
  references: [1] (https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_HTML5_audio_and_video)
  [2] (https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video)
  [3] (http://diveintohtml5.info/video.html)
