angular-video-background
========================

> html5 video background in angular

## How to use it

Give resouces urls end with .webm .mp4 or .ogv as array to the directive 
```<vid-bg resources="resources" params="params"></vid-bg>```

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

## Coming soon

Be able to set all kinds of params for your video background: mute, loop, autoplay. You can also set it to just fill any div instead of defautly fullscreen

Also detailed accessible information about your video including loading status, played range, etc.

### Credits
  I started to have this idea from [turn's website] (http://turn.com/)
  inspired by [this] (http://demosthenes.info/blog/777/Create-Fullscreen-HTML5-Page-Background-Video)
  references [1] (https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_HTML5_audio_and_video)
  [2] (https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video)
  [3] (http://diveintohtml5.info/video.html)
