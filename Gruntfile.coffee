module.exports = (grunt) ->

	[
		'grunt-browserify'
		'grunt-coffeelint'
		'grunt-contrib-clean'
		'grunt-contrib-coffee'
		'grunt-contrib-concat'
		'grunt-contrib-cssmin'
		'grunt-contrib-jshint'
		'grunt-contrib-sass'
		'grunt-contrib-uglify'
		'grunt-contrib-watch'
		'grunt-html2js'
		'grunt-ng-annotate'
		'grunt-autoprefixer'
	]
	.forEach grunt.loadNpmTasks

	# task sets
	build = [
		'html2js'
		'coffeelint'
		'browserify'
		'sass'
		'concat'
		'autoprefixer'
		'cssmin'
		'uglify'
		'clean'
		'watch'
	]

	# task defs
	grunt.initConfig

		pkg: grunt.file.readJSON 'package.json'

		autoprefixer:
			single_file:
				src: './dist/vidBg.css'
				dest: './dist/vidBg.css'

		browserify:
			main:
				files:
					'./src/vidBg.js': ['./src/vidBg.coffee']
				options:
					transform: [
						'coffeeify'
						'browserify-ngannotate'
					]

		clean:
			main: [
				'./src/*.js'
				'./src/*.css'
			]

		coffeelint:
			app: ['src/*.coffee']

		concat:
			js:
				src: [
					'./src/vidBg.js'
					'./src/template.js'
				]
				dest: './dist/vidBg.js'
			css:
			    src: [
			    	'./src/vidBg.css'
			    ]
			    dest: './dist/vidBg.css'

		html2js:
			main:
				src: './src/vidBgTemplate.html'
				dest: './src/template.js'
			options:
				base: './src'
				module: 'vidBgTemplate'

		jshint:
			main:
				option:
					multistr: true
					laxcomma: true
					laxbreak: true
					smarttabs: true
					force: true
				files:
					src: ['./src/*.js']

		sass:
			dist:
				files: [
					expand: true
					cwd: './src'
					src: ['*.scss']
					dest: './src'
					ext: '.css'
				]

		uglify:
			my_target:
				files:
					'./dist/vidBg.min.js': ['./dist/vidBg.js']

		cssmin:
			my_target:
				files:
					'./dist/vidBg.min.css': ['./dist/vidBg.css']

		watch:
			scripts:
				files: ['src/*.*']
				tasks: ['build']
				options:
					spawn: false

	grunt.registerTask 'build', build
	grunt.registerTask 'default', ['build']