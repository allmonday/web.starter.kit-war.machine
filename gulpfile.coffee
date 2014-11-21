#				   ___    ___                                                 __
#				  /'___\ /'___\                                    __        /\ \__
#	  ___    ___ /\ \__//\ \__/   __     __    ____    ___   _ __ /\_\  _____\ \ ,_\
#	 /'___\ / __`\ \ ,__\ \ ,__\/'__`\ /'__`\ /',__\  /'___\/\`'__\/\ \/\ '__`\ \ \/
#	/\ \__//\ \L\ \ \ \_/\ \ \_/\  __//\  __//\__, `\/\ \__/\ \ \/ \ \ \ \ \L\ \ \ \_
#	\ \____\ \____/\ \_\  \ \_\\ \____\ \____\/\____/\ \____\\ \_\  \ \_\ \ ,__/\ \__\
#	 \/____/\/___/  \/_/   \/_/ \/____/\/____/\/___/  \/____/ \/_/   \/_/\ \ \/  \/__/
#																	  \ \_\
#																	   \/_/
#
#	Statement: ...//TODO: Write statement.
#
# 	Describe:     ...//TODO: Check description.
#
# 	Further Changes, Comments: ...//TODO: Give a further changes and comments link.
#
# 	Javascript Design Pattern (Code Management):    ...//TODO: Cehck design pattern.
#
# 	    Namespacing Patterns, Immediately-invoked Function Expressions (IIFE)s
#
# 	    Modules Patterns, Revealing Module Pattern
#
# 	    Modules Patterns, AMD modules
#
# 	Docs: ...//TODO: Give a link about project documents.
#
# 	Original Author: 沈维忠 ( Shen Weizhong / Tony Stark )
#
#		Cell Phone: (+86) 15921299022
#
#		Github：//github.com/Tony-Stark/
#
#		Trello: //trello.com/shenweizhong/
#
#		个人全球统一标识（ Gravatar ）：//en.gravatar.com/swzcowboy/
#
#		个人主页（ Personal Homepage ）：//tony-stark.github.io/
#
#		Linkedin：//cn.linkedin.com/in/itonyyo/
#
#		Twitter: @iTonyYo, //twitter.com/iTonyYo/
#
#		Instagram：//instagram.com/itonyyo/
#
#		Facebook：//www.facebook.com/shenweizhong/
#
#		Google+: //plus.google.com/114960355664861539339/
#
#		Instagram: //instagram.com/itonyyo/
#
#		QQ：563214029, //user.qzone.qq.com/563214029/
#
#		Sina Weibo: //weibo.com/itonyyo/
#
#		WhatsApp：15921299022
#
#		微信（ WeChat ）：iTonyYo
#
#		Facebook Messenger：shenweizhong
#
#		Skype：live:swzyocowboy
#
#		Line：shenweizhong
#
#		Email: swzyocowboy@icloud.com, swzyocowboy@hotmail.com, iTonyYo@gmail.com, itonyyo@vip.qq.com, shenweizhong@facebook.com
#
#	Thanks: ...//TODO: If there are some contributors, just mark them.
#
# 	Version: 0.1.0
#
#	Creation Date: 2014.11.14 11:03 PM ( Tony ).
#
#	Last Update: 2014.11.21 19:11 PM ( Tony ).    ...//TODO: Update the 'Last Update'.
#
#	Music ( Custom ): Fireproof (One Direction).mp3    ...//TODO: If you are listenning some music, just write the name of songs.
#
#	License: ...//TODO: Give a license.
#
#	Copyright: ...//TODO: Give a copyright.



gulp         = require 'gulp'

parse_args   = require 'minimist'

lazypipe     = require 'lazypipe'

mrg          = require 'merge-stream'

glob         = require 'glob'

run_sequence = require 'run-sequence'

$            = require('gulp-load-plugins')()

# @description
# 从命令行传输参数。
# @example
# // gulp smaple_task --env dev
# // gulp sample_task --cmprs
# // gulp sample_task --env dev --cmprs
# gulp.task 'smaple_task', ->
#     gulp.src 'sample_path'
#     .pipe $.if __args.env is 'dev', $.notify 'task!'
#     .pipe $.if __args.cmprs, $.notify 'compressed!'
#     return
__args = parse_args process.argv.slice(2),

	'string': ['env']

	'boolean': ['minhtml', 'csso', 'uglify', 'size', 'notify', 'p']

	'default':

		env: process.env.NODE_ENV or 'production'

