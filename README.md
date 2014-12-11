angular-video-background
========================

> html5 video background in angular

## Dependency
+ angular (*)
+ lodash (*)

## How to get it

```bower install --save angular-video-background```

## Usage
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

there are a few other configurable options you may also want to use:
`muted`, `control`, `loop`, `auto-play`, `z-index`, `error-msg`

## Coming soon

+ dymanic pause and play video with fading effect
+ detailed accessible information about your video including loading status, played range, etc.
+ testing on different browsers/devices
+ how to deal with legacy browsers and mobile

### Credits
  I started to have this idea from [turn's website] (http://turn.com/)
  inspired by [this] (http://demosthenes.info/blog/777/Create-Fullscreen-HTML5-Page-Background-Video)
  
  references: [1] (https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_HTML5_audio_and_video)
  [2] (https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video)
  [3] (http://diveintohtml5.info/video.html)
