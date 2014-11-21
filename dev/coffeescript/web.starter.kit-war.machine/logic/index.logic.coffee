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

 	Describe:     ...//TODO: Check description.

 	Further Changes, Comments: ...//TODO: Give a further changes and comments link.

 	Javascript Design Pattern (Code Management):    ...//TODO: Cehck design pattern.

 	    Namespacing Patterns, Immediately-invoked Function Expressions (IIFE)s

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

	Creation Date: 2014.11.17 13:20 PM ( Tony ).

	Last Update: 2014.11.17 14:22 PM ( Tony ).    ...//TODO: Update the 'Last Update'.

 	Music ( Custom ): Countdown (feat. Makj).mp3    ...//TODO: If you are listenning some music, just write the name of songs.

 	License: ...//TODO: Give a license.

 	Copyright: ...//TODO: Give a copyright.
 ###

define (require) ->

	SJ             = require 'jquery'

	modernizr      = require 'modernizr'

	scroller       = require 'component/srl'

	_fns = ($) ->

		fnObj =

			config: {}

			init: (settings) ->

				console.log 'Hi!' # Hi! WORLD! Hi! IRON MAN!

				@mixture()

				return

			helpers:

				pdControl: (e) ->

					e.stopPropagation()

					e.preventDefault()

					return

				clickOrTouch: ->

					if modernizr.touch

						evtName = 'touchstart'

					else

						evtName = 'click'

					return evtName

			mixture: ->

				helpers = @helpers

				$('a[href=#]').on helpers.clickOrTouch(), (e) ->

					helpers.pdControl e

					return

				# HTML Scroll
				scroller.excute $ ':root'

				console.log '沈维忠 ( Shen Weizhong / Tony Stark )'

				return

		fnObj.init()

		return

	SJ _fns

	return