# @description
# " config.preview " 设定预览、实时预览所需要的参数。 " config.path "
# 设定常用相关文件夹、文件的相对路径。
# 将所有选项放置在单独的 " config.json " 文件里是有益的，这可以让构建任
# 务内容更清晰，而且也可以被别的构建工具比如 " Grunt " 使用。
# （ you can find the reson why I write
# " 'sourcemap=none': true " here, not " sourcemap: false ",
# https://github.com/sindresorhus/gulp-ruby-sass/issues/113#issuecomment-53778451 ）
#
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

config = require('./config.json');



# @name jade
# @description 配置 Jade 模板引擎预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

jade_channel = lazypipe()

	.pipe $.changed, config.path.html

	.pipe $.jade

	.pipe $.plumber

	.pipe gulp.dest, config.path.html

	.pipe ->

		$.if __args.minhtml, $.minifyHtml config.html_minification_opts

	.pipe gulp.dest, config.path.html

	.pipe ->

		$.if __args.size, $.size

			title: 'html'

	.pipe ->

		$.if __args.notify, $.notify config.message.jade

gulp.task 'jade', ->

	gulp.src config.path.jade.unit + '/*.jade'

	.pipe jade_channel()



# @name html_minification
# @description 配置针对 HTML 文件的处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'html_minification', ->

	gulp.src config.path.html + '/*.html'

	.pipe $.minifyHtml config.html_minification_opts

	.pipe gulp.dest config.path.html

	.pipe $.if __args.size, $.size

		title: 'html'

	.pipe $.if __args.notify, $.notify config.message.minhtml



# @name sass_channel
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_channel = lazypipe()

	.pipe $.changed, config.path.css.root

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.root

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.root

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass', ->

	gulp.src config.path.sass.root + '/**/*.sass'

	.pipe sass_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_root_channel = lazypipe()

	.pipe $.changed, config.path.css.root

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.root

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.root

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_root', ->

	gulp.src config.path.sass.root + '/*.sass'

	.pipe sass_root_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wsk_channel = lazypipe()

	.pipe $.changed, config.path.css.wsk

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wsk

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wsk

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wsk', ->

	gulp.src config.path.sass.wsk + '/*.sass'

	.pipe sass_wsk_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wskf_channel = lazypipe()

	.pipe $.changed, config.path.css.wskf

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wskf', ->

	gulp.src config.path.sass.wskf + '/*.sass'

	.pipe sass_wskf_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wskf_base_channel = lazypipe()

	.pipe $.changed, config.path.css.wskf_base

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_base

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_base

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wskf_base', ->

	gulp.src config.path.sass.wskf_base + '/*.sass'

	.pipe sass_wskf_base_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wskf_component_channel = lazypipe()

	.pipe $.changed, config.path.css.wskf_component

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_component

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_component

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wskf_component', ->

	gulp.src config.path.sass.wskf_component + '/*.sass'

	.pipe sass_wskf_component_channel()



# @name sass
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wskf_mq_channel = lazypipe()

	.pipe $.changed, config.path.css.wskf_mq

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_mq

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_mq

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wskf_mq', ->

	gulp.src config.path.sass.wskf_mq + '/*.sass'

	.pipe sass_wskf_mq_channel()



# @name sass_wskf_scaffolding
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

sass_wskf_scaffolding_channel = lazypipe()

	.pipe $.changed, config.path.css.wskf_scaffolding

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_scaffolding

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_scaffolding

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

	.pipe ->

		$.if __args.size, $.size

			title: 'css'

gulp.task 'sass_wskf_scaffolding', ->

	gulp.src config.path.sass.wskf_scaffolding + '/*.sass'

	.pipe sass_wskf_scaffolding_channel()



# @name css_csso
# @description 配置针对 HTML 文件的处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'css_uncss', () ->

	# UNCSS

	gulp.src [

		config.path.css.root + '/**/*.css'

		config.path.css.bower + '/**/*.css'

	]

	.pipe $.uncss

		html: glob.sync config.path.html + '/*.html'

	.pipe gulp.dest config.path.css.root

	.pipe $.if __args.size, $.size

		title: 'css'

	.pipe $.if __args.notify, $.notify config.message.css_uncss



