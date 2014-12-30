gulp = require 'gulp'
runSequence = require 'run-sequence'
$ = (require 'gulp-load-plugins')
	rename:
		'gulp-ruby-sass': 'sass'
		'gulp-minify-css': 'minifycss'
		'gulp-add-src': 'addsrc'
		'gulp-ng-html2js': 'html2js'
		'gulp-ng-annotate': 'annotate'

AUTOPREFIXER_BROWSERS = [
	'ie >= 10'
	'ie_mob >= 10'
	'ff >= 30'
	'chrome >= 34'
	'safari >= 7'
	'opera >= 23'
	'ios >= 7'
	'android >= 4.4'
	'bb >= 10'
]

gulp.task 'styles', ->
	gulp.src 'src/vidBg.scss'
	.pipe $.sass
		style: 'expanded'
	.pipe $.autoprefixer
		browsers: AUTOPREFIXER_BROWSERS
	.pipe gulp.dest 'dist'
	.pipe $.rename
		suffix: '.min'
	.pipe do $.minifycss
	.pipe gulp.dest 'dist'
	.pipe $.notify
		message: 'styles task done'

gulp.task 'scripts', ->
	gulp.src 'src/*.coffee'
	.pipe do $.coffeelint
	.pipe do $.coffeelint.reporter
	.pipe do $.coffeeify
	.pipe do $.annotate
	.pipe $.addsrc 'src/template.js'
	.pipe $.concat 'vidBg.js'
	.pipe gulp.dest 'dist'
	.pipe do $.uglify
	.pipe $.rename
		suffix: '.min'
	.pipe gulp.dest 'dist'
	.pipe $.notify
		message: 'scripts task done'

gulp.task 'html2js', ->
	gulp.src 'src/*.html'
	.pipe $.html2js
		moduleName: 'vidBgTemplate'
		prefix: ''
		useStrict: true
	.pipe $.concat 'template.js'
	.pipe gulp.dest 'src'
	.pipe $.notify
		message: 'html2js task done'

gulp.task 'watch', ->
	gulp.watch 'src/*.coffee', ['scripts']
	gulp.watch 'src/*.scss', ['styles']

gulp.task 'default', (cb) ->
	runSequence 'html2js', ['styles', 'scripts'], 'clean', cb

gulp.task 'clean', ->
	gulp.src ['*.tmp', 'src/*.js', 'src/*.css'],
		read: false
	.pipe do $.clean
	.pipe $.notify
		message: 'clean task done'

