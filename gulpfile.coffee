gulp       = require 'gulp'
bower      = require 'gulp-bower'
gulpClean  = require 'gulp-clean'
coffee     = require 'gulp-coffee'
sass       = require 'gulp-sass'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
reload     = require 'gulp-livereload'
express    = require 'express'
connectLR  = require 'connect-livereload'
livereload = require 'tiny-lr'
debug      = require 'gulp-debug'
{log, colors, beep} = require 'gulp-util'

Function::curry = ->
  fn = this
  args = Array::slice.call(arguments)
  -> fn.apply this, args.concat(Array::slice.call(arguments))

# Params
patterns =
  html: [
    './**/*.html'
    './!{bower_components,bower_components/**}'
  ]
  scripts: './scripts/**/*'
  styles:  './styles/**/*'
  images:  './images/**/*'

vendorPath = 'app/vendor'

Build =
  html: (source) ->
    log colors.yellow("copying #{source}...")
    gulp.src source, cwd: 'app/'
      .pipe gulp.dest('build')

  scripts: (source) ->
    log colors.yellow("compiling #{source}...")
    gulp.src source, cwd: 'app/'
      .pipe coffee(sourceMap: true)
      .on 'error', (e) ->
        log colors.red(e)
        beep()
      .pipe gulp.dest('build/scripts')

  styles: (source) ->
    log colors.yellow("compiling #{source}...")
    gulp.src source, cwd: 'app/'
      .pipe sass(sourceComments: 'map')
      .pipe gulp.dest('build/styles')

clean = (path) ->
  log colors.yellow("removing #{path}...")
  gulp.src(path, read: false, cwd: 'build/').pipe gulpClean()

lr = livereload()
watch = (key, e) ->
  buildMethod = Build[key]

  log colors.cyan("#{e.path} #{e.type}...")
  if e.type is 'deleted'
    appPath = __dirname + '/app'
    path = e.path.replace(appPath, 'build').replace(/\.\w+$/, '.*')
    clean(path).pipe reload(lr)
  else
    buildMethod(e.path).pipe reload(lr)

# Tasks
methods = Object.keys(Build)

for method in methods
  gulp.task "clean:#{method}", clean.curry( patterns[method] )
  gulp.task "build:#{method}", ["clean:#{method}"], Build[method].curry( patterns[method] )
  gulp.task "watch:#{method}", gulp.watch.curry( 'app/' + patterns[method], watch.curry(method) )

gulp.task 'clean', clean.curry('./**/*')
gulp.task 'build', ['bower', 'clean', ("build:#{method}" for method in methods)...]
gulp.task 'watch', ("watch:#{method}" for method in methods)
gulp.task 'bower', bower.curry(vendorPath)

gulp.task 'serve', ->
  lr.listen(35729)
  port = 9000
  app  = express()
  app.use connectLR()
  app.use '/', express.static(__dirname + '/build')
  app.use '/vendor', express.static(__dirname + vendorPath)
  app.listen port
  log colors.yellow(">>>> Listening on port #{port}")
  reload(lr)

gulp.task 'default', ['build', 'serve', 'watch']
