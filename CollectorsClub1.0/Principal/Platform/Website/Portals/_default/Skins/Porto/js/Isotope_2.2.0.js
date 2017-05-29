/*!
 * Isotope PACKAGED v2.2.0
 *
 * Licensed GPLv3 for open source use
 * or Isotope Commercial License for commercial use
 *
 * http://isotope.metafizzy.co
 * Copyright 2015 Metafizzy
 */

(function (t) {
	function e() { }
	function i(t) {
		function i(e) {
			e.prototype.option || (e.prototype.option = function (e) {
				t.isPlainObject(e) && (this.options = t.extend(!0, this.options, e))
			}
			)
		}
		function n(e, i) {
			t.fn[e] = function (n) {
				if ("string" == typeof n) {
					for (var s = o.call(arguments, 1), a = 0, u = this.length; u > a; a++) {
						var p = this[a]
							, h = t.data(p, e);
						if (h)
							if (t.isFunction(h[n]) && "_" !== n.charAt(0)) {
								var f = h[n].apply(h, s);
								if (void 0 !== f)
									return f
							} else
								r("no such method '" + n + "' for " + e + " instance");
						else
							r("cannot call methods on " + e + " prior to initialization; " + "attempted to call '" + n + "'")
					}
					return this
				}
				return this.each(function () {
					var o = t.data(this, e);
					o ? (o.option(n),
						o._init()) : (o = new i(this, n),
							t.data(this, e, o))
				})
			}
		}
		if (t) {
			var r = "undefined" == typeof console ? e : function (t) {
				console.error(t)
			}
				;
			return t.bridget = function (t, e) {
				i(e),
					n(t, e)
			}
				,
				t.bridget
		}
	}
	var o = Array.prototype.slice;
	"function" == typeof define && define.amd ? define("jquery-bridget/jquery.bridget", ["jquery"], i) : "object" == typeof exports ? i(require("jquery")) : i(t.jQuery)
})(window),
	function (t) {
		function e(e) {
			var i = t.event;
			return i.target = i.target || i.srcElement || e,
				i
		}
		var i = document.documentElement
			, o = function () { };
		i.addEventListener ? o = function (t, e, i) {
			t.addEventListener(e, i, !1)
		}
			: i.attachEvent && (o = function (t, i, o) {
				t[i + o] = o.handleEvent ? function () {
					var i = e(t);
					o.handleEvent.call(o, i)
				}
					: function () {
						var i = e(t);
						o.call(t, i)
					}
					,
					t.attachEvent("on" + i, t[i + o])
			}
			);
		var n = function () { };
		i.removeEventListener ? n = function (t, e, i) {
			t.removeEventListener(e, i, !1)
		}
			: i.detachEvent && (n = function (t, e, i) {
				t.detachEvent("on" + e, t[e + i]);
				try {
					delete t[e + i]
				} catch (o) {
					t[e + i] = void 0
				}
			}
			);
		var r = {
			bind: o,
			unbind: n
		};
		"function" == typeof define && define.amd ? define("eventie/eventie", r) : "object" == typeof exports ? module.exports = r : t.eventie = r
	}(window),
	function () {
		function t() { }
		function e(t, e) {
			for (var i = t.length; i--;)
				if (t[i].listener === e)
					return i;
			return -1
		}
		function i(t) {
			return function () {
				return this[t].apply(this, arguments)
			}
		}
		var o = t.prototype
			, n = this
			, r = n.EventEmitter;
		o.getListeners = function (t) {
			var e, i, o = this._getEvents();
			if (t instanceof RegExp) {
				e = {};
				for (i in o)
					o.hasOwnProperty(i) && t.test(i) && (e[i] = o[i])
			} else
				e = o[t] || (o[t] = []);
			return e
		}
			,
			o.flattenListeners = function (t) {
				var e, i = [];
				for (e = 0; t.length > e; e += 1)
					i.push(t[e].listener);
				return i
			}
			,
			o.getListenersAsObject = function (t) {
				var e, i = this.getListeners(t);
				return i instanceof Array && (e = {},
					e[t] = i),
					e || i
			}
			,
			o.addListener = function (t, i) {
				var o, n = this.getListenersAsObject(t), r = "object" == typeof i;
				for (o in n)
					n.hasOwnProperty(o) && -1 === e(n[o], i) && n[o].push(r ? i : {
						listener: i,
						once: !1
					});
				return this
			}
			,
			o.on = i("addListener"),
			o.addOnceListener = function (t, e) {
				return this.addListener(t, {
					listener: e,
					once: !0
				})
			}
			,
			o.once = i("addOnceListener"),
			o.defineEvent = function (t) {
				return this.getListeners(t),
					this
			}
			,
			o.defineEvents = function (t) {
				for (var e = 0; t.length > e; e += 1)
					this.defineEvent(t[e]);
				return this
			}
			,
			o.removeListener = function (t, i) {
				var o, n, r = this.getListenersAsObject(t);
				for (n in r)
					r.hasOwnProperty(n) && (o = e(r[n], i),
						-1 !== o && r[n].splice(o, 1));
				return this
			}
			,
			o.off = i("removeListener"),
			o.addListeners = function (t, e) {
				return this.manipulateListeners(!1, t, e)
			}
			,
			o.removeListeners = function (t, e) {
				return this.manipulateListeners(!0, t, e)
			}
			,
			o.manipulateListeners = function (t, e, i) {
				var o, n, r = t ? this.removeListener : this.addListener, s = t ? this.removeListeners : this.addListeners;
				if ("object" != typeof e || e instanceof RegExp)
					for (o = i.length; o--;)
						r.call(this, e, i[o]);
				else
					for (o in e)
						e.hasOwnProperty(o) && (n = e[o]) && ("function" == typeof n ? r.call(this, o, n) : s.call(this, o, n));
				return this
			}
			,
			o.removeEvent = function (t) {
				var e, i = typeof t, o = this._getEvents();
				if ("string" === i)
					delete o[t];
				else if (t instanceof RegExp)
					for (e in o)
						o.hasOwnProperty(e) && t.test(e) && delete o[e];
				else
					delete this._events;
				return this
			}
			,
			o.removeAllListeners = i("removeEvent"),
			o.emitEvent = function (t, e) {
				var i, o, n, r, s = this.getListenersAsObject(t);
				for (n in s)
					if (s.hasOwnProperty(n))
						for (o = s[n].length; o--;)
							i = s[n][o],
								i.once === !0 && this.removeListener(t, i.listener),
								r = i.listener.apply(this, e || []),
								r === this._getOnceReturnValue() && this.removeListener(t, i.listener);
				return this
			}
			,
			o.trigger = i("emitEvent"),
			o.emit = function (t) {
				var e = Array.prototype.slice.call(arguments, 1);
				return this.emitEvent(t, e)
			}
			,
			o.setOnceReturnValue = function (t) {
				return this._onceReturnValue = t,
					this
			}
			,
			o._getOnceReturnValue = function () {
				return this.hasOwnProperty("_onceReturnValue") ? this._onceReturnValue : !0
			}
			,
			o._getEvents = function () {
				return this._events || (this._events = {})
			}
			,
			t.noConflict = function () {
				return n.EventEmitter = r,
					t
			}
			,
			"function" == typeof define && define.amd ? define("eventEmitter/EventEmitter", [], function () {
				return t
			}) : "object" == typeof module && module.exports ? module.exports = t : n.EventEmitter = t
	}
		.call(this),
	function (t) {
		function e(t) {
			if (t) {
				if ("string" == typeof o[t])
					return t;
				t = t.charAt(0).toUpperCase() + t.slice(1);
				for (var e, n = 0, r = i.length; r > n; n++)
					if (e = i[n] + t,
						"string" == typeof o[e])
						return e
			}
		}
		var i = "Webkit Moz ms Ms O".split(" ")
			, o = document.documentElement.style;
		"function" == typeof define && define.amd ? define("get-style-property/get-style-property", [], function () {
			return e
		}) : "object" == typeof exports ? module.exports = e : t.getStyleProperty = e
	}(window),
	function (t) {
		function e(t) {
			var e = parseFloat(t)
				, i = -1 === t.indexOf("%") && !isNaN(e);
			return i && e
		}
		function i() { }
		function o() {
			for (var t = {
				width: 0,
				height: 0,
				innerWidth: 0,
				innerHeight: 0,
				outerWidth: 0,
				outerHeight: 0
			}, e = 0, i = s.length; i > e; e++) {
				var o = s[e];
				t[o] = 0
			}
			return t
		}
		function n(i) {
			function n() {
				if (!d) {
					d = !0;
					var o = t.getComputedStyle;
					if (p = function () {
						var t = o ? function (t) {
							return o(t, null)
						}
							: function (t) {
								return t.currentStyle
							}
							;
						return function (e) {
							var i = t(e);
							return i || r("Style returned " + i + ". Are you running this code in a hidden iframe on Firefox? " + "See http://bit.ly/getsizebug1"),
								i
						}
					}(),
						h = i("boxSizing")) {
						var n = document.createElement("div");
						n.style.width = "200px",
							n.style.padding = "1px 2px 3px 4px",
							n.style.borderStyle = "solid",
							n.style.borderWidth = "1px 2px 3px 4px",
							n.style[h] = "border-box";
						var s = document.body || document.documentElement;
						s.appendChild(n);
						var a = p(n);
						f = 200 === e(a.width),
							s.removeChild(n)
					}
				}
			}
			function a(t) {
				if (n(),
					"string" == typeof t && (t = document.querySelector(t)),
					t && "object" == typeof t && t.nodeType) {
					var i = p(t);
					if ("none" === i.display)
						return o();
					var r = {};
					r.width = t.offsetWidth,
						r.height = t.offsetHeight;
					for (var a = r.isBorderBox = !(!h || !i[h] || "border-box" !== i[h]), d = 0, l = s.length; l > d; d++) {
						var c = s[d]
							, m = i[c];
						m = u(t, m);
						var y = parseFloat(m);
						r[c] = isNaN(y) ? 0 : y
					}
					var g = r.paddingLeft + r.paddingRight
						, v = r.paddingTop + r.paddingBottom
						, _ = r.marginLeft + r.marginRight
						, I = r.marginTop + r.marginBottom
						, z = r.borderLeftWidth + r.borderRightWidth
						, L = r.borderTopWidth + r.borderBottomWidth
						, x = a && f
						, E = e(i.width);
					E !== !1 && (r.width = E + (x ? 0 : g + z));
					var b = e(i.height);
					return b !== !1 && (r.height = b + (x ? 0 : v + L)),
						r.innerWidth = r.width - (g + z),
						r.innerHeight = r.height - (v + L),
						r.outerWidth = r.width + _,
						r.outerHeight = r.height + I,
						r
				}
			}
			function u(e, i) {
				if (t.getComputedStyle || -1 === i.indexOf("%"))
					return i;
				var o = e.style
					, n = o.left
					, r = e.runtimeStyle
					, s = r && r.left;
				return s && (r.left = e.currentStyle.left),
					o.left = i,
					i = o.pixelLeft,
					o.left = n,
					s && (r.left = s),
					i
			}
			var p, h, f, d = !1;
			return a
		}
		var r = "undefined" == typeof console ? i : function (t) {
			console.error(t)
		}
			, s = ["paddingLeft", "paddingRight", "paddingTop", "paddingBottom", "marginLeft", "marginRight", "marginTop", "marginBottom", "borderLeftWidth", "borderRightWidth", "borderTopWidth", "borderBottomWidth"];
		"function" == typeof define && define.amd ? define("get-size/get-size", ["get-style-property/get-style-property"], n) : "object" == typeof exports ? module.exports = n(require("desandro-get-style-property")) : t.getSize = n(t.getStyleProperty)
	}(window),
	function (t) {
		function e(t) {
			"function" == typeof t && (e.isReady ? t() : s.push(t))
		}
		function i(t) {
			var i = "readystatechange" === t.type && "complete" !== r.readyState;
			e.isReady || i || o()
		}
		function o() {
			e.isReady = !0;
			for (var t = 0, i = s.length; i > t; t++) {
				var o = s[t];
				o()
			}
		}
		function n(n) {
			return "complete" === r.readyState ? o() : (n.bind(r, "DOMContentLoaded", i),
				n.bind(r, "readystatechange", i),
				n.bind(t, "load", i)),
				e
		}
		var r = t.document
			, s = [];
		e.isReady = !1,
			"function" == typeof define && define.amd ? define("doc-ready/doc-ready", ["eventie/eventie"], n) : "object" == typeof exports ? module.exports = n(require("eventie")) : t.docReady = n(t.eventie)
	}(window),
	function (t) {
		function e(t, e) {
			return t[s](e)
		}
		function i(t) {
			if (!t.parentNode) {
				var e = document.createDocumentFragment();
				e.appendChild(t)
			}
		}
		function o(t, e) {
			i(t);
			for (var o = t.parentNode.querySelectorAll(e), n = 0, r = o.length; r > n; n++)
				if (o[n] === t)
					return !0;
			return !1
		}
		function n(t, o) {
			return i(t),
				e(t, o)
		}
		var r, s = function () {
			if (t.matches)
				return "matches";
			if (t.matchesSelector)
				return "matchesSelector";
			for (var e = ["webkit", "moz", "ms", "o"], i = 0, o = e.length; o > i; i++) {
				var n = e[i]
					, r = n + "MatchesSelector";
				if (t[r])
					return r
			}
		}();
		if (s) {
			var a = document.createElement("div")
				, u = e(a, "div");
			r = u ? e : n
		} else
			r = o;
		"function" == typeof define && define.amd ? define("matches-selector/matches-selector", [], function () {
			return r
		}) : "object" == typeof exports ? module.exports = r : window.matchesSelector = r
	}(Element.prototype),
	function (t, e) {
		"function" == typeof define && define.amd ? define("fizzy-ui-utils/utils", ["doc-ready/doc-ready", "matches-selector/matches-selector"], function (i, o) {
			return e(t, i, o)
		}) : "object" == typeof exports ? module.exports = e(t, require("doc-ready"), require("desandro-matches-selector")) : t.fizzyUIUtils = e(t, t.docReady, t.matchesSelector)
	}(window, function (t, e, i) {
		var o = {};
		o.extend = function (t, e) {
			for (var i in e)
				t[i] = e[i];
			return t
		}
			,
			o.modulo = function (t, e) {
				return (t % e + e) % e
			}
			;
		var n = Object.prototype.toString;
		o.isArray = function (t) {
			return "[object Array]" == n.call(t)
		}
			,
			o.makeArray = function (t) {
				var e = [];
				if (o.isArray(t))
					e = t;
				else if (t && "number" == typeof t.length)
					for (var i = 0, n = t.length; n > i; i++)
						e.push(t[i]);
				else
					e.push(t);
				return e
			}
			,
			o.indexOf = Array.prototype.indexOf ? function (t, e) {
				return t.indexOf(e)
			}
				: function (t, e) {
					for (var i = 0, o = t.length; o > i; i++)
						if (t[i] === e)
							return i;
					return -1
				}
			,
			o.removeFrom = function (t, e) {
				var i = o.indexOf(t, e);
				-1 != i && t.splice(i, 1)
			}
			,
			o.isElement = "function" == typeof HTMLElement || "object" == typeof HTMLElement ? function (t) {
				return t instanceof HTMLElement
			}
				: function (t) {
					return t && "object" == typeof t && 1 == t.nodeType && "string" == typeof t.nodeName
				}
			,
			o.setText = function () {
				function t(t, i) {
					e = e || (void 0 !== document.documentElement.textContent ? "textContent" : "innerText"),
						t[e] = i
				}
				var e;
				return t
			}(),
			o.getParent = function (t, e) {
				for (; t != document.body;)
					if (t = t.parentNode,
						i(t, e))
						return t
			}
			,
			o.getQueryElement = function (t) {
				return "string" == typeof t ? document.querySelector(t) : t
			}
			,
			o.handleEvent = function (t) {
				var e = "on" + t.type;
				this[e] && this[e](t)
			}
			,
			o.filterFindElements = function (t, e) {
				t = o.makeArray(t);
				for (var n = [], r = 0, s = t.length; s > r; r++) {
					var a = t[r];
					if (o.isElement(a))
						if (e) {
							i(a, e) && n.push(a);
							for (var u = a.querySelectorAll(e), p = 0, h = u.length; h > p; p++)
								n.push(u[p])
						} else
							n.push(a)
				}
				return n
			}
			,
			o.debounceMethod = function (t, e, i) {
				var o = t.prototype[e]
					, n = e + "Timeout";
				t.prototype[e] = function () {
					var t = this[n];
					t && clearTimeout(t);
					var e = arguments
						, r = this;
					this[n] = setTimeout(function () {
						o.apply(r, e),
							delete r[n]
					}, i || 100)
				}
			}
			,
			o.toDashed = function (t) {
				return t.replace(/(.)([A-Z])/g, function (t, e, i) {
					return e + "-" + i
				}).toLowerCase()
			}
			;
		var r = t.console;
		return o.htmlInit = function (i, n) {
			e(function () {
				for (var e = o.toDashed(n), s = document.querySelectorAll(".js-" + e), a = "data-" + e + "-options", u = 0, p = s.length; p > u; u++) {
					var h, f = s[u], d = f.getAttribute(a);
					try {
						h = d && JSON.parse(d)
					} catch (l) {
						r && r.error("Error parsing " + a + " on " + f.nodeName.toLowerCase() + (f.id ? "#" + f.id : "") + ": " + l);
						continue
					}
					var c = new i(f, h)
						, m = t.jQuery;
					m && m.data(f, n, c)
				}
			})
		}
			,
			o
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("outlayer/item", ["eventEmitter/EventEmitter", "get-size/get-size", "get-style-property/get-style-property", "fizzy-ui-utils/utils"], function (i, o, n, r) {
			return e(t, i, o, n, r)
		}) : "object" == typeof exports ? module.exports = e(t, require("wolfy87-eventemitter"), require("get-size"), require("desandro-get-style-property"), require("fizzy-ui-utils")) : (t.Outlayer = {},
			t.Outlayer.Item = e(t, t.EventEmitter, t.getSize, t.getStyleProperty, t.fizzyUIUtils))
	}(window, function (t, e, i, o, n) {
		function r(t) {
			for (var e in t)
				return !1;
			return e = null,
				!0
		}
		function s(t, e) {
			t && (this.element = t,
				this.layout = e,
				this.position = {
					x: 0,
					y: 0
				},
				this._create())
		}
		var a = t.getComputedStyle
			, u = a ? function (t) {
				return a(t, null)
			}
				: function (t) {
					return t.currentStyle
				}
			, p = o("transition")
			, h = o("transform")
			, f = p && h
			, d = !!o("perspective")
			, l = {
				WebkitTransition: "webkitTransitionEnd",
				MozTransition: "transitionend",
				OTransition: "otransitionend",
				transition: "transitionend"
			}[p]
			, c = ["transform", "transition", "transitionDuration", "transitionProperty"]
			, m = function () {
				for (var t = {}, e = 0, i = c.length; i > e; e++) {
					var n = c[e]
						, r = o(n);
					r && r !== n && (t[n] = r)
				}
				return t
			}();
		n.extend(s.prototype, e.prototype),
			s.prototype._create = function () {
				this._transn = {
					ingProperties: {},
					clean: {},
					onEnd: {}
				},
					this.css({
						position: "absolute"
					})
			}
			,
			s.prototype.handleEvent = function (t) {
				var e = "on" + t.type;
				this[e] && this[e](t)
			}
			,
			s.prototype.getSize = function () {
				this.size = i(this.element)
			}
			,
			s.prototype.css = function (t) {
				var e = this.element.style;
				for (var i in t) {
					var o = m[i] || i;
					e[o] = t[i]
				}
			}
			,
			s.prototype.getPosition = function () {
				var t = u(this.element)
					, e = this.layout.options
					, i = e.isOriginLeft
					, o = e.isOriginTop
					, n = parseInt(t[i ? "left" : "right"], 10)
					, r = parseInt(t[o ? "top" : "bottom"], 10);
				n = isNaN(n) ? 0 : n,
					r = isNaN(r) ? 0 : r;
				var s = this.layout.size;
				n -= i ? s.paddingLeft : s.paddingRight,
					r -= o ? s.paddingTop : s.paddingBottom,
					this.position.x = n,
					this.position.y = r
			}
			,
			s.prototype.layoutPosition = function () {
				var t = this.layout.size
					, e = this.layout.options
					, i = {}
					, o = e.isOriginLeft ? "paddingLeft" : "paddingRight"
					, n = e.isOriginLeft ? "left" : "right"
					, r = e.isOriginLeft ? "right" : "left"
					, s = this.position.x + t[o];
				s = e.percentPosition && !e.isHorizontal ? 100 * (s / t.width) + "%" : s + "px",
					i[n] = s,
					i[r] = "";
				var a = e.isOriginTop ? "paddingTop" : "paddingBottom"
					, u = e.isOriginTop ? "top" : "bottom"
					, p = e.isOriginTop ? "bottom" : "top"
					, h = this.position.y + t[a];
				h = e.percentPosition && e.isHorizontal ? 100 * (h / t.height) + "%" : h + "px",
					i[u] = h,
					i[p] = "",
					this.css(i),
					this.emitEvent("layout", [this])
			}
			;
		var y = d ? function (t, e) {
			return "translate3d(" + t + "px, " + e + "px, 0)"
		}
			: function (t, e) {
				return "translate(" + t + "px, " + e + "px)"
			}
			;
		s.prototype._transitionTo = function (t, e) {
			this.getPosition();
			var i = this.position.x
				, o = this.position.y
				, n = parseInt(t, 10)
				, r = parseInt(e, 10)
				, s = n === this.position.x && r === this.position.y;
			if (this.setPosition(t, e),
				s && !this.isTransitioning)
				return this.layoutPosition(),
					void 0;
			var a = t - i
				, u = e - o
				, p = {}
				, h = this.layout.options;
			a = h.isOriginLeft ? a : -a,
				u = h.isOriginTop ? u : -u,
				p.transform = y(a, u),
				this.transition({
					to: p,
					onTransitionEnd: {
						transform: this.layoutPosition
					},
					isCleaning: !0
				})
		}
			,
			s.prototype.goTo = function (t, e) {
				this.setPosition(t, e),
					this.layoutPosition()
			}
			,
			s.prototype.moveTo = f ? s.prototype._transitionTo : s.prototype.goTo,
			s.prototype.setPosition = function (t, e) {
				this.position.x = parseInt(t, 10),
					this.position.y = parseInt(e, 10)
			}
			,
			s.prototype._nonTransition = function (t) {
				this.css(t.to),
					t.isCleaning && this._removeStyles(t.to);
				for (var e in t.onTransitionEnd)
					t.onTransitionEnd[e].call(this)
			}
			,
			s.prototype._transition = function (t) {
				if (!parseFloat(this.layout.options.transitionDuration))
					return this._nonTransition(t),
						void 0;
				var e = this._transn;
				for (var i in t.onTransitionEnd)
					e.onEnd[i] = t.onTransitionEnd[i];
				for (i in t.to)
					e.ingProperties[i] = !0,
						t.isCleaning && (e.clean[i] = !0);
				if (t.from) {
					this.css(t.from);
					var o = this.element.offsetHeight;
					o = null
				}
				this.enableTransition(t.to),
					this.css(t.to),
					this.isTransitioning = !0
			}
			;
		var g = h && n.toDashed(h) + ",opacity";
		s.prototype.enableTransition = function () {
			this.isTransitioning || (this.css({
				transitionProperty: g,
				transitionDuration: this.layout.options.transitionDuration
			}),
				this.element.addEventListener(l, this, !1))
		}
			,
			s.prototype.transition = s.prototype[p ? "_transition" : "_nonTransition"],
			s.prototype.onwebkitTransitionEnd = function (t) {
				this.ontransitionend(t)
			}
			,
			s.prototype.onotransitionend = function (t) {
				this.ontransitionend(t)
			}
			;
		var v = {
			"-webkit-transform": "transform",
			"-moz-transform": "transform",
			"-o-transform": "transform"
		};
		s.prototype.ontransitionend = function (t) {
			if (t.target === this.element) {
				var e = this._transn
					, i = v[t.propertyName] || t.propertyName;
				if (delete e.ingProperties[i],
					r(e.ingProperties) && this.disableTransition(),
					i in e.clean && (this.element.style[t.propertyName] = "",
						delete e.clean[i]),
					i in e.onEnd) {
					var o = e.onEnd[i];
					o.call(this),
						delete e.onEnd[i]
				}
				this.emitEvent("transitionEnd", [this])
			}
		}
			,
			s.prototype.disableTransition = function () {
				this.removeTransitionStyles(),
					this.element.removeEventListener(l, this, !1),
					this.isTransitioning = !1
			}
			,
			s.prototype._removeStyles = function (t) {
				var e = {};
				for (var i in t)
					e[i] = "";
				this.css(e)
			}
			;
		var _ = {
			transitionProperty: "",
			transitionDuration: ""
		};
		return s.prototype.removeTransitionStyles = function () {
			this.css(_)
		}
			,
			s.prototype.removeElem = function () {
				this.element.parentNode.removeChild(this.element),
					this.css({
						display: ""
					}),
					this.emitEvent("remove", [this])
			}
			,
			s.prototype.remove = function () {
				if (!p || !parseFloat(this.layout.options.transitionDuration))
					return this.removeElem(),
						void 0;
				var t = this;
				this.once("transitionEnd", function () {
					t.removeElem()
				}),
					this.hide()
			}
			,
			s.prototype.reveal = function () {
				delete this.isHidden,
					this.css({
						display: ""
					});
				var t = this.layout.options
					, e = {}
					, i = this.getHideRevealTransitionEndProperty("visibleStyle");
				e[i] = this.onRevealTransitionEnd,
					this.transition({
						from: t.hiddenStyle,
						to: t.visibleStyle,
						isCleaning: !0,
						onTransitionEnd: e
					})
			}
			,
			s.prototype.onRevealTransitionEnd = function () {
				this.isHidden || this.emitEvent("reveal")
			}
			,
			s.prototype.getHideRevealTransitionEndProperty = function (t) {
				var e = this.layout.options[t];
				if (e.opacity)
					return "opacity";
				for (var i in e)
					return i
			}
			,
			s.prototype.hide = function () {
				this.isHidden = !0,
					this.css({
						display: ""
					});
				var t = this.layout.options
					, e = {}
					, i = this.getHideRevealTransitionEndProperty("hiddenStyle");
				e[i] = this.onHideTransitionEnd,
					this.transition({
						from: t.visibleStyle,
						to: t.hiddenStyle,
						isCleaning: !0,
						onTransitionEnd: e
					})
			}
			,
			s.prototype.onHideTransitionEnd = function () {
				this.isHidden && (this.css({
					display: "none"
				}),
					this.emitEvent("hide"))
			}
			,
			s.prototype.destroy = function () {
				this.css({
					position: "",
					left: "",
					right: "",
					top: "",
					bottom: "",
					transition: "",
					transform: ""
				})
			}
			,
			s
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("outlayer/outlayer", ["eventie/eventie", "eventEmitter/EventEmitter", "get-size/get-size", "fizzy-ui-utils/utils", "./item"], function (i, o, n, r, s) {
			return e(t, i, o, n, r, s)
		}) : "object" == typeof exports ? module.exports = e(t, require("eventie"), require("wolfy87-eventemitter"), require("get-size"), require("fizzy-ui-utils"), require("./item")) : t.Outlayer = e(t, t.eventie, t.EventEmitter, t.getSize, t.fizzyUIUtils, t.Outlayer.Item)
	}(window, function (t, e, i, o, n, r) {
		function s(t, e) {
			var i = n.getQueryElement(t);
			if (!i)
				return a && a.error("Bad element for " + this.constructor.namespace + ": " + (i || t)),
					void 0;
			this.element = i,
				u && (this.$element = u(this.element)),
				this.options = n.extend({}, this.constructor.defaults),
				this.option(e);
			var o = ++h;
			this.element.outlayerGUID = o,
				f[o] = this,
				this._create(),
				this.options.isInitLayout && this.layout()
		}
		var a = t.console
			, u = t.jQuery
			, p = function () { }
			, h = 0
			, f = {};
		return s.namespace = "outlayer",
			s.Item = r,
			s.defaults = {
				containerStyle: {
					position: "relative"
				},
				isInitLayout: !0,
				isOriginLeft: !0,
				isOriginTop: !0,
				isResizeBound: !0,
				isResizingContainer: !0,
				transitionDuration: "0.4s",
				hiddenStyle: {
					opacity: 0,
					transform: "scale(0.001)"
				},
				visibleStyle: {
					opacity: 1,
					transform: "scale(1)"
				}
			},
			n.extend(s.prototype, i.prototype),
			s.prototype.option = function (t) {
				n.extend(this.options, t)
			}
			,
			s.prototype._create = function () {
				this.reloadItems(),
					this.stamps = [],
					this.stamp(this.options.stamp),
					n.extend(this.element.style, this.options.containerStyle),
					this.options.isResizeBound && this.bindResize()
			}
			,
			s.prototype.reloadItems = function () {
				this.items = this._itemize(this.element.children)
			}
			,
			s.prototype._itemize = function (t) {
				for (var e = this._filterFindItemElements(t), i = this.constructor.Item, o = [], n = 0, r = e.length; r > n; n++) {
					var s = e[n]
						, a = new i(s, this);
					o.push(a)
				}
				return o
			}
			,
			s.prototype._filterFindItemElements = function (t) {
				return n.filterFindElements(t, this.options.itemSelector)
			}
			,
			s.prototype.getItemElements = function () {
				for (var t = [], e = 0, i = this.items.length; i > e; e++)
					t.push(this.items[e].element);
				return t
			}
			,
			s.prototype.layout = function () {
				this._resetLayout(),
					this._manageStamps();
				var t = void 0 !== this.options.isLayoutInstant ? this.options.isLayoutInstant : !this._isLayoutInited;
				this.layoutItems(this.items, t),
					this._isLayoutInited = !0
			}
			,
			s.prototype._init = s.prototype.layout,
			s.prototype._resetLayout = function () {
				this.getSize()
			}
			,
			s.prototype.getSize = function () {
				this.size = o(this.element)
			}
			,
			s.prototype._getMeasurement = function (t, e) {
				var i, r = this.options[t];
				r ? ("string" == typeof r ? i = this.element.querySelector(r) : n.isElement(r) && (i = r),
					this[t] = i ? o(i)[e] : r) : this[t] = 0
			}
			,
			s.prototype.layoutItems = function (t, e) {
				t = this._getItemsForLayout(t),
					this._layoutItems(t, e),
					this._postLayout()
			}
			,
			s.prototype._getItemsForLayout = function (t) {
				for (var e = [], i = 0, o = t.length; o > i; i++) {
					var n = t[i];
					n.isIgnored || e.push(n)
				}
				return e
			}
			,
			s.prototype._layoutItems = function (t, e) {
				if (this._emitCompleteOnItems("layout", t),
					t && t.length) {
					for (var i = [], o = 0, n = t.length; n > o; o++) {
						var r = t[o]
							, s = this._getItemLayoutPosition(r);
						s.item = r,
							s.isInstant = e || r.isLayoutInstant,
							i.push(s)
					}
					this._processLayoutQueue(i)
				}
			}
			,
			s.prototype._getItemLayoutPosition = function () {
				return {
					x: 0,
					y: 0
				}
			}
			,
			s.prototype._processLayoutQueue = function (t) {
				for (var e = 0, i = t.length; i > e; e++) {
					var o = t[e];
					this._positionItem(o.item, o.x, o.y, o.isInstant)
				}
			}
			,
			s.prototype._positionItem = function (t, e, i, o) {
				o ? t.goTo(e, i) : t.moveTo(e, i)
			}
			,
			s.prototype._postLayout = function () {
				this.resizeContainer()
			}
			,
			s.prototype.resizeContainer = function () {
				if (this.options.isResizingContainer) {
					var t = this._getContainerSize();
					t && (this._setContainerMeasure(t.width, !0),
						this._setContainerMeasure(t.height, !1))
				}
			}
			,
			s.prototype._getContainerSize = p,
			s.prototype._setContainerMeasure = function (t, e) {
				if (void 0 !== t) {
					var i = this.size;
					i.isBorderBox && (t += e ? i.paddingLeft + i.paddingRight + i.borderLeftWidth + i.borderRightWidth : i.paddingBottom + i.paddingTop + i.borderTopWidth + i.borderBottomWidth),
						t = Math.max(t, 0),
						this.element.style[e ? "width" : "height"] = t + "px"
				}
			}
			,
			s.prototype._emitCompleteOnItems = function (t, e) {
				function i() {
					n.emitEvent(t + "Complete", [e])
				}
				function o() {
					s++ ,
						s === r && i()
				}
				var n = this
					, r = e.length;
				if (!e || !r)
					return i(),
						void 0;
				for (var s = 0, a = 0, u = e.length; u > a; a++) {
					var p = e[a];
					p.once(t, o)
				}
			}
			,
			s.prototype.ignore = function (t) {
				var e = this.getItem(t);
				e && (e.isIgnored = !0)
			}
			,
			s.prototype.unignore = function (t) {
				var e = this.getItem(t);
				e && delete e.isIgnored
			}
			,
			s.prototype.stamp = function (t) {
				if (t = this._find(t)) {
					this.stamps = this.stamps.concat(t);
					for (var e = 0, i = t.length; i > e; e++) {
						var o = t[e];
						this.ignore(o)
					}
				}
			}
			,
			s.prototype.unstamp = function (t) {
				if (t = this._find(t))
					for (var e = 0, i = t.length; i > e; e++) {
						var o = t[e];
						n.removeFrom(this.stamps, o),
							this.unignore(o)
					}
			}
			,
			s.prototype._find = function (t) {
				return t ? ("string" == typeof t && (t = this.element.querySelectorAll(t)),
					t = n.makeArray(t)) : void 0
			}
			,
			s.prototype._manageStamps = function () {
				if (this.stamps && this.stamps.length) {
					this._getBoundingRect();
					for (var t = 0, e = this.stamps.length; e > t; t++) {
						var i = this.stamps[t];
						this._manageStamp(i)
					}
				}
			}
			,
			s.prototype._getBoundingRect = function () {
				var t = this.element.getBoundingClientRect()
					, e = this.size;
				this._boundingRect = {
					left: t.left + e.paddingLeft + e.borderLeftWidth,
					top: t.top + e.paddingTop + e.borderTopWidth,
					right: t.right - (e.paddingRight + e.borderRightWidth),
					bottom: t.bottom - (e.paddingBottom + e.borderBottomWidth)
				}
			}
			,
			s.prototype._manageStamp = p,
			s.prototype._getElementOffset = function (t) {
				var e = t.getBoundingClientRect()
					, i = this._boundingRect
					, n = o(t)
					, r = {
						left: e.left - i.left - n.marginLeft,
						top: e.top - i.top - n.marginTop,
						right: i.right - e.right - n.marginRight,
						bottom: i.bottom - e.bottom - n.marginBottom
					};
				return r
			}
			,
			s.prototype.handleEvent = function (t) {
				var e = "on" + t.type;
				this[e] && this[e](t)
			}
			,
			s.prototype.bindResize = function () {
				this.isResizeBound || (e.bind(t, "resize", this),
					this.isResizeBound = !0)
			}
			,
			s.prototype.unbindResize = function () {
				this.isResizeBound && e.unbind(t, "resize", this),
					this.isResizeBound = !1
			}
			,
			s.prototype.onresize = function () {
				function t() {
					e.resize(),
						delete e.resizeTimeout
				}
				this.resizeTimeout && clearTimeout(this.resizeTimeout);
				var e = this;
				this.resizeTimeout = setTimeout(t, 100)
			}
			,
			s.prototype.resize = function () {
				this.isResizeBound && this.needsResizeLayout() && this.layout()
			}
			,
			s.prototype.needsResizeLayout = function () {
				var t = o(this.element)
					, e = this.size && t;
				return e && t.innerWidth !== this.size.innerWidth
			}
			,
			s.prototype.addItems = function (t) {
				var e = this._itemize(t);
				return e.length && (this.items = this.items.concat(e)),
					e
			}
			,
			s.prototype.appended = function (t) {
				var e = this.addItems(t);
				e.length && (this.layoutItems(e, !0),
					this.reveal(e))
			}
			,
			s.prototype.prepended = function (t) {
				var e = this._itemize(t);
				if (e.length) {
					var i = this.items.slice(0);
					this.items = e.concat(i),
						this._resetLayout(),
						this._manageStamps(),
						this.layoutItems(e, !0),
						this.reveal(e),
						this.layoutItems(i)
				}
			}
			,
			s.prototype.reveal = function (t) {
				this._emitCompleteOnItems("reveal", t);
				for (var e = t && t.length, i = 0; e && e > i; i++) {
					var o = t[i];
					o.reveal()
				}
			}
			,
			s.prototype.hide = function (t) {
				this._emitCompleteOnItems("hide", t);
				for (var e = t && t.length, i = 0; e && e > i; i++) {
					var o = t[i];
					o.hide()
				}
			}
			,
			s.prototype.revealItemElements = function (t) {
				var e = this.getItems(t);
				this.reveal(e)
			}
			,
			s.prototype.hideItemElements = function (t) {
				var e = this.getItems(t);
				this.hide(e)
			}
			,
			s.prototype.getItem = function (t) {
				for (var e = 0, i = this.items.length; i > e; e++) {
					var o = this.items[e];
					if (o.element === t)
						return o
				}
			}
			,
			s.prototype.getItems = function (t) {
				t = n.makeArray(t);
				for (var e = [], i = 0, o = t.length; o > i; i++) {
					var r = t[i]
						, s = this.getItem(r);
					s && e.push(s)
				}
				return e
			}
			,
			s.prototype.remove = function (t) {
				var e = this.getItems(t);
				if (this._emitCompleteOnItems("remove", e),
					e && e.length)
					for (var i = 0, o = e.length; o > i; i++) {
						var r = e[i];
						r.remove(),
							n.removeFrom(this.items, r)
					}
			}
			,
			s.prototype.destroy = function () {
				var t = this.element.style;
				t.height = "",
					t.position = "",
					t.width = "";
				for (var e = 0, i = this.items.length; i > e; e++) {
					var o = this.items[e];
					o.destroy()
				}
				this.unbindResize();
				var n = this.element.outlayerGUID;
				delete f[n],
					delete this.element.outlayerGUID,
					u && u.removeData(this.element, this.constructor.namespace)
			}
			,
			s.data = function (t) {
				t = n.getQueryElement(t);
				var e = t && t.outlayerGUID;
				return e && f[e]
			}
			,
			s.create = function (t, e) {
				function i() {
					s.apply(this, arguments)
				}
				return Object.create ? i.prototype = Object.create(s.prototype) : n.extend(i.prototype, s.prototype),
					i.prototype.constructor = i,
					i.defaults = n.extend({}, s.defaults),
					n.extend(i.defaults, e),
					i.prototype.settings = {},
					i.namespace = t,
					i.data = s.data,
					i.Item = function () {
						r.apply(this, arguments)
					}
					,
					i.Item.prototype = new r,
					n.htmlInit(i, t),
					u && u.bridget && u.bridget(t, i),
					i
			}
			,
			s.Item = r,
			s
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("isotope/js/item", ["outlayer/outlayer"], e) : "object" == typeof exports ? module.exports = e(require("outlayer")) : (t.Isotope = t.Isotope || {},
			t.Isotope.Item = e(t.Outlayer))
	}(window, function (t) {
		function e() {
			t.Item.apply(this, arguments)
		}
		e.prototype = new t.Item,
			e.prototype._create = function () {
				this.id = this.layout.itemGUID++ ,
					t.Item.prototype._create.call(this),
					this.sortData = {}
			}
			,
			e.prototype.updateSortData = function () {
				if (!this.isIgnored) {
					this.sortData.id = this.id,
						this.sortData["original-order"] = this.id,
						this.sortData.random = Math.random();
					var t = this.layout.options.getSortData
						, e = this.layout._sorters;
					for (var i in t) {
						var o = e[i];
						this.sortData[i] = o(this.element, this)
					}
				}
			}
			;
		var i = e.prototype.destroy;
		return e.prototype.destroy = function () {
			i.apply(this, arguments),
				this.css({
					display: ""
				})
		}
			,
			e
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("isotope/js/layout-mode", ["get-size/get-size", "outlayer/outlayer"], e) : "object" == typeof exports ? module.exports = e(require("get-size"), require("outlayer")) : (t.Isotope = t.Isotope || {},
			t.Isotope.LayoutMode = e(t.getSize, t.Outlayer))
	}(window, function (t, e) {
		function i(t) {
			this.isotope = t,
				t && (this.options = t.options[this.namespace],
					this.element = t.element,
					this.items = t.filteredItems,
					this.size = t.size)
		}
		return function () {
			function t(t) {
				return function () {
					return e.prototype[t].apply(this.isotope, arguments)
				}
			}
			for (var o = ["_resetLayout", "_getItemLayoutPosition", "_manageStamp", "_getContainerSize", "_getElementOffset", "needsResizeLayout"], n = 0, r = o.length; r > n; n++) {
				var s = o[n];
				i.prototype[s] = t(s)
			}
		}(),
			i.prototype.needsVerticalResizeLayout = function () {
				var e = t(this.isotope.element)
					, i = this.isotope.size && e;
				return i && e.innerHeight != this.isotope.size.innerHeight
			}
			,
			i.prototype._getMeasurement = function () {
				this.isotope._getMeasurement.apply(this, arguments)
			}
			,
			i.prototype.getColumnWidth = function () {
				this.getSegmentSize("column", "Width")
			}
			,
			i.prototype.getRowHeight = function () {
				this.getSegmentSize("row", "Height")
			}
			,
			i.prototype.getSegmentSize = function (t, e) {
				var i = t + e
					, o = "outer" + e;
				if (this._getMeasurement(i, o),
					!this[i]) {
					var n = this.getFirstItemSize();
					this[i] = n && n[o] || this.isotope.size["inner" + e]
				}
			}
			,
			i.prototype.getFirstItemSize = function () {
				var e = this.isotope.filteredItems[0];
				return e && e.element && t(e.element)
			}
			,
			i.prototype.layout = function () {
				this.isotope.layout.apply(this.isotope, arguments)
			}
			,
			i.prototype.getSize = function () {
				this.isotope.getSize(),
					this.size = this.isotope.size
			}
			,
			i.modes = {},
			i.create = function (t, e) {
				function o() {
					i.apply(this, arguments)
				}
				return o.prototype = new i,
					e && (o.options = e),
					o.prototype.namespace = t,
					i.modes[t] = o,
					o
			}
			,
			i
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("masonry/masonry", ["outlayer/outlayer", "get-size/get-size", "fizzy-ui-utils/utils"], e) : "object" == typeof exports ? module.exports = e(require("outlayer"), require("get-size"), require("fizzy-ui-utils")) : t.Masonry = e(t.Outlayer, t.getSize, t.fizzyUIUtils)
	}(window, function (t, e, i) {
		var o = t.create("masonry");
		return o.prototype._resetLayout = function () {
			this.getSize(),
				this._getMeasurement("columnWidth", "outerWidth"),
				this._getMeasurement("gutter", "outerWidth"),
				this.measureColumns();
			var t = this.cols;
			for (this.colYs = []; t--;)
				this.colYs.push(0);
			this.maxY = 0
		}
			,
			o.prototype.measureColumns = function () {
				if (this.getContainerWidth(),
					!this.columnWidth) {
					var t = this.items[0]
						, i = t && t.element;
					this.columnWidth = i && e(i).outerWidth || this.containerWidth
				}
				var o = this.columnWidth += this.gutter
					, n = this.containerWidth + this.gutter
					, r = n / o
					, s = o - n % o
					, a = s && 1 > s ? "round" : "floor";
				r = Math[a](r),
					this.cols = Math.max(r, 1)
			}
			,
			o.prototype.getContainerWidth = function () {
				var t = this.options.isFitWidth ? this.element.parentNode : this.element
					, i = e(t);
				this.containerWidth = i && i.innerWidth
			}
			,
			o.prototype._getItemLayoutPosition = function (t) {
				t.getSize();
				var e = t.size.outerWidth % this.columnWidth
					, o = e && 1 > e ? "round" : "ceil"
					, n = Math[o](t.size.outerWidth / this.columnWidth);
				n = Math.min(n, this.cols);
				for (var r = this._getColGroup(n), s = Math.min.apply(Math, r), a = i.indexOf(r, s), u = {
					x: this.columnWidth * a,
					y: s
				}, p = s + t.size.outerHeight, h = this.cols + 1 - r.length, f = 0; h > f; f++)
					this.colYs[a + f] = p;
				return u
			}
			,
			o.prototype._getColGroup = function (t) {
				if (2 > t)
					return this.colYs;
				for (var e = [], i = this.cols + 1 - t, o = 0; i > o; o++) {
					var n = this.colYs.slice(o, o + t);
					e[o] = Math.max.apply(Math, n)
				}
				return e
			}
			,
			o.prototype._manageStamp = function (t) {
				var i = e(t)
					, o = this._getElementOffset(t)
					, n = this.options.isOriginLeft ? o.left : o.right
					, r = n + i.outerWidth
					, s = Math.floor(n / this.columnWidth);
				s = Math.max(0, s);
				var a = Math.floor(r / this.columnWidth);
				a -= r % this.columnWidth ? 0 : 1,
					a = Math.min(this.cols - 1, a);
				for (var u = (this.options.isOriginTop ? o.top : o.bottom) + i.outerHeight, p = s; a >= p; p++)
					this.colYs[p] = Math.max(u, this.colYs[p])
			}
			,
			o.prototype._getContainerSize = function () {
				this.maxY = Math.max.apply(Math, this.colYs);
				var t = {
					height: this.maxY
				};
				return this.options.isFitWidth && (t.width = this._getContainerFitWidth()),
					t
			}
			,
			o.prototype._getContainerFitWidth = function () {
				for (var t = 0, e = this.cols; --e && 0 === this.colYs[e];)
					t++;
				return (this.cols - t) * this.columnWidth - this.gutter
			}
			,
			o.prototype.needsResizeLayout = function () {
				var t = this.containerWidth;
				return this.getContainerWidth(),
					t !== this.containerWidth
			}
			,
			o
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("isotope/js/layout-modes/masonry", ["../layout-mode", "masonry/masonry"], e) : "object" == typeof exports ? module.exports = e(require("../layout-mode"), require("masonry-layout")) : e(t.Isotope.LayoutMode, t.Masonry)
	}(window, function (t, e) {
		function i(t, e) {
			for (var i in e)
				t[i] = e[i];
			return t
		}
		var o = t.create("masonry")
			, n = o.prototype._getElementOffset
			, r = o.prototype.layout
			, s = o.prototype._getMeasurement;
		i(o.prototype, e.prototype),
			o.prototype._getElementOffset = n,
			o.prototype.layout = r,
			o.prototype._getMeasurement = s;
		var a = o.prototype.measureColumns;
		o.prototype.measureColumns = function () {
			this.items = this.isotope.filteredItems,
				a.call(this)
		}
			;
		var u = o.prototype._manageStamp;
		return o.prototype._manageStamp = function () {
			this.options.isOriginLeft = this.isotope.options.isOriginLeft,
				this.options.isOriginTop = this.isotope.options.isOriginTop,
				u.apply(this, arguments)
		}
			,
			o
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("isotope/js/layout-modes/fit-rows", ["../layout-mode"], e) : "object" == typeof exports ? module.exports = e(require("../layout-mode")) : e(t.Isotope.LayoutMode)
	}(window, function (t) {
		var e = t.create("fitRows");
		return e.prototype._resetLayout = function () {
			this.x = 0,
				this.y = 0,
				this.maxY = 0,
				this._getMeasurement("gutter", "outerWidth")
		}
			,
			e.prototype._getItemLayoutPosition = function (t) {
				t.getSize();
				var e = t.size.outerWidth + this.gutter
					, i = this.isotope.size.innerWidth + this.gutter;
				0 !== this.x && e + this.x > i && (this.x = 0,
					this.y = this.maxY);
				var o = {
					x: this.x,
					y: this.y
				};
				return this.maxY = Math.max(this.maxY, this.y + t.size.outerHeight),
					this.x += e,
					o
			}
			,
			e.prototype._getContainerSize = function () {
				return {
					height: this.maxY
				}
			}
			,
			e
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define("isotope/js/layout-modes/vertical", ["../layout-mode"], e) : "object" == typeof exports ? module.exports = e(require("../layout-mode")) : e(t.Isotope.LayoutMode)
	}(window, function (t) {
		var e = t.create("vertical", {
			horizontalAlignment: 0
		});
		return e.prototype._resetLayout = function () {
			this.y = 0
		}
			,
			e.prototype._getItemLayoutPosition = function (t) {
				t.getSize();
				var e = (this.isotope.size.innerWidth - t.size.outerWidth) * this.options.horizontalAlignment
					, i = this.y;
				return this.y += t.size.outerHeight,
					{
						x: e,
						y: i
					}
			}
			,
			e.prototype._getContainerSize = function () {
				return {
					height: this.y
				}
			}
			,
			e
	}),
	function (t, e) {
		"function" == typeof define && define.amd ? define(["outlayer/outlayer", "get-size/get-size", "matches-selector/matches-selector", "fizzy-ui-utils/utils", "isotope/js/item", "isotope/js/layout-mode", "isotope/js/layout-modes/masonry", "isotope/js/layout-modes/fit-rows", "isotope/js/layout-modes/vertical"], function (i, o, n, r, s, a) {
			return e(t, i, o, n, r, s, a)
		}) : "object" == typeof exports ? module.exports = e(t, require("outlayer"), require("get-size"), require("desandro-matches-selector"), require("fizzy-ui-utils"), require("./item"), require("./layout-mode"), require("./layout-modes/masonry"), require("./layout-modes/fit-rows"), require("./layout-modes/vertical")) : t.Isotope = e(t, t.Outlayer, t.getSize, t.matchesSelector, t.fizzyUIUtils, t.Isotope.Item, t.Isotope.LayoutMode)
	}(window, function (t, e, i, o, n, r, s) {
		function a(t, e) {
			return function (i, o) {
				for (var n = 0, r = t.length; r > n; n++) {
					var s = t[n]
						, a = i.sortData[s]
						, u = o.sortData[s];
					if (a > u || u > a) {
						var p = void 0 !== e[s] ? e[s] : e
							, h = p ? 1 : -1;
						return (a > u ? 1 : -1) * h
					}
				}
				return 0
			}
		}
		var u = t.jQuery
			, p = String.prototype.trim ? function (t) {
				return t.trim()
			}
				: function (t) {
					return t.replace(/^\s+|\s+$/g, "")
				}
			, h = document.documentElement
			, f = h.textContent ? function (t) {
				return t.textContent
			}
				: function (t) {
					return t.innerText
				}
			, d = e.create("isotope", {
				layoutMode: "masonry",
				isJQueryFiltering: !0,
				sortAscending: !0
			});
		d.Item = r,
			d.LayoutMode = s,
			d.prototype._create = function () {
				this.itemGUID = 0,
					this._sorters = {},
					this._getSorters(),
					e.prototype._create.call(this),
					this.modes = {},
					this.filteredItems = this.items,
					this.sortHistory = ["original-order"];
				for (var t in s.modes)
					this._initLayoutMode(t)
			}
			,
			d.prototype.reloadItems = function () {
				this.itemGUID = 0,
					e.prototype.reloadItems.call(this)
			}
			,
			d.prototype._itemize = function () {
				for (var t = e.prototype._itemize.apply(this, arguments), i = 0, o = t.length; o > i; i++) {
					var n = t[i];
					n.id = this.itemGUID++
				}
				return this._updateItemsSortData(t),
					t
			}
			,
			d.prototype._initLayoutMode = function (t) {
				var e = s.modes[t]
					, i = this.options[t] || {};
				this.options[t] = e.options ? n.extend(e.options, i) : i,
					this.modes[t] = new e(this)
			}
			,
			d.prototype.layout = function () {
				return !this._isLayoutInited && this.options.isInitLayout ? (this.arrange(),
					void 0) : (this._layout(),
						void 0)
			}
			,
			d.prototype._layout = function () {
				var t = this._getIsInstant();
				this._resetLayout(),
					this._manageStamps(),
					this.layoutItems(this.filteredItems, t),
					this._isLayoutInited = !0
			}
			,
			d.prototype.arrange = function (t) {
				function e() {
					o.reveal(i.needReveal),
						o.hide(i.needHide)
				}
				this.option(t),
					this._getIsInstant();
				var i = this._filter(this.items);
				this.filteredItems = i.matches;
				var o = this;
				this._bindArrangeComplete(),
					this._isInstant ? this._noTransition(e) : e(),
					this._sort(),
					this._layout()
			}
			,
			d.prototype._init = d.prototype.arrange,
			d.prototype._getIsInstant = function () {
				var t = void 0 !== this.options.isLayoutInstant ? this.options.isLayoutInstant : !this._isLayoutInited;
				return this._isInstant = t,
					t
			}
			,
			d.prototype._bindArrangeComplete = function () {
				function t() {
					e && i && o && n.emitEvent("arrangeComplete", [n.filteredItems])
				}
				var e, i, o, n = this;
				this.once("layoutComplete", function () {
					e = !0,
						t()
				}),
					this.once("hideComplete", function () {
						i = !0,
							t()
					}),
					this.once("revealComplete", function () {
						o = !0,
							t()
					})
			}
			,
			d.prototype._filter = function (t) {
				var e = this.options.filter;
				e = e || "*";
				for (var i = [], o = [], n = [], r = this._getFilterTest(e), s = 0, a = t.length; a > s; s++) {
					var u = t[s];
					if (!u.isIgnored) {
						var p = r(u);
						p && i.push(u),
							p && u.isHidden ? o.push(u) : p || u.isHidden || n.push(u)
					}
				}
				return {
					matches: i,
					needReveal: o,
					needHide: n
				}
			}
			,
			d.prototype._getFilterTest = function (t) {
				return u && this.options.isJQueryFiltering ? function (e) {
					return u(e.element).is(t)
				}
					: "function" == typeof t ? function (e) {
						return t(e.element)
					}
						: function (e) {
							return o(e.element, t)
						}
			}
			,
			d.prototype.updateSortData = function (t) {
				var e;
				t ? (t = n.makeArray(t),
					e = this.getItems(t)) : e = this.items,
					this._getSorters(),
					this._updateItemsSortData(e)
			}
			,
			d.prototype._getSorters = function () {
				var t = this.options.getSortData;
				for (var e in t) {
					var i = t[e];
					this._sorters[e] = l(i)
				}
			}
			,
			d.prototype._updateItemsSortData = function (t) {
				for (var e = t && t.length, i = 0; e && e > i; i++) {
					var o = t[i];
					o.updateSortData()
				}
			}
			;
		var l = function () {
			function t(t) {
				if ("string" != typeof t)
					return t;
				var i = p(t).split(" ")
					, o = i[0]
					, n = o.match(/^\[(.+)\]$/)
					, r = n && n[1]
					, s = e(r, o)
					, a = d.sortDataParsers[i[1]];
				return t = a ? function (t) {
					return t && a(s(t))
				}
					: function (t) {
						return t && s(t)
					}
			}
			function e(t, e) {
				var i;
				return i = t ? function (e) {
					return e.getAttribute(t)
				}
					: function (t) {
						var i = t.querySelector(e);
						return i && f(i)
					}
			}
			return t
		}();
		d.sortDataParsers = {
			parseInt: function (t) {
				return parseInt(t, 10)
			},
			parseFloat: function (t) {
				return parseFloat(t)
			}
		},
			d.prototype._sort = function () {
				var t = this.options.sortBy;
				if (t) {
					var e = [].concat.apply(t, this.sortHistory)
						, i = a(e, this.options.sortAscending);
					this.filteredItems.sort(i),
						t != this.sortHistory[0] && this.sortHistory.unshift(t)
				}
			}
			,
			d.prototype._mode = function () {
				var t = this.options.layoutMode
					, e = this.modes[t];
				if (!e)
					throw Error("No layout mode: " + t);
				return e.options = this.options[t],
					e
			}
			,
			d.prototype._resetLayout = function () {
				e.prototype._resetLayout.call(this),
					this._mode()._resetLayout()
			}
			,
			d.prototype._getItemLayoutPosition = function (t) {
				return this._mode()._getItemLayoutPosition(t)
			}
			,
			d.prototype._manageStamp = function (t) {
				this._mode()._manageStamp(t)
			}
			,
			d.prototype._getContainerSize = function () {
				return this._mode()._getContainerSize()
			}
			,
			d.prototype.needsResizeLayout = function () {
				return this._mode().needsResizeLayout()
			}
			,
			d.prototype.appended = function (t) {
				var e = this.addItems(t);
				if (e.length) {
					var i = this._filterRevealAdded(e);
					this.filteredItems = this.filteredItems.concat(i)
				}
			}
			,
			d.prototype.prepended = function (t) {
				var e = this._itemize(t);
				if (e.length) {
					this._resetLayout(),
						this._manageStamps();
					var i = this._filterRevealAdded(e);
					this.layoutItems(this.filteredItems),
						this.filteredItems = i.concat(this.filteredItems),
						this.items = e.concat(this.items)
				}
			}
			,
			d.prototype._filterRevealAdded = function (t) {
				var e = this._filter(t);
				return this.hide(e.needHide),
					this.reveal(e.matches),
					this.layoutItems(e.matches, !0),
					e.matches
			}
			,
			d.prototype.insert = function (t) {
				var e = this.addItems(t);
				if (e.length) {
					var i, o, n = e.length;
					for (i = 0; n > i; i++)
						o = e[i],
							this.element.appendChild(o.element);
					var r = this._filter(e).matches;
					for (i = 0; n > i; i++)
						e[i].isLayoutInstant = !0;
					for (this.arrange(),
						i = 0; n > i; i++)
						delete e[i].isLayoutInstant;
					this.reveal(r)
				}
			}
			;
		var c = d.prototype.remove;
		return d.prototype.remove = function (t) {
			t = n.makeArray(t);
			var e = this.getItems(t);
			c.call(this, t);
			var i = e && e.length;
			if (i)
				for (var o = 0; i > o; o++) {
					var r = e[o];
					n.removeFrom(this.filteredItems, r)
				}
		}
			,
			d.prototype.shuffle = function () {
				for (var t = 0, e = this.items.length; e > t; t++) {
					var i = this.items[t];
					i.sortData.random = Math.random()
				}
				this.options.sortBy = "random",
					this._sort(),
					this._layout()
			}
			,
			d.prototype._noTransition = function (t) {
				var e = this.options.transitionDuration;
				this.options.transitionDuration = 0;
				var i = t.call(this);
				return this.options.transitionDuration = e,
					i
			}
			,
			d.prototype.getFilteredItemElements = function () {
				for (var t = [], e = 0, i = this.filteredItems.length; i > e; e++)
					t.push(this.filteredItems[e].element);
				return t
			}
			,
			d
	});
!function (a, b, c, d) {
	function e(b, c) {
		this.settings = null,
			this.options = a.extend({}, e.Defaults, c),
			this.$element = a(b),
			this.drag = a.extend({}, m),
			this.state = a.extend({}, n),
			this.e = a.extend({}, o),
			this._plugins = {},
			this._supress = {},
			this._current = null,
			this._speed = null,
			this._coordinates = [],
			this._breakpoint = null,
			this._width = null,
			this._items = [],
			this._clones = [],
			this._mergers = [],
			this._invalidated = {},
			this._pipe = [],
			a.each(e.Plugins, a.proxy(function (a, b) {
				this._plugins[a[0].toLowerCase() + a.slice(1)] = new b(this)
			}, this)),
			a.each(e.Pipe, a.proxy(function (b, c) {
				this._pipe.push({
					filter: c.filter,
					run: a.proxy(c.run, this)
				})
			}, this)),
			this.setup(),
			this.initialize()
	}
	function f(a) {
		if (a.touches !== d)
			return {
				x: a.touches[0].pageX,
				y: a.touches[0].pageY
			};
		if (a.touches === d) {
			if (a.pageX !== d)
				return {
					x: a.pageX,
					y: a.pageY
				};
			if (a.pageX === d)
				return {
					x: a.clientX,
					y: a.clientY
				}
		}
	}
	function g(a) {
		var b, d, e = c.createElement("div"), f = a;
		for (b in f)
			if (d = f[b],
				"undefined" != typeof e.style[d])
				return e = null,
					[d, b];
		return [!1]
	}
	function h() {
		return g(["transition", "WebkitTransition", "MozTransition", "OTransition"])[1]
	}
	function i() {
		return g(["transform", "WebkitTransform", "MozTransform", "OTransform", "msTransform"])[0]
	}
	function j() {
		return g(["perspective", "webkitPerspective", "MozPerspective", "OPerspective", "MsPerspective"])[0]
	}
	function k() {
		return "ontouchstart" in b || !!navigator.msMaxTouchPoints
	}
	function l() {
		return b.navigator.msPointerEnabled
	}
	var m, n, o;
	m = {
		start: 0,
		startX: 0,
		startY: 0,
		current: 0,
		currentX: 0,
		currentY: 0,
		offsetX: 0,
		offsetY: 0,
		distance: null,
		startTime: 0,
		endTime: 0,
		updatedX: 0,
		targetEl: null
	},
		n = {
			isTouch: !1,
			isScrolling: !1,
			isSwiping: !1,
			direction: !1,
			inMotion: !1
		},
		o = {
			_onDragStart: null,
			_onDragMove: null,
			_onDragEnd: null,
			_transitionEnd: null,
			_resizer: null,
			_responsiveCall: null,
			_goToLoop: null,
			_checkVisibile: null
		},
		e.Defaults = {
			items: 3,
			loop: !1,
			center: !1,
			mouseDrag: !0,
			touchDrag: !0,
			pullDrag: !0,
			freeDrag: !1,
			margin: 0,
			stagePadding: 0,
			merge: !1,
			mergeFit: !0,
			autoWidth: !1,
			startPosition: 0,
			rtl: !1,
			smartSpeed: 250,
			fluidSpeed: !1,
			dragEndSpeed: !1,
			responsive: {},
			responsiveRefreshRate: 200,
			responsiveBaseElement: b,
			responsiveClass: !1,
			fallbackEasing: "swing",
			info: !1,
			nestedItemSelector: !1,
			itemElement: "div",
			stageElement: "div",
			themeClass: "owl-theme",
			baseClass: "owl-carousel",
			itemClass: "owl-item",
			centerClass: "center",
			activeClass: "active"
		},
		e.Width = {
			Default: "default",
			Inner: "inner",
			Outer: "outer"
		},
		e.Plugins = {},
		e.Pipe = [{
			filter: ["width", "items", "settings"],
			run: function (a) {
				a.current = this._items && this._items[this.relative(this._current)]
			}
		}, {
			filter: ["items", "settings"],
			run: function () {
				var a = this._clones
					, b = this.$stage.children(".cloned");
				(b.length !== a.length || !this.settings.loop && a.length > 0) && (this.$stage.children(".cloned").remove(),
					this._clones = [])
			}
		}, {
			filter: ["items", "settings"],
			run: function () {
				var a, b, c = this._clones, d = this._items, e = this.settings.loop ? c.length - Math.max(2 * this.settings.items, 4) : 0;
				for (a = 0,
					b = Math.abs(e / 2); b > a; a++)
					e > 0 ? (this.$stage.children().eq(d.length + c.length - 1).remove(),
						c.pop(),
						this.$stage.children().eq(0).remove(),
						c.pop()) : (c.push(c.length / 2),
							this.$stage.append(d[c[c.length - 1]].clone().addClass("cloned")),
							c.push(d.length - 1 - (c.length - 1) / 2),
							this.$stage.prepend(d[c[c.length - 1]].clone().addClass("cloned")))
			}
		}, {
			filter: ["width", "items", "settings"],
			run: function () {
				var a, b, c, d = this.settings.rtl ? 1 : -1, e = (this.width() / this.settings.items).toFixed(3), f = 0;
				for (this._coordinates = [],
					b = 0,
					c = this._clones.length + this._items.length; c > b; b++)
					a = this._mergers[this.relative(b)],
						a = this.settings.mergeFit && Math.min(a, this.settings.items) || a,
						f += (this.settings.autoWidth ? this._items[this.relative(b)].width() + this.settings.margin : e * a) * d,
						this._coordinates.push(f)
			}
		}, {
			filter: ["width", "items", "settings"],
			run: function () {
				var b, c, d = (this.width() / this.settings.items).toFixed(3), e = {
					width: Math.abs(this._coordinates[this._coordinates.length - 1]) + 2 * this.settings.stagePadding,
					"padding-left": this.settings.stagePadding || "",
					"padding-right": this.settings.stagePadding || ""
				};
				if (this.$stage.css(e),
					e = {
						width: this.settings.autoWidth ? "auto" : d - this.settings.margin
					},
					e[this.settings.rtl ? "margin-left" : "margin-right"] = this.settings.margin,
					!this.settings.autoWidth && a.grep(this._mergers, function (a) {
						return a > 1
					}).length > 0)
					for (b = 0,
						c = this._coordinates.length; c > b; b++)
						e.width = Math.abs(this._coordinates[b]) - Math.abs(this._coordinates[b - 1] || 0) - this.settings.margin,
							this.$stage.children().eq(b).css(e);
				else
					this.$stage.children().css(e)
			}
		}, {
			filter: ["width", "items", "settings"],
			run: function (a) {
				a.current && this.reset(this.$stage.children().index(a.current))
			}
		}, {
			filter: ["position"],
			run: function () {
				this.animate(this.coordinates(this._current))
			}
		}, {
			filter: ["width", "position", "items", "settings"],
			run: function () {
				var a, b, c, d, e = this.settings.rtl ? 1 : -1, f = 2 * this.settings.stagePadding, g = this.coordinates(this.current()) + f, h = g + this.width() * e, i = [];
				for (c = 0,
					d = this._coordinates.length; d > c; c++)
					a = this._coordinates[c - 1] || 0,
						b = Math.abs(this._coordinates[c]) + f * e,
						(this.op(a, "<=", g) && this.op(a, ">", h) || this.op(b, "<", g) && this.op(b, ">", h)) && i.push(c);
				this.$stage.children("." + this.settings.activeClass).removeClass(this.settings.activeClass),
					this.$stage.children(":eq(" + i.join("), :eq(") + ")").addClass(this.settings.activeClass),
					this.settings.center && (this.$stage.children("." + this.settings.centerClass).removeClass(this.settings.centerClass),
						this.$stage.children().eq(this.current()).addClass(this.settings.centerClass))
			}
		}],
		e.prototype.initialize = function () {
			if (this.trigger("initialize"),
				this.$element.addClass(this.settings.baseClass).addClass(this.settings.themeClass).toggleClass("owl-rtl", this.settings.rtl),
				this.browserSupport(),
				this.settings.autoWidth && this.state.imagesLoaded !== !0) {
				var b, c, e;
				if (b = this.$element.find("img"),
					c = this.settings.nestedItemSelector ? "." + this.settings.nestedItemSelector : d,
					e = this.$element.children(c).width(),
					b.length && 0 >= e)
					return this.preloadAutoWidthImages(b),
						!1
			}
			this.$element.addClass("owl-loading"),
				this.$stage = a("<" + this.settings.stageElement + ' class="owl-stage"/>').wrap('<div class="owl-stage-outer">'),
				this.$element.append(this.$stage.parent()),
				this.replace(this.$element.children().not(this.$stage.parent())),
				this._width = this.$element.width(),
				this.refresh(),
				this.$element.removeClass("owl-loading").addClass("owl-loaded"),
				this.eventsCall(),
				this.internalEvents(),
				this.addTriggerableEvents(),
				this.trigger("initialized")
		}
		,
		e.prototype.setup = function () {
			var b = this.viewport()
				, c = this.options.responsive
				, d = -1
				, e = null;
			c ? (a.each(c, function (a) {
				b >= a && a > d && (d = Number(a))
			}),
				e = a.extend({}, this.options, c[d]),
				delete e.responsive,
				e.responsiveClass && this.$element.attr("class", function (a, b) {
					return b.replace(/\b owl-responsive-\S+/g, "")
				}).addClass("owl-responsive-" + d)) : e = a.extend({}, this.options),
				(null === this.settings || this._breakpoint !== d) && (this.trigger("change", {
					property: {
						name: "settings",
						value: e
					}
				}),
					this._breakpoint = d,
					this.settings = e,
					this.invalidate("settings"),
					this.trigger("changed", {
						property: {
							name: "settings",
							value: this.settings
						}
					}))
		}
		,
		e.prototype.optionsLogic = function () {
			this.$element.toggleClass("owl-center", this.settings.center),
				this.settings.loop && this._items.length < this.settings.items && (this.settings.loop = !1),
				this.settings.autoWidth && (this.settings.stagePadding = !1,
					this.settings.merge = !1)
		}
		,
		e.prototype.prepare = function (b) {
			var c = this.trigger("prepare", {
				content: b
			});
			return c.data || (c.data = a("<" + this.settings.itemElement + "/>").addClass(this.settings.itemClass).append(b)),
				this.trigger("prepared", {
					content: c.data
				}),
				c.data
		}
		,
		e.prototype.update = function () {
			for (var b = 0, c = this._pipe.length, d = a.proxy(function (a) {
				return this[a]
			}, this._invalidated), e = {}; c > b;)
				(this._invalidated.all || a.grep(this._pipe[b].filter, d).length > 0) && this._pipe[b].run(e),
					b++;
			this._invalidated = {}
		}
		,
		e.prototype.width = function (a) {
			switch (a = a || e.Width.Default) {
				case e.Width.Inner:
				case e.Width.Outer:
					return this._width;
				default:
					return this._width - 2 * this.settings.stagePadding + this.settings.margin
			}
		}
		,
		e.prototype.refresh = function () {
			if (0 === this._items.length)
				return !1;
			(new Date).getTime();
			this.trigger("refresh"),
				this.setup(),
				this.optionsLogic(),
				this.$stage.addClass("owl-refresh"),
				this.update(),
				this.$stage.removeClass("owl-refresh"),
				this.state.orientation = b.orientation,
				this.watchVisibility(),
				this.trigger("refreshed")
		}
		,
		e.prototype.eventsCall = function () {
			this.e._onDragStart = a.proxy(function (a) {
				this.onDragStart(a)
			}, this),
				this.e._onDragMove = a.proxy(function (a) {
					this.onDragMove(a)
				}, this),
				this.e._onDragEnd = a.proxy(function (a) {
					this.onDragEnd(a)
				}, this),
				this.e._onResize = a.proxy(function (a) {
					this.onResize(a)
				}, this),
				this.e._transitionEnd = a.proxy(function (a) {
					this.transitionEnd(a)
				}, this),
				this.e._preventClick = a.proxy(function (a) {
					this.preventClick(a)
				}, this)
		}
		,
		e.prototype.onThrottledResize = function () {
			b.clearTimeout(this.resizeTimer),
				this.resizeTimer = b.setTimeout(this.e._onResize, this.settings.responsiveRefreshRate)
		}
		,
		e.prototype.onResize = function () {
			return this._items.length ? this._width === this.$element.width() ? !1 : this.trigger("resize").isDefaultPrevented() ? !1 : (this._width = this.$element.width(),
				this.invalidate("width"),
				this.refresh(),
				void this.trigger("resized")) : !1
		}
		,
		e.prototype.eventsRouter = function (a) {
			var b = a.type;
			"mousedown" === b || "touchstart" === b ? this.onDragStart(a) : "mousemove" === b || "touchmove" === b ? this.onDragMove(a) : "mouseup" === b || "touchend" === b ? this.onDragEnd(a) : "touchcancel" === b && this.onDragEnd(a)
		}
		,
		e.prototype.internalEvents = function () {
			var c = (k(),
				l());
			this.settings.mouseDrag ? (this.$stage.on("mousedown", a.proxy(function (a) {
				this.eventsRouter(a)
			}, this)),
				this.$stage.on("dragstart", function () {
					return !1
				}),
				this.$stage.get(0).onselectstart = function () {
					return !1
				}
			) : this.$element.addClass("owl-text-select-on"),
				this.settings.touchDrag && !c && this.$stage.on("touchstart touchcancel", a.proxy(function (a) {
					this.eventsRouter(a)
				}, this)),
				this.transitionEndVendor && this.on(this.$stage.get(0), this.transitionEndVendor, this.e._transitionEnd, !1),
				this.settings.responsive !== !1 && this.on(b, "resize", a.proxy(this.onThrottledResize, this))
		}
		,
		e.prototype.onDragStart = function (d) {
			var e, g, h, i;
			if (e = d.originalEvent || d || b.event,
				3 === e.which || this.state.isTouch)
				return !1;
			if ("mousedown" === e.type && this.$stage.addClass("owl-grab"),
				this.trigger("drag"),
				this.drag.startTime = (new Date).getTime(),
				this.speed(0),
				this.state.isTouch = !0,
				this.state.isScrolling = !1,
				this.state.isSwiping = !1,
				this.drag.distance = 0,
				g = f(e).x,
				h = f(e).y,
				this.drag.offsetX = this.$stage.position().left,
				this.drag.offsetY = this.$stage.position().top,
				this.settings.rtl && (this.drag.offsetX = this.$stage.position().left + this.$stage.width() - this.width() + this.settings.margin),
				this.state.inMotion && this.support3d)
				i = this.getTransformProperty(),
					this.drag.offsetX = i,
					this.animate(i),
					this.state.inMotion = !0;
			else if (this.state.inMotion && !this.support3d)
				return this.state.inMotion = !1,
					!1;
			this.drag.startX = g - this.drag.offsetX,
				this.drag.startY = h - this.drag.offsetY,
				this.drag.start = g - this.drag.startX,
				this.drag.targetEl = e.target || e.srcElement,
				this.drag.updatedX = this.drag.start,
				("IMG" === this.drag.targetEl.tagName || "A" === this.drag.targetEl.tagName) && (this.drag.targetEl.draggable = !1),
				a(c).on("mousemove.owl.dragEvents mouseup.owl.dragEvents touchmove.owl.dragEvents touchend.owl.dragEvents", a.proxy(function (a) {
					this.eventsRouter(a)
				}, this))
		}
		,
		e.prototype.onDragMove = function (a) {
			var c, e, g, h, i, j;
			this.state.isTouch && (this.state.isScrolling || (c = a.originalEvent || a || b.event,
				e = f(c).x,
				g = f(c).y,
				this.drag.currentX = e - this.drag.startX,
				this.drag.currentY = g - this.drag.startY,
				this.drag.distance = this.drag.currentX - this.drag.offsetX,
				this.drag.distance < 0 ? this.state.direction = this.settings.rtl ? "right" : "left" : this.drag.distance > 0 && (this.state.direction = this.settings.rtl ? "left" : "right"),
				this.settings.loop ? this.op(this.drag.currentX, ">", this.coordinates(this.minimum())) && "right" === this.state.direction ? this.drag.currentX -= (this.settings.center && this.coordinates(0)) - this.coordinates(this._items.length) : this.op(this.drag.currentX, "<", this.coordinates(this.maximum())) && "left" === this.state.direction && (this.drag.currentX += (this.settings.center && this.coordinates(0)) - this.coordinates(this._items.length)) : (h = this.coordinates(this.settings.rtl ? this.maximum() : this.minimum()),
					i = this.coordinates(this.settings.rtl ? this.minimum() : this.maximum()),
					j = this.settings.pullDrag ? this.drag.distance / 5 : 0,
					this.drag.currentX = Math.max(Math.min(this.drag.currentX, h + j), i + j)),
				(this.drag.distance > 8 || this.drag.distance < -8) && (c.preventDefault !== d ? c.preventDefault() : c.returnValue = !1,
					this.state.isSwiping = !0),
				this.drag.updatedX = this.drag.currentX,
				(this.drag.currentY > 16 || this.drag.currentY < -16) && this.state.isSwiping === !1 && (this.state.isScrolling = !0,
					this.drag.updatedX = this.drag.start),
				this.animate(this.drag.updatedX)))
		}
		,
		e.prototype.onDragEnd = function (b) {
			var d, e, f;
			if (this.state.isTouch) {
				if ("mouseup" === b.type && this.$stage.removeClass("owl-grab"),
					this.trigger("dragged"),
					this.drag.targetEl.removeAttribute("draggable"),
					this.state.isTouch = !1,
					this.state.isScrolling = !1,
					this.state.isSwiping = !1,
					0 === this.drag.distance && this.state.inMotion !== !0)
					return this.state.inMotion = !1,
						!1;
				this.drag.endTime = (new Date).getTime(),
					d = this.drag.endTime - this.drag.startTime,
					e = Math.abs(this.drag.distance),
					(e > 3 || d > 300) && this.removeClick(this.drag.targetEl),
					f = this.closest(this.drag.updatedX),
					this.speed(this.settings.dragEndSpeed || this.settings.smartSpeed),
					this.current(f),
					this.invalidate("position"),
					this.update(),
					this.settings.pullDrag || this.drag.updatedX !== this.coordinates(f) || this.transitionEnd(),
					this.drag.distance = 0,
					a(c).off(".owl.dragEvents")
			}
		}
		,
		e.prototype.removeClick = function (c) {
			this.drag.targetEl = c,
				a(c).on("click.preventClick", this.e._preventClick),
				b.setTimeout(function () {
					a(c).off("click.preventClick")
				}, 300)
		}
		,
		e.prototype.preventClick = function (b) {
			b.preventDefault ? b.preventDefault() : b.returnValue = !1,
				b.stopPropagation && b.stopPropagation(),
				a(b.target).off("click.preventClick")
		}
		,
		e.prototype.getTransformProperty = function () {
			var a, c;
			return a = b.getComputedStyle(this.$stage.get(0), null).getPropertyValue(this.vendorName + "transform"),
				a = a.replace(/matrix(3d)?\(|\)/g, "").split(","),
				c = 16 === a.length,
				c !== !0 ? a[4] : a[12]
		}
		,
		e.prototype.closest = function (b) {
			var c = -1
				, d = 30
				, e = this.width()
				, f = this.coordinates();
			return this.settings.freeDrag || a.each(f, a.proxy(function (a, g) {
				return b > g - d && g + d > b ? c = a : this.op(b, "<", g) && this.op(b, ">", f[a + 1] || g - e) && (c = "left" === this.state.direction ? a + 1 : a),
					-1 === c
			}, this)),
				this.settings.loop || (this.op(b, ">", f[this.minimum()]) ? c = b = this.minimum() : this.op(b, "<", f[this.maximum()]) && (c = b = this.maximum())),
				c
		}
		,
		e.prototype.animate = function (b) {
			this.trigger("translate"),
				this.state.inMotion = this.speed() > 0,
				this.support3d ? this.$stage.css({
					transform: "translate3d(" + b + "px,0px, 0px)",
					transition: this.speed() / 1e3 + "s"
				}) : this.state.isTouch ? this.$stage.css({
					left: b + "px"
				}) : this.$stage.animate({
					left: b
				}, this.speed() / 1e3, this.settings.fallbackEasing, a.proxy(function () {
					this.state.inMotion && this.transitionEnd()
				}, this))
		}
		,
		e.prototype.current = function (a) {
			if (a === d)
				return this._current;
			if (0 === this._items.length)
				return d;
			if (a = this.normalize(a),
				this._current !== a) {
				var b = this.trigger("change", {
					property: {
						name: "position",
						value: a
					}
				});
				b.data !== d && (a = this.normalize(b.data)),
					this._current = a,
					this.invalidate("position"),
					this.trigger("changed", {
						property: {
							name: "position",
							value: this._current
						}
					})
			}
			return this._current
		}
		,
		e.prototype.invalidate = function (a) {
			this._invalidated[a] = !0
		}
		,
		e.prototype.reset = function (a) {
			a = this.normalize(a),
				a !== d && (this._speed = 0,
					this._current = a,
					this.suppress(["translate", "translated"]),
					this.animate(this.coordinates(a)),
					this.release(["translate", "translated"]))
		}
		,
		e.prototype.normalize = function (b, c) {
			var e = c ? this._items.length : this._items.length + this._clones.length;
			return !a.isNumeric(b) || 1 > e ? d : b = this._clones.length ? (b % e + e) % e : Math.max(this.minimum(c), Math.min(this.maximum(c), b))
		}
		,
		e.prototype.relative = function (a) {
			return a = this.normalize(a),
				a -= this._clones.length / 2,
				this.normalize(a, !0)
		}
		,
		e.prototype.maximum = function (a) {
			var b, c, d, e = 0, f = this.settings;
			if (a)
				return this._items.length - 1;
			if (!f.loop && f.center)
				b = this._items.length - 1;
			else if (f.loop || f.center)
				if (f.loop || f.center)
					b = this._items.length + f.items;
				else {
					if (!f.autoWidth && !f.merge)
						throw "Can not detect maximum absolute position.";
					for (revert = f.rtl ? 1 : -1,
						c = this.$stage.width() - this.$element.width(); (d = this.coordinates(e)) && !(d * revert >= c);)
						b = ++e
				}
			else
				b = this._items.length - f.items;
			return b
		}
		,
		e.prototype.minimum = function (a) {
			return a ? 0 : this._clones.length / 2
		}
		,
		e.prototype.items = function (a) {
			return a === d ? this._items.slice() : (a = this.normalize(a, !0),
				this._items[a])
		}
		,
		e.prototype.mergers = function (a) {
			return a === d ? this._mergers.slice() : (a = this.normalize(a, !0),
				this._mergers[a])
		}
		,
		e.prototype.clones = function (b) {
			var c = this._clones.length / 2
				, e = c + this._items.length
				, f = function (a) {
					return a % 2 === 0 ? e + a / 2 : c - (a + 1) / 2
				};
			return b === d ? a.map(this._clones, function (a, b) {
				return f(b)
			}) : a.map(this._clones, function (a, c) {
				return a === b ? f(c) : null
			})
		}
		,
		e.prototype.speed = function (a) {
			return a !== d && (this._speed = a),
				this._speed
		}
		,
		e.prototype.coordinates = function (b) {
			var c = null;
			return b === d ? a.map(this._coordinates, a.proxy(function (a, b) {
				return this.coordinates(b)
			}, this)) : (this.settings.center ? (c = this._coordinates[b],
				c += (this.width() - c + (this._coordinates[b - 1] || 0)) / 2 * (this.settings.rtl ? -1 : 1)) : c = this._coordinates[b - 1] || 0,
				c)
		}
		,
		e.prototype.duration = function (a, b, c) {
			return Math.min(Math.max(Math.abs(b - a), 1), 6) * Math.abs(c || this.settings.smartSpeed)
		}
		,
		e.prototype.to = function (c, d) {
			if (this.settings.loop) {
				var e = c - this.relative(this.current())
					, f = this.current()
					, g = this.current()
					, h = this.current() + e
					, i = 0 > g - h ? !0 : !1
					, j = this._clones.length + this._items.length;
				h < this.settings.items && i === !1 ? (f = g + this._items.length,
					this.reset(f)) : h >= j - this.settings.items && i === !0 && (f = g - this._items.length,
						this.reset(f)),
					b.clearTimeout(this.e._goToLoop),
					this.e._goToLoop = b.setTimeout(a.proxy(function () {
						this.speed(this.duration(this.current(), f + e, d)),
							this.current(f + e),
							this.update()
					}, this), 30)
			} else
				this.speed(this.duration(this.current(), c, d)),
					this.current(c),
					this.update()
		}
		,
		e.prototype.next = function (a) {
			a = a || !1,
				this.to(this.relative(this.current()) + 1, a)
		}
		,
		e.prototype.prev = function (a) {
			a = a || !1,
				this.to(this.relative(this.current()) - 1, a)
		}
		,
		e.prototype.transitionEnd = function (a) {
			return a !== d && (a.stopPropagation(),
				(a.target || a.srcElement || a.originalTarget) !== this.$stage.get(0)) ? !1 : (this.state.inMotion = !1,
					void this.trigger("translated"))
		}
		,
		e.prototype.viewport = function () {
			var d;
			if (this.options.responsiveBaseElement !== b)
				d = a(this.options.responsiveBaseElement).width();
			else if (b.innerWidth)
				d = b.innerWidth;
			else {
				if (!c.documentElement || !c.documentElement.clientWidth)
					throw "Can not detect viewport width.";
				d = c.documentElement.clientWidth
			}
			return d
		}
		,
		e.prototype.replace = function (b) {
			this.$stage.empty(),
				this._items = [],
				b && (b = b instanceof jQuery ? b : a(b)),
				this.settings.nestedItemSelector && (b = b.find("." + this.settings.nestedItemSelector)),
				b.filter(function () {
					return 1 === this.nodeType
				}).each(a.proxy(function (a, b) {
					b = this.prepare(b),
						this.$stage.append(b),
						this._items.push(b),
						this._mergers.push(1 * b.find("[data-merge]").andSelf("[data-merge]").attr("data-merge") || 1)
				}, this)),
				this.reset(a.isNumeric(this.settings.startPosition) ? this.settings.startPosition : 0),
				this.invalidate("items")
		}
		,
		e.prototype.add = function (a, b) {
			b = b === d ? this._items.length : this.normalize(b, !0),
				this.trigger("add", {
					content: a,
					position: b
				}),
				0 === this._items.length || b === this._items.length ? (this.$stage.append(a),
					this._items.push(a),
					this._mergers.push(1 * a.find("[data-merge]").andSelf("[data-merge]").attr("data-merge") || 1)) : (this._items[b].before(a),
						this._items.splice(b, 0, a),
						this._mergers.splice(b, 0, 1 * a.find("[data-merge]").andSelf("[data-merge]").attr("data-merge") || 1)),
				this.invalidate("items"),
				this.trigger("added", {
					content: a,
					position: b
				})
		}
		,
		e.prototype.remove = function (a) {
			a = this.normalize(a, !0),
				a !== d && (this.trigger("remove", {
					content: this._items[a],
					position: a
				}),
					this._items[a].remove(),
					this._items.splice(a, 1),
					this._mergers.splice(a, 1),
					this.invalidate("items"),
					this.trigger("removed", {
						content: null,
						position: a
					}))
		}
		,
		e.prototype.addTriggerableEvents = function () {
			var b = a.proxy(function (b, c) {
				return a.proxy(function (a) {
					a.relatedTarget !== this && (this.suppress([c]),
						b.apply(this, [].slice.call(arguments, 1)),
						this.release([c]))
				}, this)
			}, this);
			a.each({
				next: this.next,
				prev: this.prev,
				to: this.to,
				destroy: this.destroy,
				refresh: this.refresh,
				replace: this.replace,
				add: this.add,
				remove: this.remove
			}, a.proxy(function (a, c) {
				this.$element.on(a + ".owl.carousel", b(c, a + ".owl.carousel"))
			}, this))
		}
		,
		e.prototype.watchVisibility = function () {
			function c(a) {
				return a.offsetWidth > 0 && a.offsetHeight > 0
			}
			function d() {
				c(this.$element.get(0)) && (this.$element.removeClass("owl-hidden"),
					this.refresh(),
					b.clearInterval(this.e._checkVisibile))
			}
			c(this.$element.get(0)) || (this.$element.addClass("owl-hidden"),
				b.clearInterval(this.e._checkVisibile),
				this.e._checkVisibile = b.setInterval(a.proxy(d, this), 500))
		}
		,
		e.prototype.preloadAutoWidthImages = function (b) {
			var c, d, e, f;
			c = 0,
				d = this,
				b.each(function (g, h) {
					e = a(h),
						f = new Image,
						f.onload = function () {
							c++ ,
								e.attr("src", f.src),
								e.css("opacity", 1),
								c >= b.length && (d.state.imagesLoaded = !0,
									d.initialize())
						}
						,
						f.src = e.attr("src") || e.attr("data-src") || e.attr("data-src-retina")
				})
		}
		,
		e.prototype.destroy = function () {
			this.$element.hasClass(this.settings.themeClass) && this.$element.removeClass(this.settings.themeClass),
				this.settings.responsive !== !1 && a(b).off("resize.owl.carousel"),
				this.transitionEndVendor && this.off(this.$stage.get(0), this.transitionEndVendor, this.e._transitionEnd);
			for (var d in this._plugins)
				this._plugins[d].destroy();
			(this.settings.mouseDrag || this.settings.touchDrag) && (this.$stage.off("mousedown touchstart touchcancel"),
				a(c).off(".owl.dragEvents"),
				this.$stage.get(0).onselectstart = function () { }
				,
				this.$stage.off("dragstart", function () {
					return !1
				})),
				this.$element.off(".owl"),
				this.$stage.children(".cloned").remove(),
				this.e = null,
				this.$element.removeData("owlCarousel"),
				this.$stage.children().contents().unwrap(),
				this.$stage.children().unwrap(),
				this.$stage.unwrap()
		}
		,
		e.prototype.op = function (a, b, c) {
			var d = this.settings.rtl;
			switch (b) {
				case "<":
					return d ? a > c : c > a;
				case ">":
					return d ? c > a : a > c;
				case ">=":
					return d ? c >= a : a >= c;
				case "<=":
					return d ? a >= c : c >= a
			}
		}
		,
		e.prototype.on = function (a, b, c, d) {
			a.addEventListener ? a.addEventListener(b, c, d) : a.attachEvent && a.attachEvent("on" + b, c)
		}
		,
		e.prototype.off = function (a, b, c, d) {
			a.removeEventListener ? a.removeEventListener(b, c, d) : a.detachEvent && a.detachEvent("on" + b, c)
		}
		,
		e.prototype.trigger = function (b, c, d) {
			var e = {
				item: {
					count: this._items.length,
					index: this.current()
				}
			}
				, f = a.camelCase(a.grep(["on", b, d], function (a) {
					return a
				}).join("-").toLowerCase())
				, g = a.Event([b, "owl", d || "carousel"].join(".").toLowerCase(), a.extend({
					relatedTarget: this
				}, e, c));
			return this._supress[b] || (a.each(this._plugins, function (a, b) {
				b.onTrigger && b.onTrigger(g)
			}),
				this.$element.trigger(g),
				this.settings && "function" == typeof this.settings[f] && this.settings[f].apply(this, g)),
				g
		}
		,
		e.prototype.suppress = function (b) {
			a.each(b, a.proxy(function (a, b) {
				this._supress[b] = !0
			}, this))
		}
		,
		e.prototype.release = function (b) {
			a.each(b, a.proxy(function (a, b) {
				delete this._supress[b]
			}, this))
		}
		,
		e.prototype.browserSupport = function () {
			if (this.support3d = j(),
				this.support3d) {
				this.transformVendor = i();
				var a = ["transitionend", "webkitTransitionEnd", "transitionend", "oTransitionEnd"];
				this.transitionEndVendor = a[h()],
					this.vendorName = this.transformVendor.replace(/Transform/i, ""),
					this.vendorName = "" !== this.vendorName ? "-" + this.vendorName.toLowerCase() + "-" : ""
			}
			this.state.orientation = b.orientation
		}
		,
		a.fn.owlCarousel = function (b) {
			return this.each(function () {
				a(this).data("owlCarousel") || a(this).data("owlCarousel", new e(this, b))
			})
		}
		,
		a.fn.owlCarousel.Constructor = e
}(window.Zepto || window.jQuery, window, document),
	function (a, b) {
		var c = function (b) {
			this._core = b,
				this._loaded = [],
				this._handlers = {
					"initialized.owl.carousel change.owl.carousel": a.proxy(function (b) {
						if (b.namespace && this._core.settings && this._core.settings.lazyLoad && (b.property && "position" == b.property.name || "initialized" == b.type))
							for (var c = this._core.settings, d = c.center && Math.ceil(c.items / 2) || c.items, e = c.center && -1 * d || 0, f = (b.property && b.property.value || this._core.current()) + e, g = this._core.clones().length, h = a.proxy(function (a, b) {
								this.load(b)
							}, this); e++ < d;)
								this.load(g / 2 + this._core.relative(f)),
									g && a.each(this._core.clones(this._core.relative(f++)), h)
					}, this)
				},
				this._core.options = a.extend({}, c.Defaults, this._core.options),
				this._core.$element.on(this._handlers)
		};
		c.Defaults = {
			lazyLoad: !1
		},
			c.prototype.load = function (c) {
				var d = this._core.$stage.children().eq(c)
					, e = d && d.find(".owl-lazy");
				!e || a.inArray(d.get(0), this._loaded) > -1 || (e.each(a.proxy(function (c, d) {
					var e, f = a(d), g = b.devicePixelRatio > 1 && f.attr("data-src-retina") || f.attr("data-src");
					this._core.trigger("load", {
						element: f,
						url: g
					}, "lazy"),
						f.is("img") ? f.one("load.owl.lazy", a.proxy(function () {
							f.css("opacity", 1),
								this._core.trigger("loaded", {
									element: f,
									url: g
								}, "lazy")
						}, this)).attr("src", g) : (e = new Image,
							e.onload = a.proxy(function () {
								f.css({
									"background-image": "url(" + g + ")",
									opacity: "1"
								}),
									this._core.trigger("loaded", {
										element: f,
										url: g
									}, "lazy")
							}, this),
							e.src = g)
				}, this)),
					this._loaded.push(d.get(0)))
			}
			,
			c.prototype.destroy = function () {
				var a, b;
				for (a in this.handlers)
					this._core.$element.off(a, this.handlers[a]);
				for (b in Object.getOwnPropertyNames(this))
					"function" != typeof this[b] && (this[b] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.Lazy = c
	}(window.Zepto || window.jQuery, window, document),
	function (a) {
		var b = function (c) {
			this._core = c,
				this._handlers = {
					"initialized.owl.carousel": a.proxy(function () {
						this._core.settings.autoHeight && this.update()
					}, this),
					"changed.owl.carousel": a.proxy(function (a) {
						this._core.settings.autoHeight && "position" == a.property.name && this.update()
					}, this),
					"loaded.owl.lazy": a.proxy(function (a) {
						this._core.settings.autoHeight && a.element.closest("." + this._core.settings.itemClass) === this._core.$stage.children().eq(this._core.current()) && this.update()
					}, this)
				},
				this._core.options = a.extend({}, b.Defaults, this._core.options),
				this._core.$element.on(this._handlers)
		};
		b.Defaults = {
			autoHeight: !1,
			autoHeightClass: "owl-height"
		},
			b.prototype.update = function () {
				this._core.$stage.parent().height(this._core.$stage.children().eq(this._core.current()).height()).addClass(this._core.settings.autoHeightClass)
			}
			,
			b.prototype.destroy = function () {
				var a, b;
				for (a in this._handlers)
					this._core.$element.off(a, this._handlers[a]);
				for (b in Object.getOwnPropertyNames(this))
					"function" != typeof this[b] && (this[b] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.AutoHeight = b
	}(window.Zepto || window.jQuery, window, document),
	function (a, b, c) {
		var d = function (b) {
			this._core = b,
				this._videos = {},
				this._playing = null,
				this._fullscreen = !1,
				this._handlers = {
					"resize.owl.carousel": a.proxy(function (a) {
						this._core.settings.video && !this.isInFullScreen() && a.preventDefault()
					}, this),
					"refresh.owl.carousel changed.owl.carousel": a.proxy(function () {
						this._playing && this.stop()
					}, this),
					"prepared.owl.carousel": a.proxy(function (b) {
						var c = a(b.content).find(".owl-video");
						c.length && (c.css("display", "none"),
							this.fetch(c, a(b.content)))
					}, this)
				},
				this._core.options = a.extend({}, d.Defaults, this._core.options),
				this._core.$element.on(this._handlers),
				this._core.$element.on("click.owl.video", ".owl-video-play-icon", a.proxy(function (a) {
					this.play(a)
				}, this))
		};
		d.Defaults = {
			video: !1,
			videoHeight: !1,
			videoWidth: !1
		},
			d.prototype.fetch = function (a, b) {
				var c = a.attr("data-vimeo-id") ? "vimeo" : "youtube"
					, d = a.attr("data-vimeo-id") || a.attr("data-youtube-id")
					, e = a.attr("data-width") || this._core.settings.videoWidth
					, f = a.attr("data-height") || this._core.settings.videoHeight
					, g = a.attr("href");
				if (!g)
					throw new Error("Missing video URL.");
				if (d = g.match(/(http:|https:|)\/\/(player.|www.)?(vimeo\.com|youtu(be\.com|\.be|be\.googleapis\.com))\/(video\/|embed\/|watch\?v=|v\/)?([A-Za-z0-9._%-]*)(\&\S+)?/),
					d[3].indexOf("youtu") > -1)
					c = "youtube";
				else {
					if (!(d[3].indexOf("vimeo") > -1))
						throw new Error("Video URL not supported.");
					c = "vimeo"
				}
				d = d[6],
					this._videos[g] = {
						type: c,
						id: d,
						width: e,
						height: f
					},
					b.attr("data-video", g),
					this.thumbnail(a, this._videos[g])
			}
			,
			d.prototype.thumbnail = function (b, c) {
				var d, e, f, g = c.width && c.height ? 'style="width:' + c.width + "px;height:" + c.height + 'px;"' : "", h = b.find("img"), i = "src", j = "", k = this._core.settings, l = function (a) {
					e = '<div class="owl-video-play-icon"></div>',
						d = k.lazyLoad ? '<div class="owl-video-tn ' + j + '" ' + i + '="' + a + '"></div>' : '<div class="owl-video-tn" style="opacity:1;background-image:url(' + a + ')"></div>',
						b.after(d),
						b.after(e)
				};
				return b.wrap('<div class="owl-video-wrapper"' + g + "></div>"),
					this._core.settings.lazyLoad && (i = "data-src",
						j = "owl-lazy"),
					h.length ? (l(h.attr(i)),
						h.remove(),
						!1) : void ("youtube" === c.type ? (f = "http://img.youtube.com/vi/" + c.id + "/hqdefault.jpg",
							l(f)) : "vimeo" === c.type && a.ajax({
								type: "GET",
								url: "http://vimeo.com/api/v2/video/" + c.id + ".json",
								jsonp: "callback",
								dataType: "jsonp",
								success: function (a) {
									f = a[0].thumbnail_large,
										l(f)
								}
							}))
			}
			,
			d.prototype.stop = function () {
				this._core.trigger("stop", null, "video"),
					this._playing.find(".owl-video-frame").remove(),
					this._playing.removeClass("owl-video-playing"),
					this._playing = null
			}
			,
			d.prototype.play = function (b) {
				this._core.trigger("play", null, "video"),
					this._playing && this.stop();
				var c, d, e = a(b.target || b.srcElement), f = e.closest("." + this._core.settings.itemClass), g = this._videos[f.attr("data-video")], h = g.width || "100%", i = g.height || this._core.$stage.height();
				"youtube" === g.type ? c = '<iframe width="' + h + '" height="' + i + '" src="http://www.youtube.com/embed/' + g.id + "?autoplay=1&v=" + g.id + '" frameborder="0" allowfullscreen></iframe>' : "vimeo" === g.type && (c = '<iframe src="http://player.vimeo.com/video/' + g.id + '?autoplay=1" width="' + h + '" height="' + i + '" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'),
					f.addClass("owl-video-playing"),
					this._playing = f,
					d = a('<div style="height:' + i + "px; width:" + h + 'px" class="owl-video-frame">' + c + "</div>"),
					e.after(d)
			}
			,
			d.prototype.isInFullScreen = function () {
				var d = c.fullscreenElement || c.mozFullScreenElement || c.webkitFullscreenElement;
				return d && a(d).parent().hasClass("owl-video-frame") && (this._core.speed(0),
					this._fullscreen = !0),
					d && this._fullscreen && this._playing ? !1 : this._fullscreen ? (this._fullscreen = !1,
						!1) : this._playing && this._core.state.orientation !== b.orientation ? (this._core.state.orientation = b.orientation,
							!1) : !0
			}
			,
			d.prototype.destroy = function () {
				var a, b;
				this._core.$element.off("click.owl.video");
				for (a in this._handlers)
					this._core.$element.off(a, this._handlers[a]);
				for (b in Object.getOwnPropertyNames(this))
					"function" != typeof this[b] && (this[b] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.Video = d
	}(window.Zepto || window.jQuery, window, document),
	function (a, b, c, d) {
		var e = function (b) {
			this.core = b,
				this.core.options = a.extend({}, e.Defaults, this.core.options),
				this.swapping = !0,
				this.previous = d,
				this.next = d,
				this.handlers = {
					"change.owl.carousel": a.proxy(function (a) {
						"position" == a.property.name && (this.previous = this.core.current(),
							this.next = a.property.value)
					}, this),
					"drag.owl.carousel dragged.owl.carousel translated.owl.carousel": a.proxy(function (a) {
						this.swapping = "translated" == a.type
					}, this),
					"translate.owl.carousel": a.proxy(function () {
						this.swapping && (this.core.options.animateOut || this.core.options.animateIn) && this.swap()
					}, this)
				},
				this.core.$element.on(this.handlers)
		};
		e.Defaults = {
			animateOut: !1,
			animateIn: !1
		},
			e.prototype.swap = function () {
				if (1 === this.core.settings.items && this.core.support3d) {
					this.core.speed(0);
					var b, c = a.proxy(this.clear, this), d = this.core.$stage.children().eq(this.previous), e = this.core.$stage.children().eq(this.next), f = this.core.settings.animateIn, g = this.core.settings.animateOut;
					this.core.current() !== this.previous && (g && (b = this.core.coordinates(this.previous) - this.core.coordinates(this.next),
						d.css({
							left: b + "px"
						}).addClass("animated owl-animated-out").addClass(g).one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend", c)),
						f && e.addClass("animated owl-animated-in").addClass(f).one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend", c))
				}
			}
			,
			e.prototype.clear = function (b) {
				a(b.target).css({
					left: ""
				}).removeClass("animated owl-animated-out owl-animated-in").removeClass(this.core.settings.animateIn).removeClass(this.core.settings.animateOut),
					this.core.transitionEnd()
			}
			,
			e.prototype.destroy = function () {
				var a, b;
				for (a in this.handlers)
					this.core.$element.off(a, this.handlers[a]);
				for (b in Object.getOwnPropertyNames(this))
					"function" != typeof this[b] && (this[b] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.Animate = e
	}(window.Zepto || window.jQuery, window, document),
	function (a, b, c) {
		var d = function (b) {
			this.core = b,
				this.core.options = a.extend({}, d.Defaults, this.core.options),
				this.handlers = {
					"translated.owl.carousel refreshed.owl.carousel": a.proxy(function () {
						this.autoplay()
					}, this),
					"play.owl.autoplay": a.proxy(function (a, b, c) {
						this.play(b, c)
					}, this),
					"stop.owl.autoplay": a.proxy(function () {
						this.stop()
					}, this),
					"mouseover.owl.autoplay": a.proxy(function () {
						this.core.settings.autoplayHoverPause && this.pause()
					}, this),
					"mouseleave.owl.autoplay": a.proxy(function () {
						this.core.settings.autoplayHoverPause && this.autoplay()
					}, this)
				},
				this.core.$element.on(this.handlers)
		};
		d.Defaults = {
			autoplay: !1,
			autoplayTimeout: 5e3,
			autoplayHoverPause: !1,
			autoplaySpeed: !1
		},
			d.prototype.autoplay = function () {
				this.core.settings.autoplay && !this.core.state.videoPlay ? (b.clearInterval(this.interval),
					this.interval = b.setInterval(a.proxy(function () {
						this.play()
					}, this), this.core.settings.autoplayTimeout)) : b.clearInterval(this.interval)
			}
			,
			d.prototype.play = function () {
				return c.hidden === !0 || this.core.state.isTouch || this.core.state.isScrolling || this.core.state.isSwiping || this.core.state.inMotion ? void 0 : this.core.settings.autoplay === !1 ? void b.clearInterval(this.interval) : void this.core.next(this.core.settings.autoplaySpeed)
			}
			,
			d.prototype.stop = function () {
				b.clearInterval(this.interval)
			}
			,
			d.prototype.pause = function () {
				b.clearInterval(this.interval)
			}
			,
			d.prototype.destroy = function () {
				var a, c;
				b.clearInterval(this.interval);
				for (a in this.handlers)
					this.core.$element.off(a, this.handlers[a]);
				for (c in Object.getOwnPropertyNames(this))
					"function" != typeof this[c] && (this[c] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.autoplay = d
	}(window.Zepto || window.jQuery, window, document),
	function (a) {
		"use strict";
		var b = function (c) {
			this._core = c,
				this._initialized = !1,
				this._pages = [],
				this._controls = {},
				this._templates = [],
				this.$element = this._core.$element,
				this._overrides = {
					next: this._core.next,
					prev: this._core.prev,
					to: this._core.to
				},
				this._handlers = {
					"prepared.owl.carousel": a.proxy(function (b) {
						this._core.settings.dotsData && this._templates.push(a(b.content).find("[data-dot]").andSelf("[data-dot]").attr("data-dot"))
					}, this),
					"add.owl.carousel": a.proxy(function (b) {
						this._core.settings.dotsData && this._templates.splice(b.position, 0, a(b.content).find("[data-dot]").andSelf("[data-dot]").attr("data-dot"))
					}, this),
					"remove.owl.carousel prepared.owl.carousel": a.proxy(function (a) {
						this._core.settings.dotsData && this._templates.splice(a.position, 1)
					}, this),
					"change.owl.carousel": a.proxy(function (a) {
						if ("position" == a.property.name && !this._core.state.revert && !this._core.settings.loop && this._core.settings.navRewind) {
							var b = this._core.current()
								, c = this._core.maximum()
								, d = this._core.minimum();
							a.data = a.property.value > c ? b >= c ? d : c : a.property.value < d ? c : a.property.value
						}
					}, this),
					"changed.owl.carousel": a.proxy(function (a) {
						"position" == a.property.name && this.draw()
					}, this),
					"refreshed.owl.carousel": a.proxy(function () {
						this._initialized || (this.initialize(),
							this._initialized = !0),
							this._core.trigger("refresh", null, "navigation"),
							this.update(),
							this.draw(),
							this._core.trigger("refreshed", null, "navigation")
					}, this)
				},
				this._core.options = a.extend({}, b.Defaults, this._core.options),
				this.$element.on(this._handlers)
		};
		b.Defaults = {
			nav: !1,
			navRewind: !0,
			navText: ["prev", "next"],
			navSpeed: !1,
			navElement: "div",
			navContainer: !1,
			navContainerClass: "owl-nav",
			navClass: ["owl-prev", "owl-next"],
			slideBy: 1,
			dotClass: "owl-dot",
			dotsClass: "owl-dots",
			dots: !0,
			dotsEach: !1,
			dotData: !1,
			dotsSpeed: !1,
			dotsContainer: !1,
			controlsClass: "owl-controls"
		},
			b.prototype.initialize = function () {
				var b, c, d = this._core.settings;
				d.dotsData || (this._templates = [a("<div>").addClass(d.dotClass).append(a("<span>")).prop("outerHTML")]),
					d.navContainer && d.dotsContainer || (this._controls.$container = a("<div>").addClass(d.controlsClass).appendTo(this.$element)),
					this._controls.$indicators = d.dotsContainer ? a(d.dotsContainer) : a("<div>").hide().addClass(d.dotsClass).appendTo(this._controls.$container),
					this._controls.$indicators.on("click", "div", a.proxy(function (b) {
						var c = a(b.target).parent().is(this._controls.$indicators) ? a(b.target).index() : a(b.target).parent().index();
						b.preventDefault(),
							this.to(c, d.dotsSpeed)
					}, this)),
					b = d.navContainer ? a(d.navContainer) : a("<div>").addClass(d.navContainerClass).prependTo(this._controls.$container),
					this._controls.$next = a("<" + d.navElement + ">"),
					this._controls.$previous = this._controls.$next.clone(),
					this._controls.$previous.addClass(d.navClass[0]).html(d.navText[0]).hide().prependTo(b).on("click", a.proxy(function () {
						this.prev(d.navSpeed)
					}, this)),
					this._controls.$next.addClass(d.navClass[1]).html(d.navText[1]).hide().appendTo(b).on("click", a.proxy(function () {
						this.next(d.navSpeed)
					}, this));
				for (c in this._overrides)
					this._core[c] = a.proxy(this[c], this)
			}
			,
			b.prototype.destroy = function () {
				var a, b, c, d;
				for (a in this._handlers)
					this.$element.off(a, this._handlers[a]);
				for (b in this._controls)
					this._controls[b].remove();
				for (d in this.overides)
					this._core[d] = this._overrides[d];
				for (c in Object.getOwnPropertyNames(this))
					"function" != typeof this[c] && (this[c] = null)
			}
			,
			b.prototype.update = function () {
				var a, b, c, d = this._core.settings, e = this._core.clones().length / 2, f = e + this._core.items().length, g = d.center || d.autoWidth || d.dotData ? 1 : d.dotsEach || d.items;
				if ("page" !== d.slideBy && (d.slideBy = Math.min(d.slideBy, d.items)),
					d.dots || "page" == d.slideBy)
					for (this._pages = [],
						a = e,
						b = 0,
						c = 0; f > a; a++)
						(b >= g || 0 === b) && (this._pages.push({
							start: a - e,
							end: a - e + g - 1
						}),
							b = 0,
							++c),
							b += this._core.mergers(this._core.relative(a))
			}
			,
			b.prototype.draw = function () {
				var b, c, d = "", e = this._core.settings, f = (this._core.$stage.children(),
					this._core.relative(this._core.current()));
				if (!e.nav || e.loop || e.navRewind || (this._controls.$previous.toggleClass("disabled", 0 >= f),
					this._controls.$next.toggleClass("disabled", f >= this._core.maximum())),
					this._controls.$previous.toggle(e.nav),
					this._controls.$next.toggle(e.nav),
					e.dots) {
					if (b = this._pages.length - this._controls.$indicators.children().length,
						e.dotData && 0 !== b) {
						for (c = 0; c < this._controls.$indicators.children().length; c++)
							d += this._templates[this._core.relative(c)];
						this._controls.$indicators.html(d)
					} else
						b > 0 ? (d = new Array(b + 1).join(this._templates[0]),
							this._controls.$indicators.append(d)) : 0 > b && this._controls.$indicators.children().slice(b).remove();
					this._controls.$indicators.find(".active").removeClass("active"),
						this._controls.$indicators.children().eq(a.inArray(this.current(), this._pages)).addClass("active")
				}
				this._controls.$indicators.toggle(e.dots)
			}
			,
			b.prototype.onTrigger = function (b) {
				var c = this._core.settings;
				b.page = {
					index: a.inArray(this.current(), this._pages),
					count: this._pages.length,
					size: c && (c.center || c.autoWidth || c.dotData ? 1 : c.dotsEach || c.items)
				}
			}
			,
			b.prototype.current = function () {
				var b = this._core.relative(this._core.current());
				return a.grep(this._pages, function (a) {
					return a.start <= b && a.end >= b
				}).pop()
			}
			,
			b.prototype.getPosition = function (b) {
				var c, d, e = this._core.settings;
				return "page" == e.slideBy ? (c = a.inArray(this.current(), this._pages),
					d = this._pages.length,
					b ? ++c : --c,
					c = this._pages[(c % d + d) % d].start) : (c = this._core.relative(this._core.current()),
						d = this._core.items().length,
						b ? c += e.slideBy : c -= e.slideBy),
					c
			}
			,
			b.prototype.next = function (b) {
				a.proxy(this._overrides.to, this._core)(this.getPosition(!0), b)
			}
			,
			b.prototype.prev = function (b) {
				a.proxy(this._overrides.to, this._core)(this.getPosition(!1), b)
			}
			,
			b.prototype.to = function (b, c, d) {
				var e;
				d ? a.proxy(this._overrides.to, this._core)(b, c) : (e = this._pages.length,
					a.proxy(this._overrides.to, this._core)(this._pages[(b % e + e) % e].start, c))
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.Navigation = b
	}(window.Zepto || window.jQuery, window, document),
	function (a, b) {
		"use strict";
		var c = function (d) {
			this._core = d,
				this._hashes = {},
				this.$element = this._core.$element,
				this._handlers = {
					"initialized.owl.carousel": a.proxy(function () {
						"URLHash" == this._core.settings.startPosition && a(b).trigger("hashchange.owl.navigation")
					}, this),
					"prepared.owl.carousel": a.proxy(function (b) {
						var c = a(b.content).find("[data-hash]").andSelf("[data-hash]").attr("data-hash");
						this._hashes[c] = b.content
					}, this)
				},
				this._core.options = a.extend({}, c.Defaults, this._core.options),
				this.$element.on(this._handlers),
				a(b).on("hashchange.owl.navigation", a.proxy(function () {
					var a = b.location.hash.substring(1)
						, c = this._core.$stage.children()
						, d = this._hashes[a] && c.index(this._hashes[a]) || 0;
					return a ? void this._core.to(d, !1, !0) : !1
				}, this))
		};
		c.Defaults = {
			URLhashListener: !1
		},
			c.prototype.destroy = function () {
				var c, d;
				a(b).off("hashchange.owl.navigation");
				for (c in this._handlers)
					this._core.$element.off(c, this._handlers[c]);
				for (d in Object.getOwnPropertyNames(this))
					"function" != typeof this[d] && (this[d] = null)
			}
			,
			a.fn.owlCarousel.Constructor.Plugins.Hash = c
	}(window.Zepto || window.jQuery, window, document);
(function ($) {
	$.fn.jflickrfeed = function (settings, callback) {
		settings = $.extend(true, {
			flickrbase: 'http://api.flickr.com/services/feeds/',
			feedapi: 'photos_public.gne',
			limit: 20,
			qstrings: {
				lang: 'en-us',
				format: 'json',
				jsoncallback: '?'
			},
			cleanDescription: true,
			useTemplate: true,
			itemTemplate: '<li><a href="{{image_b}}" title="{{title}}"><span class="thumbnail"><img src="{{image_s}}" /></span></a></li>',
			itemCallback: function () { }
		}, settings);
		var url = settings.flickrbase + settings.feedapi + '?';
		var first = true;
		for (var key in settings.qstrings) {
			if (!first)
				url += '&';
			url += key + '=' + settings.qstrings[key];
			first = false
		}
		return $(this).each(function () {
			var $container = $(this);
			var container = this;
			$.getJSON(url, function (data) {
				$.each(data.items, function (i, item) {
					if (i < settings.limit) {
						if (settings.cleanDescription) {
							var regex = /<p>(.*?)<\/p>/g;
							var input = item.description;
							if (regex.test(input)) {
								item.description = input.match(regex)[2];
								if (item.description != undefined)
									item.description = item.description.replace('<p>', '').replace('</p>', '')
							}
						}
						item['image_s'] = item.media.m.replace('_m', '_s');
						item['image_t'] = item.media.m.replace('_m', '_t');
						item['image_m'] = item.media.m.replace('_m', '_m');
						item['image'] = item.media.m.replace('_m', '');
						item['image_b'] = item.media.m.replace('_m', '_b');
						delete item.media;
						if (settings.useTemplate) {
							var template = settings.itemTemplate;
							for (var key in item) {
								template = template.replace('{{' + key + '}}', item[key])
							}
							$container.append(template)
						}
						settings.itemCallback.call(container, item)
					}
				});
				if ($.isFunction(callback)) {
					callback.call(container, data)
				}
			})
		})
	}
})(jQuery);
; (function ($, window, undefined) {
	'use strict';
	var BLANK = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==';
	$.fn.imagesLoaded = function (callback) {
		var $this = this
			, deferred = $.isFunction($.Deferred) ? $.Deferred() : 0
			, hasNotify = $.isFunction(deferred.notify)
			, $images = $this.find('img').add($this.filter('img'))
			, loaded = []
			, proper = []
			, broken = [];
		if ($.isPlainObject(callback)) {
			$.each(callback, function (key, value) {
				if (key === 'callback') {
					callback = value
				} else if (deferred) {
					deferred[key](value)
				}
			})
		}
		function doneLoading() {
			var $proper = $(proper)
				, $broken = $(broken);
			if (deferred) {
				if (broken.length) {
					deferred.reject($images, $proper, $broken)
				} else {
					deferred.resolve($images)
				}
			}
			if ($.isFunction(callback)) {
				callback.call($this, $images, $proper, $broken)
			}
		}
		function imgLoadedHandler(event) {
			imgLoaded(event.target, event.type === 'error')
		}
		function imgLoaded(img, isBroken) {
			if (img.src === BLANK || $.inArray(img, loaded) !== -1) {
				return
			}
			loaded.push(img);
			if (isBroken) {
				broken.push(img)
			} else {
				proper.push(img)
			}
			$.data(img, 'imagesLoaded', {
				isBroken: isBroken,
				src: img.src
			});
			if (hasNotify) {
				deferred.notifyWith($(img), [isBroken, $images, $(proper), $(broken)])
			}
			if ($images.length === loaded.length) {
				setTimeout(doneLoading);
				$images.unbind('.imagesLoaded', imgLoadedHandler)
			}
		}
		if (!$images.length) {
			doneLoading()
		} else {
			$images.bind('load.imagesLoaded error.imagesLoaded', imgLoadedHandler).each(function (i, el) {
				var src = el.src;
				var cached = $.data(el, 'imagesLoaded');
				if (cached && cached.src === src) {
					imgLoaded(el, cached.isBroken);
					return
				}
				if (el.complete && el.naturalWidth !== undefined) {
					imgLoaded(el, el.naturalWidth === 0 || el.naturalHeight === 0);
					return
				}
				if (el.readyState || el.complete) {
					el.src = BLANK;
					el.src = src
				}
			})
		}
		return deferred ? deferred.promise($this) : $this
	}
		;
	var Modernizr = window.Modernizr;
	$.Flipshow = function (options, element) {
		this.$el = $(element);
		this._init(options)
	}
		;
	$.Flipshow.defaults = {
		speed: 700,
		easing: 'ease-out'
	};
	$.Flipshow.prototype = {
		_init: function (options) {
			this.options = $.extend(true, {}, $.Flipshow.defaults, options);
			this.support = Modernizr.csstransitions && Modernizr.csstransforms3d && !(/MSIE (\d+\.\d+);/.test(navigator.userAgent));
			var transEndEventNames = {
				'WebkitTransition': 'webkitTransitionEnd',
				'MozTransition': 'transitionend',
				'OTransition': 'oTransitionEnd',
				'msTransition': 'MSTransitionEnd',
				'transition': 'transitionend'
			}
				, transformNames = {
					'WebkitTransform': '-webkit-transform',
					'MozTransform': '-moz-transform',
					'OTransform': '-o-transform',
					'msTransform': '-ms-transform',
					'transform': 'transform'
				};
			if (this.support) {
				this.transEndEventName = transEndEventNames[Modernizr.prefixed('transition')] + '.cbpFWSlider';
				this.transformName = transformNames[Modernizr.prefixed('transform')]
			}
			this.transitionProperties = this.transformName + ' ' + this.options.speed + 'ms ' + this.options.easing;
			this.$listItems = this.$el.children('ul.fc-slides');
			this.$items = this.$listItems.children('li').hide();
			this.itemsCount = this.$items.length;
			this.current = 0;
			this.$listItems.imagesLoaded($.proxy(function () {
				this.$items.eq(this.current).show();
				if (this.itemsCount > 0) {
					this._addNav();
					if (this.support) {
						this._layout()
					}
				}
			}, this))
		},
		_addNav: function () {
			var self = this
				, $navLeft = $('<div class="fc-left"><span></span><span></span><span></span><i class="fa fa-arrow-left"></i></div>')
				, $navRight = $('<div class="fc-right"><span></span><span></span><span></span><i class="fa fa-arrow-right"></i></div>');
			$('<nav></nav>').append($navLeft, $navRight).appendTo(this.$el);
			$navLeft.find('span').on('click.flipshow touchstart.flipshow', function () {
				self._navigate($(this), 'left')
			});
			$navRight.find('span').on('click.flipshow touchstart.flipshow', function () {
				self._navigate($(this), 'right')
			})
		},
		_layout: function ($current, $next) {
			this.$flipFront = $('<div class="fc-front"><div></div></div>');
			this.$frontContent = this.$flipFront.children('div:first');
			this.$flipBack = $('<div class="fc-back"><div></div></div>');
			this.$backContent = this.$flipBack.children('div:first');
			this.$flipEl = $('<div class="fc-flip"></div>').append(this.$flipFront, this.$flipBack).hide().appendTo(this.$el)
		},
		_navigate: function ($nav, dir) {
			if (this.isAnimating && this.support) {
				return false
			}
			this.isAnimating = true;
			var $currentItem = this.$items.eq(this.current).hide();
			if (dir === 'right') {
				this.current < this.itemsCount - 1 ? ++this.current : this.current = 0
			} else if (dir === 'left') {
				this.current > 0 ? --this.current : this.current = this.itemsCount - 1
			}
			var $nextItem = this.$items.eq(this.current);
			if (this.support) {
				this._flip($currentItem, $nextItem, dir, $nav.index())
			} else {
				$nextItem.show()
			}
		},
		_flip: function ($currentItem, $nextItem, dir, angle) {
			var transformProperties = ''
				, $overlayLight = $('<div class="fc-overlay-light"></div>')
				, $overlayDark = $('<div class="fc-overlay-dark"></div>');
			this.$flipEl.css('transition', this.transitionProperties);
			this.$flipFront.find('div.fc-overlay-light, div.fc-overlay-dark').remove();
			this.$flipBack.find('div.fc-overlay-light, div.fc-overlay-dark').remove();
			if (dir === 'right') {
				this.$flipFront.append($overlayLight);
				this.$flipBack.append($overlayDark);
				$overlayDark.css('opacity', 1)
			} else if (dir === 'left') {
				this.$flipFront.append($overlayDark);
				this.$flipBack.append($overlayLight);
				$overlayLight.css('opacity', 1)
			}
			var overlayStyle = {
				transition: 'opacity ' + (this.options.speed / 1.3) + 'ms'
			};
			$overlayLight.css(overlayStyle);
			$overlayDark.css(overlayStyle);
			switch (angle) {
				case 0:
					transformProperties = dir === 'left' ? 'rotate3d(-1,1,0,-179deg) rotate3d(-1,1,0,-1deg)' : 'rotate3d(1,1,0,180deg)';
					break;
				case 1:
					transformProperties = dir === 'left' ? 'rotate3d(0,1,0,-179deg) rotate3d(0,1,0,-1deg)' : 'rotate3d(0,1,0,180deg)';
					break;
				case 2:
					transformProperties = dir === 'left' ? 'rotate3d(1,1,0,-179deg) rotate3d(1,1,0,-1deg)' : 'rotate3d(-1,1,0,179deg) rotate3d(-1,1,0,1deg)';
					break
			}
			this.$flipBack.css('transform', transformProperties);
			this.$frontContent.empty().html($currentItem.html());
			this.$backContent.empty().html($nextItem.html());
			this.$flipEl.show();
			var self = this;
			setTimeout(function () {
				self.$flipEl.css('transform', transformProperties);
				$overlayLight.css('opacity', dir === 'right' ? 1 : 0);
				$overlayDark.css('opacity', dir === 'right' ? 0 : 1);
				self.$flipEl.on(self.transEndEventName, function (event) {
					if (event.target.className === 'fc-overlay-light' || event.target.className === 'fc-overlay-dark')
						return;
					self._ontransitionend($nextItem)
				})
			}, 25)
		},
		_ontransitionend: function ($nextItem) {
			$nextItem.show();
			this.$flipEl.off(this.transEndEventName).css({
				transition: 'none',
				transform: 'none'
			}).hide();
			this.isAnimating = false
		}
	};
	var logError = function (message) {
		if (window.console) {
			window.console.error(message)
		}
	};
	$.fn.flipshow = function (options) {
		if (typeof options === 'string') {
			var args = Array.prototype.slice.call(arguments, 1);
			this.each(function () {
				var instance = $.data(this, 'flipshow');
				if (!instance) {
					logError("cannot call methods on flipshow prior to initialization; " + "attempted to call method '" + options + "'");
					return
				}
				if (!$.isFunction(instance[options]) || options.charAt(0) === "_") {
					logError("no such method '" + options + "' for flipshow instance");
					return
				}
				instance[options].apply(instance, args)
			})
		} else {
			this.each(function () {
				var instance = $.data(this, 'flipshow');
				if (instance) {
					instance._init()
				} else {
					instance = $.data(this, 'flipshow', new $.Flipshow(options, this))
				}
			})
		}
		return this
	}
})(jQuery, window);
