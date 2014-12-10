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
		$scope.poster = 'http://placehold.it/600&text=you%20may%20want%20to%20have%20a%20poster',
		$scope.fullScreen = true,
		$scope.muted = true,
		$scope.zIndex = '22'
	}]);
```

## options

| attribute         | optional? | example              | description                     |
|-------------------|-----------|----------------------|---------------------------------|
| resources         | no        | ['xx.webm','yy.mp4'] | video resources                 |
| poster            | yes       | 'zzz.jpg'            | image shown before image loaded |
| full-screen       | yes       | true                 | show video full screenly        |
| muted             | yes       | true                 | if muted                        |
| control           | yes       | false                | if show html5 video controls    |
| loop              | yes       | true                 | continuesly loop video          |
| auto-play         | yes       | true                 | play video on load and buffer it|
| z-index           | yes       | 100                  | z-index of the video tag        |
| error-msg         | yes       | 'error!'             | not support error message       |

_Note_: Only `resources`, `poster` and `full-screen` are passed in as directly values. All other attributes are passing values as parent scope's members. Because these other options are for rare use cases.

## Coming soon

+ dymanic pause and play video with fading effect
+ detailed accessible information about your video including loading status, played range, etc.
+ testing on different browsers/devices

### Credits
  I started to have this idea from [turn's website] (http://turn.com/)
  inspired by [this] (http://demosthenes.info/blog/777/Create-Fullscreen-HTML5-Page-Background-Video)
  
  references: [1] (https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_HTML5_audio_and_video)
  [2] (https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video)
  [3] (http://diveintohtml5.info/video.html)
