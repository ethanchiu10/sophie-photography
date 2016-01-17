'use strict'

#######################################################
#
# PACKAGE.JSON
#
#######################################################
path          = require 'path'
gulp          = require 'gulp'
gutil         = require "gulp-util"
uglify        = require "gulp-uglify"
browserify    = require "gulp-browserify"
concat        = require "gulp-concat"
prefix        = require 'gulp-autoprefixer'
sass          = require 'gulp-sass'
coffee        = require 'gulp-coffee'
watch         = require 'gulp-watch'
open          = require 'gulp-open'
express       = require 'express'
livereload    = require 'gulp-livereload'
fs            = require 'fs'
path          = require 'path'
# bodyParser    = require 'body-parser'
minifycss     = require 'gulp-minify-css'
sourcemaps    = require 'gulp-sourcemaps'
rename        = require 'gulp-rename'
plumber       = require 'gulp-plumber'
filter        = require 'gulp-filter'
runSequence   = require 'run-sequence'
injectReload  = require 'connect-livereload'
touch         = require 'touch'
del           = require 'del'
vinylPaths    = require 'vinyl-paths'

pkg           = require './package.json'
Backend       = require './'

#######################################################
# Express and CMS
#######################################################
gulp.task "server", ->

  app = express()
  app.use injectReload({port: pkg.config.server.port + 30000})
  app.use Backend(pkg.config)
  server = app.listen pkg.config.server.port, ()->
    console.log "%s started at http://localhost:%s", pkg.name, server.address().port


#######################################################
# Display Sass/Coffee Error
#######################################################
displayError = (error) ->
  errorString = "[" + error.plugin + "]"
  errorString += " " + error.message.replace("\n", "") # Removes new line at the end
  errorString += " in " + error.fileName  if error.fileName
  errorString += " on line " + error.lineNumber  if error.lineNumber
  console.error errorString
  this.emit('end')


#######################################################
# Clean
#######################################################
gulp.task "clean", ->
  gulp.src([ "./app/scripts/bundle.js", "./app/styles", "./tmp", "./dist" ],
    read: false
  )
  .pipe(vinylPaths(del))


#######################################################
# SASS
#######################################################
gulp.task "styles", ->
  gulp.src('./app/_sass/**/*.sass')
    # .pipe( plumber() )
    .pipe( sass({indentedSyntax: true}))
    .on("error", displayError)
    .pipe( prefix() )
    .pipe( sourcemaps.write() )
    .pipe( gulp.dest('./app/styles') )
    .pipe( filter('main.css') )
    .pipe( rename({suffix: '.min'}) )
    .pipe( minifycss() )
    .pipe( gulp.dest('./app/styles') )

gulp.task 'reloadcss', ()->
  gulp
    .src('./app/styles/main.css')
    .pipe( livereload() )

#######################################################
# CoffeeScript
#######################################################
gulp.task "scripts", ->
  gulp
    .src( "./app/_coffee/main.coffee", {read:false} )
    .pipe(browserify(
      transform: ['coffeeify']
      extensions: ['.coffee']
      debug: true
      insertGlobals: true
    ))
    .on("error", displayError)
    .pipe(concat("bundle.js"))
    # .pipe(uglify())
    .pipe gulp.dest("./app/scripts")
    .pipe( livereload() )

#######################################################
# Server CoffeeScript
#######################################################
gulp.task "serverScripts", ->
  touch 'gulpfile.coffee'

#######################################################
# HTML
#######################################################
gulp.task 'html',  ()->
  gulp
    .src('./app/**/*.html')
    .pipe( livereload() )

#######################################################
# Watch
#######################################################
gulp.task 'watch', ()->
  livereload.listen({port: pkg.config.server.port + 30000})
  gulp.watch ['./app/_sass/**/*.sass'], ['styles']
  gulp.watch ['./app/_coffee/**/*.coffee'], ['scripts']
  gulp.watch ['./app/**/*.html'], ['html']
  gulp.watch ['./app/styles/main.css'], ['reloadcss']
  gulp.watch ['./*.coffee', './lib/**/*.coffee'], ['serverScripts']

#######################################################
# Default
#######################################################
gulp.task "start", ()->
  runSequence 'clean', ['scripts', 'styles', 'server'], 'watch'

gulp.task "release", ()->
  runSequence 'clean', ['scripts', 'styles']