# @name css_csso
# @description 配置针对 HTML 文件的处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'css_csso', ->

	# CSSO

	css_self = gulp.src config.path.css.wsk + '/**/*.css'

	.pipe $.csso()

	.pipe gulp.dest config.path.css.wsk

	.pipe $.if __args.size, $.size

		title: 'css'

	.pipe $.if __args.notify, $.notify config.message.css_csso

	css_framework = gulp.src config.path.css.wskf + '/**/*.css'

	.pipe $.csso()

	.pipe gulp.dest config.path.css.wskf

	.pipe $.if __args.size, $.size

		title: 'css'

	.pipe $.if __args.notify, $.notify config.message.css_csso

	mrg_src = mrg css_self, css_framework



# @name coffeescript
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

coffeescript_channel = lazypipe()

	.pipe $.changed, config.path.javascript.root

	.pipe $.plumber

	.pipe $.coffee, config.coffee_opts

	.pipe gulp.dest, config.path.javascript.root

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.root

	.pipe ->

		$.if __args.size, $.size

			title: 'javascript'

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript', ->

	gulp.src config.path.coffeescript.root + '/**/*.coffee'

	.pipe coffeescript_channel()



# @name coffeescript
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

coffeescript_wsk_channel = lazypipe()

	.pipe $.changed, config.path.javascript.wsk

	.pipe $.plumber

	.pipe $.coffee, config.coffee_opts

	.pipe gulp.dest, config.path.javascript.wsk

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk

	.pipe ->

		$.if __args.size, $.size

			title: 'javascript'

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wsk', ->

	gulp.src config.path.coffeescript.wsk + '/*.coffee'

	.pipe coffeescript_wsk_channel()



# @name coffeescript
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

coffeescript_wskf_channel = lazypipe()

	.pipe $.changed, config.path.javascript.wskf

	.pipe $.plumber

	.pipe $.coffee, config.coffee_opts

	.pipe gulp.dest, config.path.javascript.wskf

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wskf

	.pipe ->

		$.if __args.size, $.size

			title: 'javascript'

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wskf', ->

	gulp.src config.path.coffeescript.wskf + '/*.coffee'

	.pipe coffeescript_wskf_channel()



# @name coffeescript
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

coffeescript_wsk_logic_channel = lazypipe()

	.pipe $.changed, config.path.javascript.wsk_logic

	.pipe $.plumber

	.pipe $.coffee, config.coffee_opts

	.pipe gulp.dest, config.path.javascript.wsk_logic

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk_logic

	.pipe ->

		$.if __args.size, $.size

			title: 'javascript'

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wsk_logic', ->

	gulp.src config.path.coffeescript.wsk_logic + '/*.coffee'

	.pipe coffeescript_wsk_logic_channel()



# @name coffeescript_component
# @description
# @name coffeescript
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

coffeescript_component_channel = lazypipe()

	.pipe $.changed, config.path.javascript.wsk_component

	.pipe $.plumber

	.pipe $.coffee, config.coffee_opts

	.pipe gulp.dest, config.path.javascript.wsk_component

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk_component

	.pipe ->

		$.if __args.size, $.size

			title: 'javascript'

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_component', ->

	gulp.src config.path.coffeescript.wsk_component + '/*.coffee'

	.pipe coffeescript_component_channel()



# @name js_minification
# @description 配置针对 HTML 文件的处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'js_minification', ->

	gulp.src [

		config.path.javascript.wsk + '/**/*.js'

		config.path.javascript.wskf + '/**/*.js'

	]

	.pipe $.uglify()

	.pipe gulp.dest config.path.javascript.wsk

	.pipe $.if __args.size, $.size

		title: 'javascript'

	.pipe $.if __args.notify, $.notify config.message.js_minification



# @name html_changed
# @description 配置针对 HTML 文件的处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

html_changed_channel = lazypipe()

	.pipe $.connect.reload

	.pipe ->

		$.if __args.notify, $.notify config.message.html

gulp.task 'html_changed', ->

	gulp.src config.path.html + '/*.html',

		base: config.path.html

	.pipe html_changed_channel()



# @name css_changed
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

css_changed_channel = lazypipe()

	.pipe $.connect.reload

gulp.task 'css_changed', ->

	gulp.src config.path.css.root + '/**/*.css'

	.pipe css_changed_channel()



# @name js_changed
# @description
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

js_changed_channel = lazypipe()

	.pipe $.connect.reload

