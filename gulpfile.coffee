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
#	Last Update: 2014.11.23 06:40 PM ( Tony ).    ...//TODO: Update the 'Last Update'.
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
# 从命令行为相关任务传输参数。
# @example
# // gulp smaple_task --env dev
# // gulp sample_task --cmprs
# // gulp sample_task --env dev --cmprs
# gulp.task 'smaple_task', ->
#     gulp.src 'sample_path'
#     .pipe $.if __args.env is 'dev', $.notify 'task!'
#     .pipe $.if __args.cmprs, $.notify 'compressed!'
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

__args = parse_args process.argv.slice(2),

	'string': ['env']

	'boolean': ['minhtml', 'csso', 'uglify', 'size', 'notify', 'p']

	'default':

		env: process.env.NODE_ENV or 'production'

# @description
# " config.preview " 设定预览、实时预览所需要的参数。 " config.path "
# 设定常用相关文件夹、文件的相对路径...
# 将所有选项放置在单独的 " config.json " 文件里是有益的，这可以让构建任
# 务内容更清晰，而且也可以被别的构建工具比如 " Grunt " 使用。
# （ 关于 config.sass_opts，这儿有个小贴士：you can find the reson why I write
# " 'sourcemap=none': true " here, not " sourcemap: false ",
# https://github.com/sindresorhus/gulp-ruby-sass/issues/113#issuecomment-53778451 ）
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

config = require('./config.json');



# @name html_size
# @description 输出 HTML 文件的体积（容量）。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

html_size = lazypipe()

	.pipe ->

		$.if __args.size, $.if '*.html', $.size title: 'html'



# @name css_size
# @description 输出 CSS 文件的体积（容量）。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

css_size = lazypipe()

	.pipe ->

		$.if __args.size, $.if '*.css', $.size title: 'css'



# @name js_size
# @description 输出 JS 文件的体积（容量）。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

js_size = lazypipe()

	.pipe ->

		$.if __args.size, $.if '*.js', $.size title: 'javascript'



# @name jade
# @description 配置 Jade （模板引擎）预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_jade = lazypipe()

	.pipe $.changed, config.path.html

	.pipe $.jade

	.pipe $.plumber

	.pipe gulp.dest, config.path.html

	.pipe ->

		$.if __args.minhtml, $.minifyHtml config.html_cmprs_opts

	.pipe gulp.dest, config.path.html

	.pipe html_size

	.pipe ->

		$.if __args.notify, $.notify config.message.jade

gulp.task 'jade', ->

	gulp.src config.path.jade.unit + '/*.jade'

	.pipe _jade()



# @name sass
# @description 配置针对指定目录下多个层级目录中的 SASS （预编辑）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass = lazypipe()

	.pipe $.changed, config.path.css.root

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.root

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.root

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass', ->

	gulp.src config.path.sass.root + '/**/*.sass'

	.pipe _sass()



# @name sass_root
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_root = lazypipe()

	.pipe $.changed, config.path.css.root

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.root

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.root

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_root', ->

	gulp.src config.path.sass.root + '/*.sass'

	.pipe _sass_root()



# @name sass_wsk
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wsk = lazypipe()

	.pipe $.changed, config.path.css.wsk

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wsk

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wsk

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wsk', ->

	gulp.src config.path.sass.wsk + '/*.sass'

	.pipe _sass_wsk()



# @name sass_wskf
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wskf = lazypipe()

	.pipe $.changed, config.path.css.wskf

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wskf', ->

	gulp.src config.path.sass.wskf + '/*.sass'

	.pipe _sass_wskf()



# @name sass_wskf_base
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wskf_base = lazypipe()

	.pipe $.changed, config.path.css.wskf_base

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_base

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_base

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wskf_base', ->

	gulp.src config.path.sass.wskf_base + '/*.sass'

	.pipe _sass_wskf_base()



# @name sass_wskf_component
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wskf_component = lazypipe()

	.pipe $.changed, config.path.css.wskf_component

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_component

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_component

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wskf_component', ->

	gulp.src config.path.sass.wskf_component + '/*.sass'

	.pipe _sass_wskf_component()



