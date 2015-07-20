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
	gulp.src 'src/sb.scss'
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
		.pipe do $.coffee
		.pipe $.addsrc 'src/template.js'
		.pipe $.concat 'sb.js'
		.pipe do $.annotate
		.pipe do $.jshint
		.pipe $.jshint.reporter 'default'
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
		.pipe $.concat 'template.js'
		.pipe gulp.dest 'src'
		.pipe $.notify
			message: 'html2js task done'

gulp.task 'watch', ->
	gulp.watch 'src/*.coffee', ['srcOrTemplateTask']
	gulp.watch 'src/*.html', ['srcOrTemplateTask']
	gulp.watch 'src/*.scss', ['styles']

gulp.task 'srcOrTemplateTask', ->
	runSequence 'html2js', 'scripts', 'clean'

gulp.task 'default', ['watch'], (cb) ->
	runSequence 'html2js', ['styles', 'scripts'], 'clean', cb

gulp.task 'test', ->
	gulp.src './foobar'
		.pipe $.karma
			configFile: 'karma.conf.js',
			action: 'run'
		.on 'error', (err) ->
			console.log err
			this.emit 'end'

gulp.task 'coveralls', ->
	gulp.src './coverage/*/lcov.info'
		.pipe do $.coveralls

gulp.task 'clean', ->
	gulp.src ['*.tmp', 'src/*.js', 'src/*.css'],
		read: false
	.pipe do $.clean
	.pipe $.notify
		message: 'clean task done'