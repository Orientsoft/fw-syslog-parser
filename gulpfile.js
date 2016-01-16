var gulp = require('gulp')
var gutil = require('gulp-util')
var ignore = require('gulp-ignore')
var rimraf = require('gulp-rimraf')

var peg = require('gulp-peg')

gulp.task('build', function() {
  gulp.src('./src/*.pegjs')
    .pipe(peg().on('error', gutil.log))
    .pipe(gulp.dest('./lib'))
})

gulp.task('dist-clean', ['clean', 'clean-config'], function() {

})

gulp.task('clean', function() {
  return gulp.src('./lib/*.js', {read: false})
    .pipe(rimraf())
})

gulp.task('clean-config', function() {
  return gulp.src('./config/*.js', {read: false})
    .pipe(ignore('default.js'))
    .pipe(rimraf())
})