# @name sass_wskf_mq
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wskf_mq = lazypipe()

	.pipe $.changed, config.path.css.wskf_mq

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_mq

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_mq

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wskf_mq', ->

	gulp.src config.path.sass.wskf_mq + '/*.sass'

	.pipe _sass_wskf_mq()



# @name sass_wskf_scaffolding
# @description 配置针对指定目录下的 SASS （预处理）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_sass_wskf_scaffolding = lazypipe()

	.pipe $.changed, config.path.css.wskf_scaffolding

	.pipe $.rubySass, config.sass_opts                               # it's "rubySass", not "sass"... see more, https://github.com/yeoman/generator-gulp-webapp/issues/14

	.pipe $.plumber

	.pipe gulp.dest, config.path.css.wskf_scaffolding

	.pipe  ->

		$.if __args.csso, $.csso()

	.pipe gulp.dest, config.path.css.wskf_scaffolding

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.sass

gulp.task 'sass_wskf_scaffolding', ->

	gulp.src config.path.sass.wskf_scaffolding + '/*.sass'

	.pipe _sass_wskf_scaffolding()



# @name coffeescript
# @description 配置针对指定目录下多个层级目录中的 Coffeescript （预编辑）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_cs = lazypipe()

	.pipe $.changed, config.path.javascript.root

	.pipe $.plumber

	.pipe $.coffee, config.cs_opts

	.pipe gulp.dest, config.path.javascript.root

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.root

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript', ->

	gulp.src config.path.coffeescript.root + '/**/*.coffee'

	.pipe _cs()



# @name coffeescript_wsk
# @description 配置针对指定目录下的 Coffeescript （预编辑）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_cs_wsk = lazypipe()

	.pipe $.changed, config.path.javascript.wsk

	.pipe $.plumber

	.pipe $.coffee, config.cs_opts

	.pipe gulp.dest, config.path.javascript.wsk

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wsk', ->

	gulp.src config.path.coffeescript.wsk + '/*.coffee'

	.pipe _cs_wsk()



# @name coffeescript_wskf
# @description 配置针对指定目录下的 Coffeescript （预编辑）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_cs_wskf = lazypipe()

	.pipe $.changed, config.path.javascript.wskf

	.pipe $.plumber

	.pipe $.coffee, config.cs_opts

	.pipe gulp.dest, config.path.javascript.wskf

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wskf

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wskf', ->

	gulp.src config.path.coffeescript.wskf + '/*.coffee'

	.pipe _cs_wskf()



# @name coffeescript_wsk_logic
# @description 配置针对指定目录下的 Coffeescript （预编辑）文件的预处理任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_cs_wsk_logic = lazypipe()

	.pipe $.changed, config.path.javascript.wsk_logic

	.pipe $.plumber

	.pipe $.coffee, config.cs_opts

	.pipe gulp.dest, config.path.javascript.wsk_logic

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk_logic

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_wsk_logic', ->

	gulp.src config.path.coffeescript.wsk_logic + '/*.coffee'

	.pipe _cs_wsk_logic()



# @name coffeescript_component
# @description 配置针对指定目录下的 Coffeescript （预编辑）文件的预处理任务。
# @name coffeescript
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_cs_component = lazypipe()

	.pipe $.changed, config.path.javascript.wsk_component

	.pipe $.plumber

	.pipe $.coffee, config.cs_opts

	.pipe gulp.dest, config.path.javascript.wsk_component

	.pipe ->

		$.if __args.uglify, $.uglify config.uglify_opts

	.pipe gulp.dest, config.path.javascript.wsk_component

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.coffeescript

gulp.task 'coffeescript_component', ->

	gulp.src config.path.coffeescript.wsk_component + '/*.coffee'

	.pipe _cs_component()



# @name html_cmprs
# @description 配置针对 HTML 文件的压缩（处理）任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_html_cmprs = lazypipe()

	.pipe $.minifyHtml, config.html_cmprs_opts

	.pipe gulp.dest, config.path.html

	.pipe html_size

	.pipe ->

		$.if __args.notify, $.notify config.message.html_cmprs

