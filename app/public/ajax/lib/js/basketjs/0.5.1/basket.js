!function(e,t){"use strict";var n=t.head||t.getElementsByTagName("head")[0],r="basket-",a=5e3,u=function(e,t){try{return localStorage.setItem(r+e,JSON.stringify(t)),!0}catch(n){if(n.name.toUpperCase().indexOf("QUOTA")>=0){var a,i=[];for(a in localStorage)0===a.indexOf(r)&&i.push(JSON.parse(localStorage[a]));return i.length?(i.sort(function(e,t){return e.stamp-t.stamp}),basket.remove(i[0].key),u(e,t)):void 0}return}},i=function(e){var t=new RSVP.Promise(function(t,n){var r=new XMLHttpRequest;r.open("GET",e),r.onreadystatechange=function(){4===r.readyState&&(200===r.status?t({content:r.responseText,type:r.getResponseHeader("content-type")}):n(new Error(r.statusText)))},setTimeout(function(){r.readyState<4&&r.abort()},basket.timeout),r.send()});return t},o=function(e){return i(e.url).then(function(t){var n=s(e,t);return e.skipCache||u(e.key,n),n})},s=function(e,t){var n=+new Date;return e.data=t.content,e.originalType=t.type,e.type=e.type||t.type,e.skipCache=e.skipCache||!1,e.stamp=n,e.expire=n+60*(e.expire||a)*60*1e3,e},c=function(e,t){return!e||e.expire-+new Date<0||t.unique!==e.unique||basket.isValidItem&&!basket.isValidItem(e,t)},l=function(e){var t,n,r;if(e.url)return e.key=e.key||e.url,t=basket.get(e.key),e.execute=e.execute!==!1,r=c(t,e),e.live||r?(e.unique&&(e.url+=(e.url.indexOf("?")>0?"&":"?")+"basket-unique="+e.unique),n=o(e),e.live&&!r&&(n=n.then(function(e){return e},function(){return t}))):(t.type=e.type||t.originalType,n=new RSVP.Promise(function(e){e(t)})),n},f=function(e){var r=t.createElement("script");r.defer=!0,r.text=e.data,n.appendChild(r)},p={"default":f},d=function(e){return e.type&&p[e.type]?p[e.type](e):p["default"](e)},m=function(e){e.map(function(e){return e.execute&&d(e),e})},y=function(){var e,t,n=[];for(e=0,t=arguments.length;t>e;e++)n.push(l(arguments[e]));return RSVP.all(n)},h=function(){var e=y.apply(null,arguments),t=this.then(function(){return e}).then(m);return t.thenRequire=h,t};e.basket={require:function(){var e=y.apply(null,arguments).then(m);return e.thenRequire=h,e},remove:function(e){return localStorage.removeItem(r+e),this},get:function(e){var t=localStorage.getItem(r+e);try{return JSON.parse(t||"false")}catch(n){return!1}},clear:function(e){var t,n,a=+new Date;for(t in localStorage)n=t.split(r)[1],n&&(!e||this.get(n).expire<=a)&&this.remove(n);return this},isValidItem:null,timeout:5e3,addHandler:function(e,t){Array.isArray(e)||(e=[e]),e.forEach(function(e){p[e]=t})},removeHandler:function(e){basket.addHandler(e,void 0)}},basket.clear(!0)}(this,document);