/*
ToDo
 - Add uglify
 - debug
*/
var	gulp           = require('gulp'),
	nodemon        = require('gulp-nodemon'),
	concat         = require('gulp-concat'),
	jade           = require('gulp-jade'),
	browserSync    = require('browser-sync').create(),
	sourcemaps     = require('gulp-sourcemaps'),
	sass           = require('gulp-sass'),
	// uglify		   = require('gulp-minify-css'),
	elm            = require('gulp-elm'),
    runSequence    = require('run-sequence');

var paths = {
	compileDestination: "dist",
	server  : './server',
	home    : ['src/index.jade'],
	scss    : ['src/**/*.scss'],
	elm     : "src/**/*.elm",
	elmMain     : "src/Main.elm"
};

/*
 * S E R V E R
 */
gulp.task('serve', function(cb){
	var called = false;
	return nodemon({
		"script": 'server/bin/www',     // port 5000 by default
	    "watch": paths.server,
		"ext": "js"
	})
	.on('start', function () {
		if (!called) {
	       called = true;
	       cb();
		}
  	})
	.on('restart', function () {
      console.log('restarted!')
    })
});

/*
 * H T M L / C S S
 */

// runs jade on index.jade
gulp.task('home', function() {
	return gulp.src(paths.home)
	.pipe(jade({pretty: true}))
	.pipe(gulp.dest(paths.compileDestination));
});

gulp.task('sass', function() {
	return gulp.src(paths.scss)
	.pipe(sass().on('error', sass.logError))
	.pipe(concat('styles.css'))
	.pipe(gulp.dest(paths.compileDestination))
	.pipe(browserSync.stream()); 			// injects new styles without page reload!
});

gulp.task('compilation', ['home', 'sass']);

/*
 * E L M
 */

 gulp.task('elm-init', elm.init);

 gulp.task('elm-compile', ['elm-init'], function() {
	 // By explicitly handling errors, we prevent Gulp crashing when compile fails
     function onErrorHandler(err) {
         console.log(err.message);
     }
     return gulp.src(paths.elmMain)             // "./src/Main.elm"
         .pipe(elm())
         .on('error', onErrorHandler)
         .pipe(gulp.dest(paths.compileDestination));
 })

/*
 * D E V E L O P M E N T
 */

 gulp.task('watch', ['serve'], function() {
 	browserSync.init({
 		proxy: 'localhost:5000',
 	});

	gulp.watch(paths.home, ['home']);
	gulp.watch(paths.scss, ['sass']);
	gulp.watch(paths.elm, ['elm-compile']);
	gulp.watch(paths.compileDestination+"/*.{js,html}").on('change', browserSync.reload);
 });

/*
 * P R O D U C T I O N
 * T B C
 */

/*
 * A P I
 */
gulp.task('default', ['compilation', 'elm-compile', 'watch']);
