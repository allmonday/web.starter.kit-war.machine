###
				   ___    ___                                                 __
				  /'___\ /'___\                                    __        /\ \__
	  ___    ___ /\ \__//\ \__/   __     __    ____    ___   _ __ /\_\  _____\ \ ,_\
	 /'___\ / __`\ \ ,__\ \ ,__\/'__`\ /'__`\ /',__\  /'___\/\`'__\/\ \/\ '__`\ \ \/
	/\ \__//\ \L\ \ \ \_/\ \ \_/\  __//\  __//\__, `\/\ \__/\ \ \/ \ \ \ \ \L\ \ \ \_
	\ \____\ \____/\ \_\  \ \_\\ \____\ \____\/\____/\ \____\\ \_\  \ \_\ \ ,__/\ \__\
	 \/____/\/___/  \/_/   \/_/ \/____/\/____/\/___/  \/____/ \/_/   \/_/\ \ \/  \/__/
																	  \ \_\
																	   \/_/

	Statement: ...//TODO: Write statement.

	Describe: Global configuration of requirejs.    ...//TODO: Check description.

	Further Changes, Comments: ...//TODO: Give a further changes and comments link.

	Javascript Design Pattern (Code Management):    ...//TODO: Cehck design pattern.

	    Namespacing Patterns, Immediately-invoked Function Expressions (IIFE)s

	    Namespacing Patterns, Nested namespacing

	    Modules Patterns, Object literal notation

	    Modules Patterns, Revealing Module Pattern

	    Modules Patterns, AMD modules

	Docs: ...//TODO: Give a link about project documents.

	Original Author: 沈维忠 ( Shen Weizhong / Tony Stark )

		Cell Phone: (+86) 15921299022

		Github：//github.com/Tony-Stark/

		Trello: //trello.com/shenweizhong/

		个人全球统一标识（ Gravatar ）：//en.gravatar.com/swzcowboy/

		个人主页（ Personal Homepage ）：//tony-stark.github.io/

		Linkedin：//cn.linkedin.com/in/itonyyo/

		Twitter: @iTonyYo, //twitter.com/iTonyYo/

		Instagram：//instagram.com/itonyyo/

		Facebook：//www.facebook.com/shenweizhong/

		Google+: //plus.google.com/114960355664861539339/

		Instagram: //instagram.com/itonyyo/

		QQ：563214029, //user.qzone.qq.com/563214029/

		Sina Weibo: //weibo.com/itonyyo/

		WhatsApp：15921299022

		微信（ WeChat ）：iTonyYo

		Facebook Messenger：shenweizhong

		Skype：live:swzyocowboy

		Line：shenweizhong

		Email: swzyocowboy@icloud.com, swzyocowboy@hotmail.com, iTonyYo@gmail.com, itonyyo@vip.qq.com, shenweizhong@facebook.com

	Thanks: ...//TODO: If there are some contributors, just mark them.

	Version: 0.1.0

	Creation Date: 2014.11.17 13:16 PM ( Tony ).

	Last Update: 2014.11.21 16:00 PM ( Tony ).    ...//TODO: Update the 'Last Update'.

	Music ( Custom ): Wolf Bite - Owl City.mp3    ...//TODO: If you are listenning some music, just write the name of songs.

	License: ...//TODO: Give a license.

	Copyright: ...//TODO: Give a copyright.
###

do (window = window, document, requirejs, console = (if typeof console isnt 'undefined' then console else undefined)) ->

	"use strict"

	boot = boot or {}



	# Begin | Options

	projectSpecJsFolder = 'web.starter.kit-war.machine'

	cdn =

		_it:

			wsk_war_machine: '//itonyyo.github.io/'

			baidu: '//libs.baidu.com/'

			microsoft: '//ajax.aspnetcdn.com/'

			google: '//ajax.googleapis.com/'

			maxcdn: '//maxcdn.bootstrapcdn.com/'

			cdnjs: '//cdnjs.cloudflare.com/'

			jsdelivr: '//cdn.jsdelivr.net/'

		dir:

			wsk_war_machine: 'public/ajax/lib/js/'

			baidu: 'public/ajax/lib/js/'

			microsoft: 'public/ajax/lib/js/'

			google: 'public/ajax/lib/js/'

			maxcdn: 'public/ajax/lib/js/'

			cdnjs: 'public/ajax/lib/js/'

			jsdelivr: 'public/ajax/lib/js/'

	baseUrl = 'public/ajax/lib/js'

	cdnjsUrl = cdn.wsk_war_machine + cdn.dir.wsk_war_machine

	jq1x = 'jquery/1.11.1/jquery.min'

	jq2x = 'jquery/2.1.1/jquery.min'

	# End | Options



	boot.getAgent = ->

		navigator.userAgent.toLowerCase()

	boot.isIE =  (userAgent) ->

		agent = userAgent or @getAgent()

		!!agent.match(/msie/i)

	boot.isGteIE9 = (userAgent) ->

		agent = userAgent or @getAgent()

		match = agent.match(/msie\D*([\.\d]*)/i)

		version = 0

		if match and match[1]

			version = match[1]

		return version >= 9

	boot.req = (jquery) ->

		requirejs.config

			baseUrl: baseUrl

			enforceDefine: true

			paths:

				modernizr: 'modernizr_amd/modernizr.min'

				jqPrivate: 'jquery_private/jquery.private.min'

				jquery: jquery

				jqMigrate: 'jquery_migrate/1.2.1/jquery.migrate.min'

				srl: 'jquery_nicescroll/3.5.4/jquery.nicescroll.min'

				component: projectSpecJsFolder + '/component'

			waitSeconds: 120

			map:

				'*':

					'jquery': 'jqPrivate'

				'jqPrivate':

					'jquery': 'jquery'

			skipDataMain: true

		return

	boot.judgement = (opts) ->

		if @isIE()

			if @isGteIE9() then @req(jq2x) else @req(jq1x)

		else

			@req(jq2x)

		return

	fn = ->

		boot.judgement()

		return

	_AMD = do (_register = _AMD or {}, _module = fn) ->

		hasDefine = typeof define is "function" and define.amd

		registryProfile = ->

			if hasDefine then define(_module) else console.error('Sorry! There is no "define" object.')

		return init: registryProfile

	_AMD.init()

	return