gulp.task 'js_changed', ->

	js_self = gulp.src config.path.javascript.wsk + '/**/*.js'

	js_self_framework = gulp.src config.path.javascript.wskf + '/*.js'

	_mrg_src = mrg js_self, js_self_framework

	_mrg_src.pipe js_changed_channel()



# @name manifest
# @description 生成 HTML5 应用程序缓存清单。

gulp.task 'manifest', ->

	gulp.src config.manifest_list

	.pipe $.manifest

		hash: true

		preferOnline: true

		timestamp: true

		network: ['http://*', 'https://*', '*']

		filename: 'app.manifest'

		exclude: 'app.manifest'

	.pipe gulp.dest config.path.html



# @name open
# @description 从命令行打开浏览器并访问给定地址。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'open', ->

	gulp.src config.path.html + '/index.html',

		base: config.path.html

	.pipe $.open '',

		url: 'http://' + config.preview.host + ':' + config.preview.port + '/'



# @name connect
# @description 创建并配置 HTTP 服务器以供预览或实时预览。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'connect', ->

	$.connect.server

		root: config.preview.dir

		port: config.preview.port

		livereload: config.preview.livereload



# @name serve
# @description 创建并配置 HTTP 服务器以供预览或实时预览。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'serve', ->

	browserSync

		logPrefix: 'Tony_Stark'

		open: true

		server:

			baseDir: 'app'

			index: 'index.html'

			middleware: (req, res, next) ->

				console.log 'Hi from middleware'

				next()

				return

		port: 9022

		notify: false

	, (err, bs) ->

		if !err

			console.log 'BrowserSync is ready!'

		else

			console.log 'Fuck No!'

		return

	gulp.watch ['*.html'],

		cwd: 'app'

	, reload

	return



# @name html
# @description 监听指定类型文件、活动。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'watch', ->

	# begin view

	gulp.watch '*.html',

		cwd: config.path.html

	, ['html_changed']

	gulp.watch '**/*.jade',

		cwd: config.path.jade.root

	, ['jade']

	# begin stylesheet

	gulp.watch '**/*.css',

		cwd: config.path.css.root

	, ['css_changed']

	gulp.watch '*.sass',

		cwd: config.path.sass.root

	, ['sass_root']

	gulp.watch '*.sass',

		cwd: config.path.sass.wsk

	, ['sass_wsk']

	gulp.watch '*.sass',

		cwd: config.path.sass.wskf

	, ['sass_wskf']

	gulp.watch '*.sass',

		cwd: config.path.sass.wskf_base

	, ['sass_wskf_base']

	gulp.watch '*.sass',

		cwd: config.path.sass.wskf_component

	, ['sass_wskf_component']

	gulp.watch '*.sass',

		cwd: config.path.sass.wskf_mq

	, ['sass_wskf__mq']

	gulp.watch '*.sass',

		cwd: config.path.sass.wskf_scaffolding

	, ['sass_wskf_scaffolding']

	# 只监测修改频繁高的目录下的 JavaScript 文件

	gulp.watch [

		config.path.javascript.wsk + '/**/*.js'

		config.path.javascript.wskf + '/*.js'

	]

	, ['js_changed']

	gulp.watch '*.coffee',

		cwd: config.path.coffeescript.wsk

	, ['coffeescript_wsk']

	gulp.watch '*.coffee',

		cwd: config.path.coffeescript.wsk_logic

	, ['coffeescript_wsk_logic']

	gulp.watch '*.coffee',

		cwd: config.path.coffeescript.root

	, ['coffeescript_component']

	gulp.watch '*.coffee',

		cwd: config.path.coffeescript.wskf

	, ['coffeescript_wskf']

	return



# @name contributors
# @description 将所有贡献者罗列在 README.md 文件中。
# @example
# $ gulp contributors
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'contributors', ->

	gulp.src 'README.md'

	.pipe $.plumber()

	.pipe $.contribs '##贡献者清单', '##许可证'

	.pipe gulp.dest './'



# @name default
# @description 运行 " gulp " 命令时默认执行的任务。
# @example
# $ gulp
# $ gulp -p
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'default', (cb) ->

	if __args.p

		run_sequence ['jade', 'sass', 'coffeescript'], ['connect', 'open', 'watch'], cb

	else

		run_sequence ['connect', 'open', 'watch']

	return



# @name default
# @description 压缩、优化任务的集合。
# @example
# $ gulp cmprs
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'cmprs', (cb) ->

	run_sequence 'css_uncss', ['html_minification', 'css_csso', 'js_minification'], cb

	return
