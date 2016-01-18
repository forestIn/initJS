gulp = require 'gulp'
jade = require 'gulp-jade'
connect = require 'gulp-connect'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
clean = require 'gulp-clean'
rjs = require 'gulp-requirejs'

gulp.task 'connect', ->
    connect.server
        port: 1337
        livereload: on
        root: './dist'

gulp.task 'stylus', ->
    gulp.src 'stylus/*.styl'
        .pipe stylus set: ['compress']
        .pipe gulp.dest 'dist/css'
        .pipe do connect.reload

gulp.task 'jade', ->
	gulp.src 'jade/*.jade'
		.pipe do jade
		.pipe gulp.dest 'dist'
        .pipe do connect.reload

gulp.task 'coffee', ->
    gulp.src 'coffee/*.coffee'
        .pipe do coffee
        .pipe gulp.dest 'dist/js'
        .pipe do connect.reload

# gulp.task 'build', ['coffee'], ->
#     rjs
#         baseUrl: 'js'
#         paths:
#             angular: '../bower_components/angular/angular'
#         shim:
#             ["angular"]
#         name: '../bower_components/almond/almond'
#         include: ['main']
#         insertRequire: ['main']
#         out: 'all.js'
#         wrap:on


#     # .pipe do uglify
#     .pipe gulp.dest 'dist/js'
#     .pipe do connect.reload

    # gulp.src 'js/', read: no
    #     .pipe do clean

gulp.task 'watch', ->
    gulp.watch 'jade/*.jade', ['jade']
    gulp.watch 'stylus/*.styl', ['stylus']
    gulp.watch 'coffee/*.coffee', ['coffee']

gulp.task 'default', ['jade', 'stylus','coffee','connect','watch']