gulp.task 'html_cmprs', ->

	gulp.src config.path.html + '/*.html'

	.pipe _html_cmprs()



# @name css_uncss
# @description 根据当前项目中所有 HTML 文件对样式表的依赖情况进行样式表方面的 " 瘦身 " 优化。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_css_uncss = lazypipe()

	.pipe $.uncss, html: glob.sync config.path.html + '/*.html'

	.pipe gulp.dest, config.path.css.root

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.css_uncss

gulp.task 'css_uncss', () ->

	gulp.src [

		config.path.css.root + '/**/*.css'

		config.path.css.bower + '/**/*.css'

	]

	.pipe _css_uncss()



# @name css_csso
# @description 对指定目录下 CSS 样式表文件进行结构性的优化以跟深层次压缩体积。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_csso_self = lazypipe()

	.pipe $.csso

	.pipe gulp.dest, config.path.css.wsk

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.css_csso

_csso_framework = lazypipe()

	.pipe $.csso

	.pipe gulp.dest, config.path.css.wskf

	.pipe css_size

	.pipe ->

		$.if __args.notify, $.notify config.message.css_csso

gulp.task 'css_csso', ->

	css_self = gulp.src config.path.css.wsk + '/**/*.css'

	.pipe _csso_self()

	css_framework = gulp.src config.path.css.wskf + '/**/*.css'

	.pipe _csso_framework()

	mrg_src = mrg css_self, css_framework



# @name js_cmprs
# @description 配置针对指定目录下多个层级目录中的  JavaScript 文件的压缩（处理）任务。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_js_cmprs = lazypipe()

	.pipe $.uglify

	.pipe gulp.dest, config.path.javascript.wsk

	.pipe js_size

	.pipe ->

		$.if __args.notify, $.notify config.message.js_cmprs

gulp.task 'js_cmprs', ->

	gulp.src [

		config.path.javascript.wsk + '/**/*.js'

		config.path.javascript.wskf + '/**/*.js'

	]

	.pipe _js_cmprs()



# @name html_changed
# @description 指定目录下 HTML 文件发生变动后要执行的操作。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_html_changed = lazypipe()

	.pipe $.connect.reload

	.pipe ->

		$.if __args.notify, $.notify config.message.html

gulp.task 'html_changed', ->

	gulp.src config.path.html + '/*.html',

		base: config.path.html

	.pipe _html_changed()



# @name css_changed
# @description 指定目录下包括其下多个层级目录中的 CSS 文件发生变动后要执行的操作。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_css_changed = lazypipe()

	.pipe $.connect.reload

gulp.task 'css_changed', ->

	gulp.src config.path.css.root + '/**/*.css'

	.pipe _css_changed()



# @name js_changed
# @description 指定目录下包括其下多个层级目录中的 JavaScript 文件发生变动后要执行的操作。
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

_js_changed = lazypipe()

	.pipe $.connect.reload

gulp.task 'js_changed', ->

	js_self = gulp.src config.path.javascript.wsk + '/**/*.js'

	js_self_framework = gulp.src config.path.javascript.wskf + '/*.js'

	_mrg_src = mrg js_self, js_self_framework

	_mrg_src.pipe _js_changed()



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
# @description 从命令行界面打开浏览器并访问给定地址。
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



# @name html
# @description 监听（监视）指定目录下（或包括其下多个层级目录中）的相关类型文件的（认为或机器）修改行为（活动）。
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



# @name default
# @description 运行 " gulp " 命令时默认执行的任务。可添加参数 "--p" 以附加相关操作任务。
# @example
# $ gulp
# $ gulp -p
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'default', (cb) ->

	if __args.p

		run_sequence ['jade', 'sass', 'coffeescript'], ['connect', 'open', 'watch'], cb

	else

		run_sequence ['connect', 'open', 'watch'], cb

	return



# @name default
# @description 压缩、优化任务的集合。
# @example
# $ gulp cmprs
# @author 沈维忠 ( Shen Weizhong / Tony Stark )

gulp.task 'cmprs', (cb) ->

	run_sequence 'css_uncss', ['html_cmprs', 'css_csso', 'js_cmprs'], cb

	return
