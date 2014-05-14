gulp    = require 'gulp'
bower   = require 'gulp-bower'
clean   = require 'gulp-clean'
coffee  = require 'gulp-coffee'
sass    = require 'gulp-sass'
concat  = require 'gulp-concat'
uglify  = require 'gulp-uglify'
connect = require 'gulp-connect'
debug   = require 'gulp-debug'
changed = require 'gulp-changed'
{log, colors, beep} = require 'gulp-util'
{mkdirSync} = require 'fs'

vendorPath = 'app/vendor'
buildDir   = '.build'

src =
  html: [
    'app/**/*.html'
    "!#{vendorPath}"
    "!#{vendorPath}/**"
  ]
  scripts: 'app/scripts/**/*'
  styles:  'app/styles/**/*'
  images:  'app/images/**/*'

error = (e) ->
  log colors.red(e)
  beep()

gulp.task 'html', ->
  gulp.src src.html
    .pipe changed(buildDir)
    .pipe gulp.dest(buildDir)

gulp.task 'coffee', ->
  dest = "#{buildDir}/scripts"
  gulp.src src.scripts
    .pipe changed(dest, extension: '.js')
    .pipe coffee(sourceMap: true)
    .on 'error', error
    .pipe gulp.dest(dest)
    .pipe

gulp.task 'sass', ->
  dest = "#{buildDir}/styles"
  gulp.src src.styles
    .pipe changed(dest, extension: '.css')
    .pipe sass(onError: error)
    .pipe gulp.dest(dest)

gulp.task 'watch', ->
  gulp.watch src.html, ['html']
  gulp.watch src.scripts, ['coffee']
  gulp.watch src.styles, ['sass']
  gulp.watch "#{buildDir}/**/*"
    .on 'change', (e) -> gulp.src(e.path).pipe connect.reload()

gulp.task 'bower', -> bower(vendorPath)
gulp.task 'clean', -> gulp.src(buildDir, read: false).pipe clean()
gulp.task 'reset', ['bower', 'clean'], -> mkdirSync(buildDir)
gulp.task 'build', ['reset'], ->
  gulp.start 'html', 'coffee', 'sass'

gulp.task 'serve', ->
  connect.server
    root: [buildDir, 'app']
    livereload: true

gulp.task 'default', ['build', 'serve', 'watch']

