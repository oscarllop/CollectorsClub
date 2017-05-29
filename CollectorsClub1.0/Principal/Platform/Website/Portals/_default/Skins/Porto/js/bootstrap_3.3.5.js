/*!
 * Bootstrap v3.3.5 (http://getbootstrap.com)
 * Copyright 2011-2015 Twitter, Inc.
 * Licensed under the MIT license
 */
if ("undefined" == typeof jQuery)
	throw new Error("Bootstrap's JavaScript requires jQuery");
+function (a) {
	"use strict";
	var b = a.fn.jquery.split(" ")[0].split(".");
	if (b[0] < 2 && b[1] < 9 || 1 == b[0] && 9 == b[1] && b[2] < 1)
		throw new Error("Bootstrap's JavaScript requires jQuery version 1.9.1 or higher")
}(jQuery),
	+function (a) {
		"use strict";
		function b() {
			var a = document.createElement("bootstrap")
				, b = {
					WebkitTransition: "webkitTransitionEnd",
					MozTransition: "transitionend",
					OTransition: "oTransitionEnd otransitionend",
					transition: "transitionend"
				};
			for (var c in b)
				if (void 0 !== a.style[c])
					return {
						end: b[c]
					};
			return !1
		}
		a.fn.emulateTransitionEnd = function (b) {
			var c = !1
				, d = this;
			a(this).one("bsTransitionEnd", function () {
				c = !0
			});
			var e = function () {
				c || a(d).trigger(a.support.transition.end)
			};
			return setTimeout(e, b),
				this
		}
			,
			a(function () {
				a.support.transition = b(),
					a.support.transition && (a.event.special.bsTransitionEnd = {
						bindType: a.support.transition.end,
						delegateType: a.support.transition.end,
						handle: function (b) {
							return a(b.target).is(this) ? b.handleObj.handler.apply(this, arguments) : void 0
						}
					})
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var c = a(this)
					, e = c.data("bs.alert");
				e || c.data("bs.alert", e = new d(this)),
					"string" == typeof b && e[b].call(c)
			})
		}
		var c = '[data-dismiss="alert"]'
			, d = function (b) {
				a(b).on("click", c, this.close)
			};
		d.VERSION = "3.3.5",
			d.TRANSITION_DURATION = 150,
			d.prototype.close = function (b) {
				function c() {
					g.detach().trigger("closed.bs.alert").remove()
				}
				var e = a(this)
					, f = e.attr("data-target");
				f || (f = e.attr("href"),
					f = f && f.replace(/.*(?=#[^\s]*$)/, ""));
				var g = a(f);
				b && b.preventDefault(),
					g.length || (g = e.closest(".alert")),
					g.trigger(b = a.Event("close.bs.alert")),
					b.isDefaultPrevented() || (g.removeClass("in"),
						a.support.transition && g.hasClass("fade") ? g.one("bsTransitionEnd", c).emulateTransitionEnd(d.TRANSITION_DURATION) : c())
			}
			;
		var e = a.fn.alert;
		a.fn.alert = b,
			a.fn.alert.Constructor = d,
			a.fn.alert.noConflict = function () {
				return a.fn.alert = e,
					this
			}
			,
			a(document).on("click.bs.alert.data-api", c, d.prototype.close)
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.button")
					, f = "object" == typeof b && b;
				e || d.data("bs.button", e = new c(this, f)),
					"toggle" == b ? e.toggle() : b && e.setState(b)
			})
		}
		var c = function (b, d) {
			this.$element = a(b),
				this.options = a.extend({}, c.DEFAULTS, d),
				this.isLoading = !1
		};
		c.VERSION = "3.3.5",
			c.DEFAULTS = {
				loadingText: "loading..."
			},
			c.prototype.setState = function (b) {
				var c = "disabled"
					, d = this.$element
					, e = d.is("input") ? "val" : "html"
					, f = d.data();
				b += "Text",
					null == f.resetText && d.data("resetText", d[e]()),
					setTimeout(a.proxy(function () {
						d[e](null == f[b] ? this.options[b] : f[b]),
							"loadingText" == b ? (this.isLoading = !0,
								d.addClass(c).attr(c, c)) : this.isLoading && (this.isLoading = !1,
									d.removeClass(c).removeAttr(c))
					}, this), 0)
			}
			,
			c.prototype.toggle = function () {
				var a = !0
					, b = this.$element.closest('[data-toggle="buttons"]');
				if (b.length) {
					var c = this.$element.find("input");
					"radio" == c.prop("type") ? (c.prop("checked") && (a = !1),
						b.find(".active").removeClass("active"),
						this.$element.addClass("active")) : "checkbox" == c.prop("type") && (c.prop("checked") !== this.$element.hasClass("active") && (a = !1),
							this.$element.toggleClass("active")),
						c.prop("checked", this.$element.hasClass("active")),
						a && c.trigger("change")
				} else
					this.$element.attr("aria-pressed", !this.$element.hasClass("active")),
						this.$element.toggleClass("active")
			}
			;
		var d = a.fn.button;
		a.fn.button = b,
			a.fn.button.Constructor = c,
			a.fn.button.noConflict = function () {
				return a.fn.button = d,
					this
			}
			,
			a(document).on("click.bs.button.data-api", '[data-toggle^="button"]', function (c) {
				var d = a(c.target);
				d.hasClass("btn") || (d = d.closest(".btn")),
					b.call(d, "toggle"),
					a(c.target).is('input[type="radio"]') || a(c.target).is('input[type="checkbox"]') || c.preventDefault()
			}).on("focus.bs.button.data-api blur.bs.button.data-api", '[data-toggle^="button"]', function (b) {
				a(b.target).closest(".btn").toggleClass("focus", /^focus(in)?$/.test(b.type))
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.carousel")
					, f = a.extend({}, c.DEFAULTS, d.data(), "object" == typeof b && b)
					, g = "string" == typeof b ? b : f.slide;
				e || d.data("bs.carousel", e = new c(this, f)),
					"number" == typeof b ? e.to(b) : g ? e[g]() : f.interval && e.pause().cycle()
			})
		}
		var c = function (b, c) {
			this.$element = a(b),
				this.$indicators = this.$element.find(".carousel-indicators"),
				this.options = c,
				this.paused = null,
				this.sliding = null,
				this.interval = null,
				this.$active = null,
				this.$items = null,
				this.options.keyboard && this.$element.on("keydown.bs.carousel", a.proxy(this.keydown, this)),
				"hover" == this.options.pause && !("ontouchstart" in document.documentElement) && this.$element.on("mouseenter.bs.carousel", a.proxy(this.pause, this)).on("mouseleave.bs.carousel", a.proxy(this.cycle, this))
		};
		c.VERSION = "3.3.5",
			c.TRANSITION_DURATION = 600,
			c.DEFAULTS = {
				interval: 5e3,
				pause: "hover",
				wrap: !0,
				keyboard: !0
			},
			c.prototype.keydown = function (a) {
				if (!/input|textarea/i.test(a.target.tagName)) {
					switch (a.which) {
						case 37:
							this.prev();
							break;
						case 39:
							this.next();
							break;
						default:
							return
					}
					a.preventDefault()
				}
			}
			,
			c.prototype.cycle = function (b) {
				return b || (this.paused = !1),
					this.interval && clearInterval(this.interval),
					this.options.interval && !this.paused && (this.interval = setInterval(a.proxy(this.next, this), this.options.interval)),
					this
			}
			,
			c.prototype.getItemIndex = function (a) {
				return this.$items = a.parent().children(".item"),
					this.$items.index(a || this.$active)
			}
			,
			c.prototype.getItemForDirection = function (a, b) {
				var c = this.getItemIndex(b)
					, d = "prev" == a && 0 === c || "next" == a && c == this.$items.length - 1;
				if (d && !this.options.wrap)
					return b;
				var e = "prev" == a ? -1 : 1
					, f = (c + e) % this.$items.length;
				return this.$items.eq(f)
			}
			,
			c.prototype.to = function (a) {
				var b = this
					, c = this.getItemIndex(this.$active = this.$element.find(".item.active"));
				return a > this.$items.length - 1 || 0 > a ? void 0 : this.sliding ? this.$element.one("slid.bs.carousel", function () {
					b.to(a)
				}) : c == a ? this.pause().cycle() : this.slide(a > c ? "next" : "prev", this.$items.eq(a))
			}
			,
			c.prototype.pause = function (b) {
				return b || (this.paused = !0),
					this.$element.find(".next, .prev").length && a.support.transition && (this.$element.trigger(a.support.transition.end),
						this.cycle(!0)),
					this.interval = clearInterval(this.interval),
					this
			}
			,
			c.prototype.next = function () {
				return this.sliding ? void 0 : this.slide("next")
			}
			,
			c.prototype.prev = function () {
				return this.sliding ? void 0 : this.slide("prev")
			}
			,
			c.prototype.slide = function (b, d) {
				var e = this.$element.find(".item.active")
					, f = d || this.getItemForDirection(b, e)
					, g = this.interval
					, h = "next" == b ? "left" : "right"
					, i = this;
				if (f.hasClass("active"))
					return this.sliding = !1;
				var j = f[0]
					, k = a.Event("slide.bs.carousel", {
						relatedTarget: j,
						direction: h
					});
				if (this.$element.trigger(k),
					!k.isDefaultPrevented()) {
					if (this.sliding = !0,
						g && this.pause(),
						this.$indicators.length) {
						this.$indicators.find(".active").removeClass("active");
						var l = a(this.$indicators.children()[this.getItemIndex(f)]);
						l && l.addClass("active")
					}
					var m = a.Event("slid.bs.carousel", {
						relatedTarget: j,
						direction: h
					});
					return a.support.transition && this.$element.hasClass("slide") ? (f.addClass(b),
						f[0].offsetWidth,
						e.addClass(h),
						f.addClass(h),
						e.one("bsTransitionEnd", function () {
							f.removeClass([b, h].join(" ")).addClass("active"),
								e.removeClass(["active", h].join(" ")),
								i.sliding = !1,
								setTimeout(function () {
									i.$element.trigger(m)
								}, 0)
						}).emulateTransitionEnd(c.TRANSITION_DURATION)) : (e.removeClass("active"),
							f.addClass("active"),
							this.sliding = !1,
							this.$element.trigger(m)),
						g && this.cycle(),
						this
				}
			}
			;
		var d = a.fn.carousel;
		a.fn.carousel = b,
			a.fn.carousel.Constructor = c,
			a.fn.carousel.noConflict = function () {
				return a.fn.carousel = d,
					this
			}
			;
		var e = function (c) {
			var d, e = a(this), f = a(e.attr("data-target") || (d = e.attr("href")) && d.replace(/.*(?=#[^\s]+$)/, ""));
			if (f.hasClass("carousel")) {
				var g = a.extend({}, f.data(), e.data())
					, h = e.attr("data-slide-to");
				h && (g.interval = !1),
					b.call(f, g),
					h && f.data("bs.carousel").to(h),
					c.preventDefault()
			}
		};
		a(document).on("click.bs.carousel.data-api", "[data-slide]", e).on("click.bs.carousel.data-api", "[data-slide-to]", e),
			a(window).on("load", function () {
				a('[data-ride="carousel"]').each(function () {
					var c = a(this);
					b.call(c, c.data())
				})
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			var c, d = b.attr("data-target") || (c = b.attr("href")) && c.replace(/.*(?=#[^\s]+$)/, "");
			return a(d)
		}
		function c(b) {
			return this.each(function () {
				var c = a(this)
					, e = c.data("bs.collapse")
					, f = a.extend({}, d.DEFAULTS, c.data(), "object" == typeof b && b);
				!e && f.toggle && /show|hide/.test(b) && (f.toggle = !1),
					e || c.data("bs.collapse", e = new d(this, f)),
					"string" == typeof b && e[b]()
			})
		}
		var d = function (b, c) {
			this.$element = a(b),
				this.options = a.extend({}, d.DEFAULTS, c),
				this.$trigger = a('[data-toggle="collapse"][href="#' + b.id + '"],[data-toggle="collapse"][data-target="#' + b.id + '"]'),
				this.transitioning = null,
				this.options.parent ? this.$parent = this.getParent() : this.addAriaAndCollapsedClass(this.$element, this.$trigger),
				this.options.toggle && this.toggle()
		};
		d.VERSION = "3.3.5",
			d.TRANSITION_DURATION = 350,
			d.DEFAULTS = {
				toggle: !0
			},
			d.prototype.dimension = function () {
				var a = this.$element.hasClass("width");
				return a ? "width" : "height"
			}
			,
			d.prototype.show = function () {
				if (!this.transitioning && !this.$element.hasClass("in")) {
					var b, e = this.$parent && this.$parent.children(".panel").children(".in, .collapsing");
					if (!(e && e.length && (b = e.data("bs.collapse"),
						b && b.transitioning))) {
						var f = a.Event("show.bs.collapse");
						if (this.$element.trigger(f),
							!f.isDefaultPrevented()) {
							e && e.length && (c.call(e, "hide"),
								b || e.data("bs.collapse", null));
							var g = this.dimension();
							this.$element.removeClass("collapse").addClass("collapsing")[g](0).attr("aria-expanded", !0),
								this.$trigger.removeClass("collapsed").attr("aria-expanded", !0),
								this.transitioning = 1;
							var h = function () {
								this.$element.removeClass("collapsing").addClass("collapse in")[g](""),
									this.transitioning = 0,
									this.$element.trigger("shown.bs.collapse")
							};
							if (!a.support.transition)
								return h.call(this);
							var i = a.camelCase(["scroll", g].join("-"));
							this.$element.one("bsTransitionEnd", a.proxy(h, this)).emulateTransitionEnd(d.TRANSITION_DURATION)[g](this.$element[0][i])
						}
					}
				}
			}
			,
			d.prototype.hide = function () {
				if (!this.transitioning && this.$element.hasClass("in")) {
					var b = a.Event("hide.bs.collapse");
					if (this.$element.trigger(b),
						!b.isDefaultPrevented()) {
						var c = this.dimension();
						this.$element[c](this.$element[c]())[0].offsetHeight,
							this.$element.addClass("collapsing").removeClass("collapse in").attr("aria-expanded", !1),
							this.$trigger.addClass("collapsed").attr("aria-expanded", !1),
							this.transitioning = 1;
						var e = function () {
							this.transitioning = 0,
								this.$element.removeClass("collapsing").addClass("collapse").trigger("hidden.bs.collapse")
						};
						return a.support.transition ? void this.$element[c](0).one("bsTransitionEnd", a.proxy(e, this)).emulateTransitionEnd(d.TRANSITION_DURATION) : e.call(this)
					}
				}
			}
			,
			d.prototype.toggle = function () {
				this[this.$element.hasClass("in") ? "hide" : "show"]()
			}
			,
			d.prototype.getParent = function () {
				return a(this.options.parent).find('[data-toggle="collapse"][data-parent="' + this.options.parent + '"]').each(a.proxy(function (c, d) {
					var e = a(d);
					this.addAriaAndCollapsedClass(b(e), e)
				}, this)).end()
			}
			,
			d.prototype.addAriaAndCollapsedClass = function (a, b) {
				var c = a.hasClass("in");
				a.attr("aria-expanded", c),
					b.toggleClass("collapsed", !c).attr("aria-expanded", c)
			}
			;
		var e = a.fn.collapse;
		a.fn.collapse = c,
			a.fn.collapse.Constructor = d,
			a.fn.collapse.noConflict = function () {
				return a.fn.collapse = e,
					this
			}
			,
			a(document).on("click.bs.collapse.data-api", '[data-toggle="collapse"]', function (d) {
				var e = a(this);
				e.attr("data-target") || d.preventDefault();
				var f = b(e)
					, g = f.data("bs.collapse")
					, h = g ? "toggle" : e.data();
				c.call(f, h)
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			var c = b.attr("data-target");
			c || (c = b.attr("href"),
				c = c && /#[A-Za-z]/.test(c) && c.replace(/.*(?=#[^\s]*$)/, ""));
			var d = c && a(c);
			return d && d.length ? d : b.parent()
		}
		function c(c) {
			c && 3 === c.which || (a(e).remove(),
				a(f).each(function () {
					var d = a(this)
						, e = b(d)
						, f = {
							relatedTarget: this
						};
					e.hasClass("open") && (c && "click" == c.type && /input|textarea/i.test(c.target.tagName) && a.contains(e[0], c.target) || (e.trigger(c = a.Event("hide.bs.dropdown", f)),
						c.isDefaultPrevented() || (d.attr("aria-expanded", "false"),
							e.removeClass("open").trigger("hidden.bs.dropdown", f))))
				}))
		}
		function d(b) {
			return this.each(function () {
				var c = a(this)
					, d = c.data("bs.dropdown");
				d || c.data("bs.dropdown", d = new g(this)),
					"string" == typeof b && d[b].call(c)
			})
		}
		var e = ".dropdown-backdrop"
			, f = '[data-toggle="dropdown"]'
			, g = function (b) {
				a(b).on("click.bs.dropdown", this.toggle)
			};
		g.VERSION = "3.3.5",
			g.prototype.toggle = function (d) {
				var e = a(this);
				if (!e.is(".disabled, :disabled")) {
					var f = b(e)
						, g = f.hasClass("open");
					if (c(),
						!g) {
						"ontouchstart" in document.documentElement && !f.closest(".navbar-nav").length && a(document.createElement("div")).addClass("dropdown-backdrop").insertAfter(a(this)).on("click", c);
						var h = {
							relatedTarget: this
						};
						if (f.trigger(d = a.Event("show.bs.dropdown", h)),
							d.isDefaultPrevented())
							return;
						e.trigger("focus").attr("aria-expanded", "true"),
							f.toggleClass("open").trigger("shown.bs.dropdown", h)
					}
					return !1
				}
			}
			,
			g.prototype.keydown = function (c) {
				if (/(38|40|27|32)/.test(c.which) && !/input|textarea/i.test(c.target.tagName)) {
					var d = a(this);
					if (c.preventDefault(),
						c.stopPropagation(),
						!d.is(".disabled, :disabled")) {
						var e = b(d)
							, g = e.hasClass("open");
						if (!g && 27 != c.which || g && 27 == c.which)
							return 27 == c.which && e.find(f).trigger("focus"),
								d.trigger("click");
						var h = " li:not(.disabled):visible a"
							, i = e.find(".dropdown-menu" + h);
						if (i.length) {
							var j = i.index(c.target);
							38 == c.which && j > 0 && j-- ,
								40 == c.which && j < i.length - 1 && j++ ,
								~j || (j = 0),
								i.eq(j).trigger("focus")
						}
					}
				}
			}
			;
		var h = a.fn.dropdown;
		a.fn.dropdown = d,
			a.fn.dropdown.Constructor = g,
			a.fn.dropdown.noConflict = function () {
				return a.fn.dropdown = h,
					this
			}
			,
			a(document).on("click.bs.dropdown.data-api", c).on("click.bs.dropdown.data-api", ".dropdown form", function (a) {
				a.stopPropagation()
			}).on("click.bs.dropdown.data-api", f, g.prototype.toggle).on("keydown.bs.dropdown.data-api", f, g.prototype.keydown).on("keydown.bs.dropdown.data-api", ".dropdown-menu", g.prototype.keydown)
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b, d) {
			return this.each(function () {
				var e = a(this)
					, f = e.data("bs.modal")
					, g = a.extend({}, c.DEFAULTS, e.data(), "object" == typeof b && b);
				f || e.data("bs.modal", f = new c(this, g)),
					"string" == typeof b ? f[b](d) : g.show && f.show(d)
			})
		}
		var c = function (b, c) {
			this.options = c,
				this.$body = a(document.body),
				this.$element = a(b),
				this.$dialog = this.$element.find(".modal-dialog"),
				this.$backdrop = null,
				this.isShown = null,
				this.originalBodyPad = null,
				this.scrollbarWidth = 0,
				this.ignoreBackdropClick = !1,
				this.options.remote && this.$element.find(".modal-content").load(this.options.remote, a.proxy(function () {
					this.$element.trigger("loaded.bs.modal")
				}, this))
		};
		c.VERSION = "3.3.5",
			c.TRANSITION_DURATION = 300,
			c.BACKDROP_TRANSITION_DURATION = 150,
			c.DEFAULTS = {
				backdrop: !0,
				keyboard: !0,
				show: !0
			},
			c.prototype.toggle = function (a) {
				return this.isShown ? this.hide() : this.show(a)
			}
			,
			c.prototype.show = function (b) {
				var d = this
					, e = a.Event("show.bs.modal", {
						relatedTarget: b
					});
				this.$element.trigger(e),
					this.isShown || e.isDefaultPrevented() || (this.isShown = !0,
						this.checkScrollbar(),
						this.setScrollbar(),
						this.$body.addClass("modal-open"),
						this.escape(),
						this.resize(),
						this.$element.on("click.dismiss.bs.modal", '[data-dismiss="modal"]', a.proxy(this.hide, this)),
						this.$dialog.on("mousedown.dismiss.bs.modal", function () {
							d.$element.one("mouseup.dismiss.bs.modal", function (b) {
								a(b.target).is(d.$element) && (d.ignoreBackdropClick = !0)
							})
						}),
						this.backdrop(function () {
							var e = a.support.transition && d.$element.hasClass("fade");
							d.$element.parent().length || d.$element.appendTo(d.$body),
								d.$element.show().scrollTop(0),
								d.adjustDialog(),
								e && d.$element[0].offsetWidth,
								d.$element.addClass("in"),
								d.enforceFocus();
							var f = a.Event("shown.bs.modal", {
								relatedTarget: b
							});
							e ? d.$dialog.one("bsTransitionEnd", function () {
								d.$element.trigger("focus").trigger(f)
							}).emulateTransitionEnd(c.TRANSITION_DURATION) : d.$element.trigger("focus").trigger(f)
						}))
			}
			,
			c.prototype.hide = function (b) {
				b && b.preventDefault(),
					b = a.Event("hide.bs.modal"),
					this.$element.trigger(b),
					this.isShown && !b.isDefaultPrevented() && (this.isShown = !1,
						this.escape(),
						this.resize(),
						a(document).off("focusin.bs.modal"),
						this.$element.removeClass("in").off("click.dismiss.bs.modal").off("mouseup.dismiss.bs.modal"),
						this.$dialog.off("mousedown.dismiss.bs.modal"),
						a.support.transition && this.$element.hasClass("fade") ? this.$element.one("bsTransitionEnd", a.proxy(this.hideModal, this)).emulateTransitionEnd(c.TRANSITION_DURATION) : this.hideModal())
			}
			,
			c.prototype.enforceFocus = function () {
				a(document).off("focusin.bs.modal").on("focusin.bs.modal", a.proxy(function (a) {
					this.$element[0] === a.target || this.$element.has(a.target).length || this.$element.trigger("focus")
				}, this))
			}
			,
			c.prototype.escape = function () {
				this.isShown && this.options.keyboard ? this.$element.on("keydown.dismiss.bs.modal", a.proxy(function (a) {
					27 == a.which && this.hide()
				}, this)) : this.isShown || this.$element.off("keydown.dismiss.bs.modal")
			}
			,
			c.prototype.resize = function () {
				this.isShown ? a(window).on("resize.bs.modal", a.proxy(this.handleUpdate, this)) : a(window).off("resize.bs.modal")
			}
			,
			c.prototype.hideModal = function () {
				var a = this;
				this.$element.hide(),
					this.backdrop(function () {
						a.$body.removeClass("modal-open"),
							a.resetAdjustments(),
							a.resetScrollbar(),
							a.$element.trigger("hidden.bs.modal")
					})
			}
			,
			c.prototype.removeBackdrop = function () {
				this.$backdrop && this.$backdrop.remove(),
					this.$backdrop = null
			}
			,
			c.prototype.backdrop = function (b) {
				var d = this
					, e = this.$element.hasClass("fade") ? "fade" : "";
				if (this.isShown && this.options.backdrop) {
					var f = a.support.transition && e;
					if (this.$backdrop = a(document.createElement("div")).addClass("modal-backdrop " + e).appendTo(this.$body),
						this.$element.on("click.dismiss.bs.modal", a.proxy(function (a) {
							return this.ignoreBackdropClick ? void (this.ignoreBackdropClick = !1) : void (a.target === a.currentTarget && ("static" == this.options.backdrop ? this.$element[0].focus() : this.hide()))
						}, this)),
						f && this.$backdrop[0].offsetWidth,
						this.$backdrop.addClass("in"),
						!b)
						return;
					f ? this.$backdrop.one("bsTransitionEnd", b).emulateTransitionEnd(c.BACKDROP_TRANSITION_DURATION) : b()
				} else if (!this.isShown && this.$backdrop) {
					this.$backdrop.removeClass("in");
					var g = function () {
						d.removeBackdrop(),
							b && b()
					};
					a.support.transition && this.$element.hasClass("fade") ? this.$backdrop.one("bsTransitionEnd", g).emulateTransitionEnd(c.BACKDROP_TRANSITION_DURATION) : g()
				} else
					b && b()
			}
			,
			c.prototype.handleUpdate = function () {
				this.adjustDialog()
			}
			,
			c.prototype.adjustDialog = function () {
				var a = this.$element[0].scrollHeight > document.documentElement.clientHeight;
				this.$element.css({
					paddingLeft: !this.bodyIsOverflowing && a ? this.scrollbarWidth : "",
					paddingRight: this.bodyIsOverflowing && !a ? this.scrollbarWidth : ""
				})
			}
			,
			c.prototype.resetAdjustments = function () {
				this.$element.css({
					paddingLeft: "",
					paddingRight: ""
				})
			}
			,
			c.prototype.checkScrollbar = function () {
				var a = window.innerWidth;
				if (!a) {
					var b = document.documentElement.getBoundingClientRect();
					a = b.right - Math.abs(b.left)
				}
				this.bodyIsOverflowing = document.body.clientWidth < a,
					this.scrollbarWidth = this.measureScrollbar()
			}
			,
			c.prototype.setScrollbar = function () {
				var a = parseInt(this.$body.css("padding-right") || 0, 10);
				this.originalBodyPad = document.body.style.paddingRight || "",
					this.bodyIsOverflowing && this.$body.css("padding-right", a + this.scrollbarWidth)
			}
			,
			c.prototype.resetScrollbar = function () {
				this.$body.css("padding-right", this.originalBodyPad)
			}
			,
			c.prototype.measureScrollbar = function () {
				var a = document.createElement("div");
				a.className = "modal-scrollbar-measure",
					this.$body.append(a);
				var b = a.offsetWidth - a.clientWidth;
				return this.$body[0].removeChild(a),
					b
			}
			;
		var d = a.fn.modal;
		a.fn.modal = b,
			a.fn.modal.Constructor = c,
			a.fn.modal.noConflict = function () {
				return a.fn.modal = d,
					this
			}
			,
			a(document).on("click.bs.modal.data-api", '[data-toggle="modal"]', function (c) {
				var d = a(this)
					, e = d.attr("href")
					, f = a(d.attr("data-target") || e && e.replace(/.*(?=#[^\s]+$)/, ""))
					, g = f.data("bs.modal") ? "toggle" : a.extend({
						remote: !/#/.test(e) && e
					}, f.data(), d.data());
				d.is("a") && c.preventDefault(),
					f.one("show.bs.modal", function (a) {
						a.isDefaultPrevented() || f.one("hidden.bs.modal", function () {
							d.is(":visible") && d.trigger("focus")
						})
					}),
					b.call(f, g, this)
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.tooltip")
					, f = "object" == typeof b && b;
				(e || !/destroy|hide/.test(b)) && (e || d.data("bs.tooltip", e = new c(this, f)),
					"string" == typeof b && e[b]())
			})
		}
		var c = function (a, b) {
			this.type = null,
				this.options = null,
				this.enabled = null,
				this.timeout = null,
				this.hoverState = null,
				this.$element = null,
				this.inState = null,
				this.init("tooltip", a, b)
		};
		c.VERSION = "3.3.5",
			c.TRANSITION_DURATION = 150,
			c.DEFAULTS = {
				animation: !0,
				placement: "top",
				selector: !1,
				template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
				trigger: "hover focus",
				title: "",
				delay: 0,
				html: !1,
				container: !1,
				viewport: {
					selector: "body",
					padding: 0
				}
			},
			c.prototype.init = function (b, c, d) {
				if (this.enabled = !0,
					this.type = b,
					this.$element = a(c),
					this.options = this.getOptions(d),
					this.$viewport = this.options.viewport && a(a.isFunction(this.options.viewport) ? this.options.viewport.call(this, this.$element) : this.options.viewport.selector || this.options.viewport),
					this.inState = {
						click: !1,
						hover: !1,
						focus: !1
					},
					this.$element[0] instanceof document.constructor && !this.options.selector)
					throw new Error("`selector` option must be specified when initializing " + this.type + " on the window.document object!");
				for (var e = this.options.trigger.split(" "), f = e.length; f--;) {
					var g = e[f];
					if ("click" == g)
						this.$element.on("click." + this.type, this.options.selector, a.proxy(this.toggle, this));
					else if ("manual" != g) {
						var h = "hover" == g ? "mouseenter" : "focusin"
							, i = "hover" == g ? "mouseleave" : "focusout";
						this.$element.on(h + "." + this.type, this.options.selector, a.proxy(this.enter, this)),
							this.$element.on(i + "." + this.type, this.options.selector, a.proxy(this.leave, this))
					}
				}
				this.options.selector ? this._options = a.extend({}, this.options, {
					trigger: "manual",
					selector: ""
				}) : this.fixTitle()
			}
			,
			c.prototype.getDefaults = function () {
				return c.DEFAULTS
			}
			,
			c.prototype.getOptions = function (b) {
				return b = a.extend({}, this.getDefaults(), this.$element.data(), b),
					b.delay && "number" == typeof b.delay && (b.delay = {
						show: b.delay,
						hide: b.delay
					}),
					b
			}
			,
			c.prototype.getDelegateOptions = function () {
				var b = {}
					, c = this.getDefaults();
				return this._options && a.each(this._options, function (a, d) {
					c[a] != d && (b[a] = d)
				}),
					b
			}
			,
			c.prototype.enter = function (b) {
				var c = b instanceof this.constructor ? b : a(b.currentTarget).data("bs." + this.type);
				return c || (c = new this.constructor(b.currentTarget, this.getDelegateOptions()),
					a(b.currentTarget).data("bs." + this.type, c)),
					b instanceof a.Event && (c.inState["focusin" == b.type ? "focus" : "hover"] = !0),
					c.tip().hasClass("in") || "in" == c.hoverState ? void (c.hoverState = "in") : (clearTimeout(c.timeout),
						c.hoverState = "in",
						c.options.delay && c.options.delay.show ? void (c.timeout = setTimeout(function () {
							"in" == c.hoverState && c.show()
						}, c.options.delay.show)) : c.show())
			}
			,
			c.prototype.isInStateTrue = function () {
				for (var a in this.inState)
					if (this.inState[a])
						return !0;
				return !1
			}
			,
			c.prototype.leave = function (b) {
				var c = b instanceof this.constructor ? b : a(b.currentTarget).data("bs." + this.type);
				return c || (c = new this.constructor(b.currentTarget, this.getDelegateOptions()),
					a(b.currentTarget).data("bs." + this.type, c)),
					b instanceof a.Event && (c.inState["focusout" == b.type ? "focus" : "hover"] = !1),
					c.isInStateTrue() ? void 0 : (clearTimeout(c.timeout),
						c.hoverState = "out",
						c.options.delay && c.options.delay.hide ? void (c.timeout = setTimeout(function () {
							"out" == c.hoverState && c.hide()
						}, c.options.delay.hide)) : c.hide())
			}
			,
			c.prototype.show = function () {
				var b = a.Event("show.bs." + this.type);
				if (this.hasContent() && this.enabled) {
					this.$element.trigger(b);
					var d = a.contains(this.$element[0].ownerDocument.documentElement, this.$element[0]);
					if (b.isDefaultPrevented() || !d)
						return;
					var e = this
						, f = this.tip()
						, g = this.getUID(this.type);
					this.setContent(),
						f.attr("id", g),
						this.$element.attr("aria-describedby", g),
						this.options.animation && f.addClass("fade");
					var h = "function" == typeof this.options.placement ? this.options.placement.call(this, f[0], this.$element[0]) : this.options.placement
						, i = /\s?auto?\s?/i
						, j = i.test(h);
					j && (h = h.replace(i, "") || "top"),
						f.detach().css({
							top: 0,
							left: 0,
							display: "block"
						}).addClass(h).data("bs." + this.type, this),
						this.options.container ? f.appendTo(this.options.container) : f.insertAfter(this.$element),
						this.$element.trigger("inserted.bs." + this.type);
					var k = this.getPosition()
						, l = f[0].offsetWidth
						, m = f[0].offsetHeight;
					if (j) {
						var n = h
							, o = this.getPosition(this.$viewport);
						h = "bottom" == h && k.bottom + m > o.bottom ? "top" : "top" == h && k.top - m < o.top ? "bottom" : "right" == h && k.right + l > o.width ? "left" : "left" == h && k.left - l < o.left ? "right" : h,
							f.removeClass(n).addClass(h)
					}
					var p = this.getCalculatedOffset(h, k, l, m);
					this.applyPlacement(p, h);
					var q = function () {
						var a = e.hoverState;
						e.$element.trigger("shown.bs." + e.type),
							e.hoverState = null,
							"out" == a && e.leave(e)
					};
					a.support.transition && this.$tip.hasClass("fade") ? f.one("bsTransitionEnd", q).emulateTransitionEnd(c.TRANSITION_DURATION) : q()
				}
			}
			,
			c.prototype.applyPlacement = function (b, c) {
				var d = this.tip()
					, e = d[0].offsetWidth
					, f = d[0].offsetHeight
					, g = parseInt(d.css("margin-top"), 10)
					, h = parseInt(d.css("margin-left"), 10);
				isNaN(g) && (g = 0),
					isNaN(h) && (h = 0),
					b.top += g,
					b.left += h,
					a.offset.setOffset(d[0], a.extend({
						using: function (a) {
							d.css({
								top: Math.round(a.top),
								left: Math.round(a.left)
							})
						}
					}, b), 0),
					d.addClass("in");
				var i = d[0].offsetWidth
					, j = d[0].offsetHeight;
				"top" == c && j != f && (b.top = b.top + f - j);
				var k = this.getViewportAdjustedDelta(c, b, i, j);
				k.left ? b.left += k.left : b.top += k.top;
				var l = /top|bottom/.test(c)
					, m = l ? 2 * k.left - e + i : 2 * k.top - f + j
					, n = l ? "offsetWidth" : "offsetHeight";
				d.offset(b),
					this.replaceArrow(m, d[0][n], l)
			}
			,
			c.prototype.replaceArrow = function (a, b, c) {
				this.arrow().css(c ? "left" : "top", 50 * (1 - a / b) + "%").css(c ? "top" : "left", "")
			}
			,
			c.prototype.setContent = function () {
				var a = this.tip()
					, b = this.getTitle();
				a.find(".tooltip-inner")[this.options.html ? "html" : "text"](b),
					a.removeClass("fade in top bottom left right")
			}
			,
			c.prototype.hide = function (b) {
				function d() {
					"in" != e.hoverState && f.detach(),
						e.$element.removeAttr("aria-describedby").trigger("hidden.bs." + e.type),
						b && b()
				}
				var e = this
					, f = a(this.$tip)
					, g = a.Event("hide.bs." + this.type);
				return this.$element.trigger(g),
					g.isDefaultPrevented() ? void 0 : (f.removeClass("in"),
						a.support.transition && f.hasClass("fade") ? f.one("bsTransitionEnd", d).emulateTransitionEnd(c.TRANSITION_DURATION) : d(),
						this.hoverState = null,
						this)
			}
			,
			c.prototype.fixTitle = function () {
				var a = this.$element;
				(a.attr("title") || "string" != typeof a.attr("data-original-title")) && a.attr("data-original-title", a.attr("title") || "").attr("title", "")
			}
			,
			c.prototype.hasContent = function () {
				return this.getTitle()
			}
			,
			c.prototype.getPosition = function (b) {
				b = b || this.$element;
				var c = b[0]
					, d = "BODY" == c.tagName
					, e = c.getBoundingClientRect();
				null == e.width && (e = a.extend({}, e, {
					width: e.right - e.left,
					height: e.bottom - e.top
				}));
				var f = d ? {
					top: 0,
					left: 0
				} : b.offset()
					, g = {
						scroll: d ? document.documentElement.scrollTop || document.body.scrollTop : b.scrollTop()
					}
					, h = d ? {
						width: a(window).width(),
						height: a(window).height()
					} : null;
				return a.extend({}, e, g, h, f)
			}
			,
			c.prototype.getCalculatedOffset = function (a, b, c, d) {
				return "bottom" == a ? {
					top: b.top + b.height,
					left: b.left + b.width / 2 - c / 2
				} : "top" == a ? {
					top: b.top - d,
					left: b.left + b.width / 2 - c / 2
				} : "left" == a ? {
					top: b.top + b.height / 2 - d / 2,
					left: b.left - c
				} : {
								top: b.top + b.height / 2 - d / 2,
								left: b.left + b.width
							}
			}
			,
			c.prototype.getViewportAdjustedDelta = function (a, b, c, d) {
				var e = {
					top: 0,
					left: 0
				};
				if (!this.$viewport)
					return e;
				var f = this.options.viewport && this.options.viewport.padding || 0
					, g = this.getPosition(this.$viewport);
				if (/right|left/.test(a)) {
					var h = b.top - f - g.scroll
						, i = b.top + f - g.scroll + d;
					h < g.top ? e.top = g.top - h : i > g.top + g.height && (e.top = g.top + g.height - i)
				} else {
					var j = b.left - f
						, k = b.left + f + c;
					j < g.left ? e.left = g.left - j : k > g.right && (e.left = g.left + g.width - k)
				}
				return e
			}
			,
			c.prototype.getTitle = function () {
				var a, b = this.$element, c = this.options;
				return a = b.attr("data-original-title") || ("function" == typeof c.title ? c.title.call(b[0]) : c.title)
			}
			,
			c.prototype.getUID = function (a) {
				do
					a += ~~(1e6 * Math.random());
				while (document.getElementById(a)); return a
			}
			,
			c.prototype.tip = function () {
				if (!this.$tip && (this.$tip = a(this.options.template),
					1 != this.$tip.length))
					throw new Error(this.type + " `template` option must consist of exactly 1 top-level element!");
				return this.$tip
			}
			,
			c.prototype.arrow = function () {
				return this.$arrow = this.$arrow || this.tip().find(".tooltip-arrow")
			}
			,
			c.prototype.enable = function () {
				this.enabled = !0
			}
			,
			c.prototype.disable = function () {
				this.enabled = !1
			}
			,
			c.prototype.toggleEnabled = function () {
				this.enabled = !this.enabled
			}
			,
			c.prototype.toggle = function (b) {
				var c = this;
				b && (c = a(b.currentTarget).data("bs." + this.type),
					c || (c = new this.constructor(b.currentTarget, this.getDelegateOptions()),
						a(b.currentTarget).data("bs." + this.type, c))),
					b ? (c.inState.click = !c.inState.click,
						c.isInStateTrue() ? c.enter(c) : c.leave(c)) : c.tip().hasClass("in") ? c.leave(c) : c.enter(c)
			}
			,
			c.prototype.destroy = function () {
				var a = this;
				clearTimeout(this.timeout),
					this.hide(function () {
						a.$element.off("." + a.type).removeData("bs." + a.type),
							a.$tip && a.$tip.detach(),
							a.$tip = null,
							a.$arrow = null,
							a.$viewport = null
					})
			}
			;
		var d = a.fn.mtooltip;
		a.fn.mtooltip = b,
			a.fn.mtooltip.Constructor = c,
			a.fn.mtooltip.noConflict = function () {
				return a.fn.mtooltip = d,
					this
			}
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.popover")
					, f = "object" == typeof b && b;
				(e || !/destroy|hide/.test(b)) && (e || d.data("bs.popover", e = new c(this, f)),
					"string" == typeof b && e[b]())
			})
		}
		var c = function (a, b) {
			this.init("popover", a, b)
		};
		if (!a.fn.mtooltip)
			throw new Error("Popover requires tooltip.js");
		c.VERSION = "3.3.5",
			c.DEFAULTS = a.extend({}, a.fn.mtooltip.Constructor.DEFAULTS, {
				placement: "right",
				trigger: "click",
				content: "",
				template: '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
			}),
			c.prototype = a.extend({}, a.fn.mtooltip.Constructor.prototype),
			c.prototype.constructor = c,
			c.prototype.getDefaults = function () {
				return c.DEFAULTS
			}
			,
			c.prototype.setContent = function () {
				var a = this.tip()
					, b = this.getTitle()
					, c = this.getContent();
				a.find(".popover-title")[this.options.html ? "html" : "text"](b),
					a.find(".popover-content").children().detach().end()[this.options.html ? "string" == typeof c ? "html" : "append" : "text"](c),
					a.removeClass("fade top bottom left right in"),
					a.find(".popover-title").html() || a.find(".popover-title").hide()
			}
			,
			c.prototype.hasContent = function () {
				return this.getTitle() || this.getContent()
			}
			,
			c.prototype.getContent = function () {
				var a = this.$element
					, b = this.options;
				return a.attr("data-content") || ("function" == typeof b.content ? b.content.call(a[0]) : b.content)
			}
			,
			c.prototype.arrow = function () {
				return this.$arrow = this.$arrow || this.tip().find(".arrow")
			}
			;
		var d = a.fn.popover;
		a.fn.popover = b,
			a.fn.popover.Constructor = c,
			a.fn.popover.noConflict = function () {
				return a.fn.popover = d,
					this
			}
	}(jQuery),
	+function (a) {
		"use strict";
		function b(c, d) {
			this.$body = a(document.body),
				this.$scrollElement = a(a(c).is(document.body) ? window : c),
				this.options = a.extend({}, b.DEFAULTS, d),
				this.selector = (this.options.target || "") + " .nav li > a",
				this.offsets = [],
				this.targets = [],
				this.activeTarget = null,
				this.scrollHeight = 0,
				this.$scrollElement.on("scroll.bs.scrollspy", a.proxy(this.process, this)),
				this.refresh(),
				this.process()
		}
		function c(c) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.scrollspy")
					, f = "object" == typeof c && c;
				e || d.data("bs.scrollspy", e = new b(this, f)),
					"string" == typeof c && e[c]()
			})
		}
		b.VERSION = "3.3.5",
			b.DEFAULTS = {
				offset: 10
			},
			b.prototype.getScrollHeight = function () {
				return this.$scrollElement[0].scrollHeight || Math.max(this.$body[0].scrollHeight, document.documentElement.scrollHeight)
			}
			,
			b.prototype.refresh = function () {
				var b = this
					, c = "offset"
					, d = 0;
				this.offsets = [],
					this.targets = [],
					this.scrollHeight = this.getScrollHeight(),
					a.isWindow(this.$scrollElement[0]) || (c = "position",
						d = this.$scrollElement.scrollTop()),
					this.$body.find(this.selector).map(function () {
						var b = a(this)
							, e = b.data("target") || b.attr("href")
							, f = /^#./.test(e) && a(e);
						return f && f.length && f.is(":visible") && [[f[c]().top + d, e]] || null
					}).sort(function (a, b) {
						return a[0] - b[0]
					}).each(function () {
						b.offsets.push(this[0]),
							b.targets.push(this[1])
					})
			}
			,
			b.prototype.process = function () {
				var a, b = this.$scrollElement.scrollTop() + this.options.offset, c = this.getScrollHeight(), d = this.options.offset + c - this.$scrollElement.height(), e = this.offsets, f = this.targets, g = this.activeTarget;
				if (this.scrollHeight != c && this.refresh(),
					b >= d)
					return g != (a = f[f.length - 1]) && this.activate(a);
				if (g && b < e[0])
					return this.activeTarget = null,
						this.clear();
				for (a = e.length; a--;)
					g != f[a] && b >= e[a] && (void 0 === e[a + 1] || b < e[a + 1]) && this.activate(f[a])
			}
			,
			b.prototype.activate = function (b) {
				this.activeTarget = b,
					this.clear();
				var c = this.selector + '[data-target="' + b + '"],' + this.selector + '[href="' + b + '"]'
					, d = a(c).parents("li").addClass("active");
				d.parent(".dropdown-menu").length && (d = d.closest("li.dropdown").addClass("active")),
					d.trigger("activate.bs.scrollspy")
			}
			,
			b.prototype.clear = function () {
				a(this.selector).parentsUntil(this.options.target, ".active").removeClass("active")
			}
			;
		var d = a.fn.scrollspy;
		a.fn.scrollspy = c,
			a.fn.scrollspy.Constructor = b,
			a.fn.scrollspy.noConflict = function () {
				return a.fn.scrollspy = d,
					this
			}
			,
			a(window).on("load.bs.scrollspy.data-api", function () {
				a('[data-spy="scroll"]').each(function () {
					var b = a(this);
					c.call(b, b.data())
				})
			})
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.tab");
				e || d.data("bs.tab", e = new c(this)),
					"string" == typeof b && e[b]()
			})
		}
		var c = function (b) {
			this.element = a(b)
		};
		c.VERSION = "3.3.5",
			c.TRANSITION_DURATION = 150,
			c.prototype.show = function () {
				var b = this.element
					, c = b.closest("ul:not(.dropdown-menu)")
					, d = b.data("target");
				if (d || (d = b.attr("href"),
					d = d && d.replace(/.*(?=#[^\s]*$)/, "")),
					!b.parent("li").hasClass("active")) {
					var e = c.find(".active:last a")
						, f = a.Event("hide.bs.tab", {
							relatedTarget: b[0]
						})
						, g = a.Event("show.bs.tab", {
							relatedTarget: e[0]
						});
					if (e.trigger(f),
						b.trigger(g),
						!g.isDefaultPrevented() && !f.isDefaultPrevented()) {
						var h = a(d);
						this.activate(b.closest("li"), c),
							this.activate(h, h.parent(), function () {
								e.trigger({
									type: "hidden.bs.tab",
									relatedTarget: b[0]
								}),
									b.trigger({
										type: "shown.bs.tab",
										relatedTarget: e[0]
									})
							})
					}
				}
			}
			,
			c.prototype.activate = function (b, d, e) {
				function f() {
					g.removeClass("active").find("> .dropdown-menu > .active").removeClass("active").end().find('[data-toggle="tab"]').attr("aria-expanded", !1),
						b.addClass("active").find('[data-toggle="tab"]').attr("aria-expanded", !0),
						h ? (b[0].offsetWidth,
							b.addClass("in")) : b.removeClass("fade"),
						b.parent(".dropdown-menu").length && b.closest("li.dropdown").addClass("active").end().find('[data-toggle="tab"]').attr("aria-expanded", !0),
						e && e()
				}
				var g = d.find("> .active")
					, h = e && a.support.transition && (g.length && g.hasClass("fade") || !!d.find("> .fade").length);
				g.length && h ? g.one("bsTransitionEnd", f).emulateTransitionEnd(c.TRANSITION_DURATION) : f(),
					g.removeClass("in")
			}
			;
		var d = a.fn.tab;
		a.fn.tab = b,
			a.fn.tab.Constructor = c,
			a.fn.tab.noConflict = function () {
				return a.fn.tab = d,
					this
			}
			;
		var e = function (c) {
			c.preventDefault(),
				b.call(a(this), "show")
		};
		a(document).on("click.bs.tab.data-api", '[data-toggle="tab"]', e).on("click.bs.tab.data-api", '[data-toggle="pill"]', e)
	}(jQuery),
	+function (a) {
		"use strict";
		function b(b) {
			return this.each(function () {
				var d = a(this)
					, e = d.data("bs.affix")
					, f = "object" == typeof b && b;
				e || d.data("bs.affix", e = new c(this, f)),
					"string" == typeof b && e[b]()
			})
		}
		var c = function (b, d) {
			this.options = a.extend({}, c.DEFAULTS, d),
				this.$target = a(this.options.target).on("scroll.bs.affix.data-api", a.proxy(this.checkPosition, this)).on("click.bs.affix.data-api", a.proxy(this.checkPositionWithEventLoop, this)),
				this.$element = a(b),
				this.affixed = null,
				this.unpin = null,
				this.pinnedOffset = null,
				this.checkPosition()
		};
		c.VERSION = "3.3.5",
			c.RESET = "affix affix-top affix-bottom",
			c.DEFAULTS = {
				offset: 0,
				target: window
			},
			c.prototype.getState = function (a, b, c, d) {
				var e = this.$target.scrollTop()
					, f = this.$element.offset()
					, g = this.$target.height();
				if (null != c && "top" == this.affixed)
					return c > e ? "top" : !1;
				if ("bottom" == this.affixed)
					return null != c ? e + this.unpin <= f.top ? !1 : "bottom" : a - d >= e + g ? !1 : "bottom";
				var h = null == this.affixed
					, i = h ? e : f.top
					, j = h ? g : b;
				return null != c && c >= e ? "top" : null != d && i + j >= a - d ? "bottom" : !1
			}
			,
			c.prototype.getPinnedOffset = function () {
				if (this.pinnedOffset)
					return this.pinnedOffset;
				this.$element.removeClass(c.RESET).addClass("affix");
				var a = this.$target.scrollTop()
					, b = this.$element.offset();
				return this.pinnedOffset = b.top - a
			}
			,
			c.prototype.checkPositionWithEventLoop = function () {
				setTimeout(a.proxy(this.checkPosition, this), 1)
			}
			,
			c.prototype.checkPosition = function () {
				if (this.$element.is(":visible")) {
					var b = this.$element.height()
						, d = this.options.offset
						, e = d.top
						, f = d.bottom
						, g = Math.max(a(document).height(), a(document.body).height());
					"object" != typeof d && (f = e = d),
						"function" == typeof e && (e = d.top(this.$element)),
						"function" == typeof f && (f = d.bottom(this.$element));
					var h = this.getState(g, b, e, f);
					if (this.affixed != h) {
						null != this.unpin && this.$element.css("top", "");
						var i = "affix" + (h ? "-" + h : "")
							, j = a.Event(i + ".bs.affix");
						if (this.$element.trigger(j),
							j.isDefaultPrevented())
							return;
						this.affixed = h,
							this.unpin = "bottom" == h ? this.getPinnedOffset() : null,
							this.$element.removeClass(c.RESET).addClass(i).trigger(i.replace("affix", "affixed") + ".bs.affix")
					}
					"bottom" == h && this.$element.offset({
						top: g - b - f
					})
				}
			}
			;
		var d = a.fn.affix;
		a.fn.affix = b,
			a.fn.affix.Constructor = c,
			a.fn.affix.noConflict = function () {
				return a.fn.affix = d,
					this
			}
			,
			a(window).on("load", function () {
				a('[data-spy="affix"]').each(function () {
					var c = a(this)
						, d = c.data();
					d.offset = d.offset || {},
						null != d.offsetBottom && (d.offset.bottom = d.offsetBottom),
						null != d.offsetTop && (d.offset.top = d.offsetTop),
						b.call(c, d)
				})
			})
	}(jQuery);
var btn = $.fn.button.noConflict();
$.fn.btn = btn;
; (function (factory) {
	if (typeof define === 'function' && define.amd) {
		define(['jquery'], factory)
	} else if (typeof exports === 'object') {
		factory(require('jquery'))
	} else {
		factory(window.jQuery || window.Zepto)
	}
}(function ($) {
	var CLOSE_EVENT = 'Close'
		, BEFORE_CLOSE_EVENT = 'BeforeClose'
		, AFTER_CLOSE_EVENT = 'AfterClose'
		, BEFORE_APPEND_EVENT = 'BeforeAppend'
		, MARKUP_PARSE_EVENT = 'MarkupParse'
		, OPEN_EVENT = 'Open'
		, CHANGE_EVENT = 'Change'
		, NS = 'mfp'
		, EVENT_NS = '.' + NS
		, READY_CLASS = 'mfp-ready'
		, REMOVING_CLASS = 'mfp-removing'
		, PREVENT_CLOSE_CLASS = 'mfp-prevent-close';
	var mfp, MagnificPopup = function () { }, _isJQ = !!(window.jQuery), _prevStatus, _window = $(window), _body, _document, _prevContentType, _wrapClasses, _currPopupType;
	var _mfpOn = function (name, f) {
		mfp.ev.on(NS + name + EVENT_NS, f)
	}
		, _getEl = function (className, appendTo, html, raw) {
			var el = document.createElement('div');
			el.className = 'mfp-' + className;
			if (html) {
				el.innerHTML = html
			}
			if (!raw) {
				el = $(el);
				if (appendTo) {
					el.appendTo(appendTo)
				}
			} else if (appendTo) {
				appendTo.appendChild(el)
			}
			return el
		}
		, _mfpTrigger = function (e, data) {
			mfp.ev.triggerHandler(NS + e, data);
			if (mfp.st.callbacks) {
				e = e.charAt(0).toLowerCase() + e.slice(1);
				if (mfp.st.callbacks[e]) {
					mfp.st.callbacks[e].apply(mfp, $.isArray(data) ? data : [data])
				}
			}
		}
		, _getCloseBtn = function (type) {
			if (type !== _currPopupType || !mfp.currTemplate.closeBtn) {
				mfp.currTemplate.closeBtn = $(mfp.st.closeMarkup.replace('%title%', mfp.st.tClose));
				_currPopupType = type
			}
			return mfp.currTemplate.closeBtn
		}
		, _checkInstance = function () {
			if (!$.magnificPopup.instance) {
				mfp = new MagnificPopup();
				mfp.init();
				$.magnificPopup.instance = mfp
			}
		}
		, supportsTransitions = function () {
			var s = document.createElement('p').style
				, v = ['ms', 'O', 'Moz', 'Webkit'];
			if (s['transition'] !== undefined) {
				return true
			}
			while (v.length) {
				if (v.pop() + 'Transition' in s) {
					return true
				}
			}
			return false
		};
	MagnificPopup.prototype = {
		constructor: MagnificPopup,
		init: function () {
			var appVersion = navigator.appVersion;
			mfp.isIE7 = appVersion.indexOf("MSIE 7.") !== -1;
			mfp.isIE8 = appVersion.indexOf("MSIE 8.") !== -1;
			mfp.isLowIE = mfp.isIE7 || mfp.isIE8;
			mfp.isAndroid = (/android/gi).test(appVersion);
			mfp.isIOS = (/iphone|ipad|ipod/gi).test(appVersion);
			mfp.supportsTransition = supportsTransitions();
			mfp.probablyMobile = (mfp.isAndroid || mfp.isIOS || /(Opera Mini)|Kindle|webOS|BlackBerry|(Opera Mobi)|(Windows Phone)|IEMobile/i.test(navigator.userAgent));
			_document = $(document);
			mfp.popupsCache = {}
		},
		open: function (data) {
			if (!_body) {
				_body = $(document.body)
			}
			var i;
			if (data.isObj === false) {
				mfp.items = data.items.toArray();
				mfp.index = 0;
				var items = data.items, item;
				for (i = 0; i < items.length; i++) {
					item = items[i];
					if (item.parsed) {
						item = item.el[0]
					}
					if (item === data.el[0]) {
						mfp.index = i;
						break
					}
				}
			} else {
				mfp.items = $.isArray(data.items) ? data.items : [data.items];
				mfp.index = data.index || 0
			}
			if (mfp.isOpen) {
				mfp.updateItemHTML();
				return
			}
			mfp.types = [];
			_wrapClasses = '';
			if (data.mainEl && data.mainEl.length) {
				mfp.ev = data.mainEl.eq(0)
			} else {
				mfp.ev = _document
			}
			if (data.key) {
				if (!mfp.popupsCache[data.key]) {
					mfp.popupsCache[data.key] = {}
				}
				mfp.currTemplate = mfp.popupsCache[data.key]
			} else {
				mfp.currTemplate = {}
			}
			mfp.st = $.extend(true, {}, $.magnificPopup.defaults, data);
			mfp.fixedContentPos = mfp.st.fixedContentPos === 'auto' ? !mfp.probablyMobile : mfp.st.fixedContentPos;
			if (mfp.st.modal) {
				mfp.st.closeOnContentClick = false;
				mfp.st.closeOnBgClick = false;
				mfp.st.showCloseBtn = false;
				mfp.st.enableEscapeKey = false
			}
			if (!mfp.bgOverlay) {
				mfp.bgOverlay = _getEl('bg').on('click' + EVENT_NS, function () {
					mfp.close()
				});
				mfp.wrap = _getEl('wrap').attr('tabindex', -1).on('click' + EVENT_NS, function (e) {
					if (mfp._checkIfClose(e.target)) {
						mfp.close()
					}
				});
				mfp.container = _getEl('container', mfp.wrap)
			}
			mfp.contentContainer = _getEl('content');
			if (mfp.st.preloader) {
				mfp.preloader = _getEl('preloader', mfp.container, mfp.st.tLoading)
			}
			var modules = $.magnificPopup.modules;
			for (i = 0; i < modules.length; i++) {
				var n = modules[i];
				n = n.charAt(0).toUpperCase() + n.slice(1);
				mfp['init' + n].call(mfp)
			}
			_mfpTrigger('BeforeOpen');
			if (mfp.st.showCloseBtn) {
				if (!mfp.st.closeBtnInside) {
					mfp.wrap.append(_getCloseBtn())
				} else {
					_mfpOn(MARKUP_PARSE_EVENT, function (e, template, values, item) {
						values.close_replaceWith = _getCloseBtn(item.type)
					});
					_wrapClasses += ' mfp-close-btn-in'
				}
			}
			if (mfp.st.alignTop) {
				_wrapClasses += ' mfp-align-top'
			}
			if (mfp.fixedContentPos) {
				mfp.wrap.css({
					overflow: mfp.st.overflowY,
					overflowX: 'hidden',
					overflowY: mfp.st.overflowY
				})
			} else {
				mfp.wrap.css({
					top: _window.scrollTop(),
					position: 'absolute'
				})
			}
			if (mfp.st.fixedBgPos === false || (mfp.st.fixedBgPos === 'auto' && !mfp.fixedContentPos)) {
				mfp.bgOverlay.css({
					height: _document.height(),
					position: 'absolute'
				})
			}
			if (mfp.st.enableEscapeKey) {
				_document.on('keyup' + EVENT_NS, function (e) {
					if (e.keyCode === 27) {
						mfp.close()
					}
				})
			}
			_window.on('resize' + EVENT_NS, function () {
				mfp.updateSize()
			});
			if (!mfp.st.closeOnContentClick) {
				_wrapClasses += ' mfp-auto-cursor'
			}
			if (_wrapClasses)
				mfp.wrap.addClass(_wrapClasses);
			var windowHeight = mfp.wH = _window.height();
			var windowStyles = {};
			if (mfp.fixedContentPos) {
				if (mfp._hasScrollBar(windowHeight)) {
					var s = mfp._getScrollbarSize();
					if (s) {
						windowStyles.marginRight = s
					}
				}
			}
			if (mfp.fixedContentPos) {
				if (!mfp.isIE7) {
					windowStyles.overflow = 'hidden'
				} else {
					$('body, html').css('overflow', 'hidden')
				}
			}
			var classesToadd = mfp.st.mainClass;
			if (mfp.isIE7) {
				classesToadd += ' mfp-ie7'
			}
			if (classesToadd) {
				mfp._addClassToMFP(classesToadd)
			}
			mfp.updateItemHTML();
			_mfpTrigger('BuildControls');
			$('html').css(windowStyles);
			mfp.bgOverlay.add(mfp.wrap).prependTo(mfp.st.prependTo || _body);
			mfp._lastFocusedEl = document.activeElement;
			setTimeout(function () {
				if (mfp.content) {
					mfp._addClassToMFP(READY_CLASS);
					mfp._setFocus()
				} else {
					mfp.bgOverlay.addClass(READY_CLASS)
				}
				_document.on('focusin' + EVENT_NS, mfp._onFocusIn)
			}, 16);
			mfp.isOpen = true;
			mfp.updateSize(windowHeight);
			_mfpTrigger(OPEN_EVENT);
			return data
		},
		close: function () {
			if (!mfp.isOpen)
				return;
			_mfpTrigger(BEFORE_CLOSE_EVENT);
			mfp.isOpen = false;
			if (mfp.st.removalDelay && !mfp.isLowIE && mfp.supportsTransition) {
				mfp._addClassToMFP(REMOVING_CLASS);
				setTimeout(function () {
					mfp._close()
				}, mfp.st.removalDelay)
			} else {
				mfp._close()
			}
		},
		_close: function () {
			_mfpTrigger(CLOSE_EVENT);
			var classesToRemove = REMOVING_CLASS + ' ' + READY_CLASS + ' ';
			mfp.bgOverlay.detach();
			mfp.wrap.detach();
			mfp.container.empty();
			if (mfp.st.mainClass) {
				classesToRemove += mfp.st.mainClass + ' '
			}
			mfp._removeClassFromMFP(classesToRemove);
			if (mfp.fixedContentPos) {
				var windowStyles = {
					marginRight: ''
				};
				if (mfp.isIE7) {
					$('body, html').css('overflow', '')
				} else {
					windowStyles.overflow = ''
				}
				$('html').css(windowStyles)
			}
			_document.off('keyup' + EVENT_NS + ' focusin' + EVENT_NS);
			mfp.ev.off(EVENT_NS);
			mfp.wrap.attr('class', 'mfp-wrap').removeAttr('style');
			mfp.bgOverlay.attr('class', 'mfp-bg');
			mfp.container.attr('class', 'mfp-container');
			if (mfp.st.showCloseBtn && (!mfp.st.closeBtnInside || mfp.currTemplate[mfp.currItem.type] === true)) {
				if (mfp.currTemplate.closeBtn)
					mfp.currTemplate.closeBtn.detach()
			}
			if (mfp._lastFocusedEl) {
				$(mfp._lastFocusedEl).focus()
			}
			mfp.currItem = null;
			mfp.content = null;
			mfp.currTemplate = null;
			mfp.prevHeight = 0;
			_mfpTrigger(AFTER_CLOSE_EVENT)
		},
		updateSize: function (winHeight) {
			if (mfp.isIOS) {
				var zoomLevel = document.documentElement.clientWidth / window.innerWidth;
				var height = window.innerHeight * zoomLevel;
				mfp.wrap.css('height', height);
				mfp.wH = height
			} else {
				mfp.wH = winHeight || _window.height()
			}
			if (!mfp.fixedContentPos) {
				mfp.wrap.css('height', mfp.wH)
			}
			_mfpTrigger('Resize')
		},
		updateItemHTML: function () {
			var item = mfp.items[mfp.index];
			mfp.contentContainer.detach();
			if (mfp.content)
				mfp.content.detach();
			if (!item.parsed) {
				item = mfp.parseEl(mfp.index)
			}
			var type = item.type;
			_mfpTrigger('BeforeChange', [mfp.currItem ? mfp.currItem.type : '', type]);
			mfp.currItem = item;
			if (!mfp.currTemplate[type]) {
				var markup = mfp.st[type] ? mfp.st[type].markup : false;
				_mfpTrigger('FirstMarkupParse', markup);
				if (markup) {
					mfp.currTemplate[type] = $(markup)
				} else {
					mfp.currTemplate[type] = true
				}
			}
			if (_prevContentType && _prevContentType !== item.type) {
				mfp.container.removeClass('mfp-' + _prevContentType + '-holder')
			}
			var newContent = mfp['get' + type.charAt(0).toUpperCase() + type.slice(1)](item, mfp.currTemplate[type]);
			mfp.appendContent(newContent, type);
			item.preloaded = true;
			_mfpTrigger(CHANGE_EVENT, item);
			_prevContentType = item.type;
			mfp.container.prepend(mfp.contentContainer);
			_mfpTrigger('AfterChange')
		},
		appendContent: function (newContent, type) {
			mfp.content = newContent;
			if (newContent) {
				if (mfp.st.showCloseBtn && mfp.st.closeBtnInside && mfp.currTemplate[type] === true) {
					if (!mfp.content.find('.mfp-close').length) {
						mfp.content.append(_getCloseBtn())
					}
				} else {
					mfp.content = newContent
				}
			} else {
				mfp.content = ''
			}
			_mfpTrigger(BEFORE_APPEND_EVENT);
			mfp.container.addClass('mfp-' + type + '-holder');
			mfp.contentContainer.append(mfp.content)
		},
		parseEl: function (index) {
			var item = mfp.items[index], type;
			if (item.tagName) {
				item = {
					el: $(item)
				}
			} else {
				type = item.type;
				item = {
					data: item,
					src: item.src
				}
			}
			if (item.el) {
				var types = mfp.types;
				for (var i = 0; i < types.length; i++) {
					if (item.el.hasClass('mfp-' + types[i])) {
						type = types[i];
						break
					}
				}
				item.src = item.el.attr('data-mfp-src');
				if (!item.src) {
					item.src = item.el.attr('href')
				}
			}
			item.type = type || mfp.st.type || 'inline';
			item.index = index;
			item.parsed = true;
			mfp.items[index] = item;
			_mfpTrigger('ElementParse', item);
			return mfp.items[index]
		},
		addGroup: function (el, options) {
			var eHandler = function (e) {
				e.mfpEl = this;
				mfp._openClick(e, el, options)
			};
			if (!options) {
				options = {}
			}
			var eName = 'click.magnificPopup';
			options.mainEl = el;
			if (options.items) {
				options.isObj = true;
				el.off(eName).on(eName, eHandler)
			} else {
				options.isObj = false;
				if (options.delegate) {
					el.off(eName).on(eName, options.delegate, eHandler)
				} else {
					options.items = el;
					el.off(eName).on(eName, eHandler)
				}
			}
		},
		_openClick: function (e, el, options) {
			var midClick = options.midClick !== undefined ? options.midClick : $.magnificPopup.defaults.midClick;
			if (!midClick && (e.which === 2 || e.ctrlKey || e.metaKey)) {
				return
			}
			var disableOn = options.disableOn !== undefined ? options.disableOn : $.magnificPopup.defaults.disableOn;
			if (disableOn) {
				if ($.isFunction(disableOn)) {
					if (!disableOn.call(mfp)) {
						return true
					}
				} else {
					if (_window.width() < disableOn) {
						return true
					}
				}
			}
			if (e.type) {
				e.preventDefault();
				if (mfp.isOpen) {
					e.stopPropagation()
				}
			}
			options.el = $(e.mfpEl);
			if (options.delegate) {
				options.items = el.find(options.delegate)
			}
			mfp.open(options)
		},
		updateStatus: function (status, text) {
			if (mfp.preloader) {
				if (_prevStatus !== status) {
					mfp.container.removeClass('mfp-s-' + _prevStatus)
				}
				if (!text && status === 'loading') {
					text = mfp.st.tLoading
				}
				var data = {
					status: status,
					text: text
				};
				_mfpTrigger('UpdateStatus', data);
				status = data.status;
				text = data.text;
				mfp.preloader.html(text);
				mfp.preloader.find('a').on('click', function (e) {
					e.stopImmediatePropagation()
				});
				mfp.container.addClass('mfp-s-' + status);
				_prevStatus = status
			}
		},
		_checkIfClose: function (target) {
			if ($(target).hasClass(PREVENT_CLOSE_CLASS)) {
				return
			}
			var closeOnContent = mfp.st.closeOnContentClick;
			var closeOnBg = mfp.st.closeOnBgClick;
			if (closeOnContent && closeOnBg) {
				return true
			} else {
				if (!mfp.content || $(target).hasClass('mfp-close') || (mfp.preloader && target === mfp.preloader[0])) {
					return true
				}
				if ((target !== mfp.content[0] && !$.contains(mfp.content[0], target))) {
					if (closeOnBg) {
						if ($.contains(document, target)) {
							return true
						}
					}
				} else if (closeOnContent) {
					return true
				}
			}
			return false
		},
		_addClassToMFP: function (cName) {
			mfp.bgOverlay.addClass(cName);
			mfp.wrap.addClass(cName)
		},
		_removeClassFromMFP: function (cName) {
			this.bgOverlay.removeClass(cName);
			mfp.wrap.removeClass(cName)
		},
		_hasScrollBar: function (winHeight) {
			return ((mfp.isIE7 ? _document.height() : document.body.scrollHeight) > (winHeight || _window.height()))
		},
		_setFocus: function () {
			(mfp.st.focus ? mfp.content.find(mfp.st.focus).eq(0) : mfp.wrap).focus()
		},
		_onFocusIn: function (e) {
			if (e.target !== mfp.wrap[0] && !$.contains(mfp.wrap[0], e.target)) {
				mfp._setFocus();
				return false
			}
		},
		_parseMarkup: function (template, values, item) {
			var arr;
			if (item.data) {
				values = $.extend(item.data, values)
			}
			_mfpTrigger(MARKUP_PARSE_EVENT, [template, values, item]);
			$.each(values, function (key, value) {
				if (value === undefined || value === false) {
					return true
				}
				arr = key.split('_');
				if (arr.length > 1) {
					var el = template.find(EVENT_NS + '-' + arr[0]);
					if (el.length > 0) {
						var attr = arr[1];
						if (attr === 'replaceWith') {
							if (el[0] !== value[0]) {
								el.replaceWith(value)
							}
						} else if (attr === 'img') {
							if (el.is('img')) {
								el.attr('src', value)
							} else {
								el.replaceWith('<img src="' + value + '" class="' + el.attr('class') + '" />')
							}
						} else {
							el.attr(arr[1], value)
						}
					}
				} else {
					template.find(EVENT_NS + '-' + key).html(value)
				}
			})
		},
		_getScrollbarSize: function () {
			if (mfp.scrollbarSize === undefined) {
				var scrollDiv = document.createElement("div");
				scrollDiv.style.cssText = 'width: 99px; height: 99px; overflow: scroll; position: absolute; top: -9999px;';
				document.body.appendChild(scrollDiv);
				mfp.scrollbarSize = scrollDiv.offsetWidth - scrollDiv.clientWidth;
				document.body.removeChild(scrollDiv)
			}
			return mfp.scrollbarSize
		}
	};
	$.magnificPopup = {
		instance: null,
		proto: MagnificPopup.prototype,
		modules: [],
		open: function (options, index) {
			_checkInstance();
			if (!options) {
				options = {}
			} else {
				options = $.extend(true, {}, options)
			}
			options.isObj = true;
			options.index = index || 0;
			return this.instance.open(options)
		},
		close: function () {
			return $.magnificPopup.instance && $.magnificPopup.instance.close()
		},
		registerModule: function (name, module) {
			if (module.options) {
				$.magnificPopup.defaults[name] = module.options
			}
			$.extend(this.proto, module.proto);
			this.modules.push(name)
		},
		defaults: {
			disableOn: 0,
			key: null,
			midClick: false,
			mainClass: '',
			preloader: true,
			focus: '',
			closeOnContentClick: false,
			closeOnBgClick: true,
			closeBtnInside: true,
			showCloseBtn: true,
			enableEscapeKey: true,
			modal: false,
			alignTop: false,
			removalDelay: 0,
			prependTo: null,
			fixedContentPos: 'auto',
			fixedBgPos: 'auto',
			overflowY: 'auto',
			closeMarkup: '<button title="%title%" type="button" class="mfp-close">&times;</button>',
			tClose: 'Close (Esc)',
			tLoading: 'Loading...'
		}
	};
	$.fn.magnificPopup = function (options) {
		_checkInstance();
		var jqEl = $(this);
		if (typeof options === "string") {
			if (options === 'open') {
				var items, itemOpts = _isJQ ? jqEl.data('magnificPopup') : jqEl[0].magnificPopup, index = parseInt(arguments[1], 10) || 0;
				if (itemOpts.items) {
					items = itemOpts.items[index]
				} else {
					items = jqEl;
					if (itemOpts.delegate) {
						items = items.find(itemOpts.delegate)
					}
					items = items.eq(index)
				}
				mfp._openClick({
					mfpEl: items
				}, jqEl, itemOpts)
			} else {
				if (mfp.isOpen)
					mfp[options].apply(mfp, Array.prototype.slice.call(arguments, 1))
			}
		} else {
			options = $.extend(true, {}, options);
			if (_isJQ) {
				jqEl.data('magnificPopup', options)
			} else {
				jqEl[0].magnificPopup = options
			}
			mfp.addGroup(jqEl, options)
		}
		return jqEl
	}
		;
	var INLINE_NS = 'inline', _hiddenClass, _inlinePlaceholder, _lastInlineElement, _putInlineElementsBack = function () {
		if (_lastInlineElement) {
			_inlinePlaceholder.after(_lastInlineElement.addClass(_hiddenClass)).detach();
			_lastInlineElement = null
		}
	};
	$.magnificPopup.registerModule(INLINE_NS, {
		options: {
			hiddenClass: 'hide',
			markup: '',
			tNotFound: 'Content not found'
		},
		proto: {
			initInline: function () {
				mfp.types.push(INLINE_NS);
				_mfpOn(CLOSE_EVENT + '.' + INLINE_NS, function () {
					_putInlineElementsBack()
				})
			},
			getInline: function (item, template) {
				_putInlineElementsBack();
				if (item.src) {
					var inlineSt = mfp.st.inline
						, el = $(item.src);
					if (el.length) {
						var parent = el[0].parentNode;
						if (parent && parent.tagName) {
							if (!_inlinePlaceholder) {
								_hiddenClass = inlineSt.hiddenClass;
								_inlinePlaceholder = _getEl(_hiddenClass);
								_hiddenClass = 'mfp-' + _hiddenClass
							}
							_lastInlineElement = el.after(_inlinePlaceholder).detach().removeClass(_hiddenClass)
						}
						mfp.updateStatus('ready')
					} else {
						mfp.updateStatus('error', inlineSt.tNotFound);
						el = $('<div>')
					}
					item.inlineElement = el;
					return el
				}
				mfp.updateStatus('ready');
				mfp._parseMarkup(template, {}, item);
				return template
			}
		}
	});
	var AJAX_NS = 'ajax', _ajaxCur, _removeAjaxCursor = function () {
		if (_ajaxCur) {
			_body.removeClass(_ajaxCur)
		}
	}, _destroyAjaxRequest = function () {
		_removeAjaxCursor();
		if (mfp.req) {
			mfp.req.abort()
		}
	};
	$.magnificPopup.registerModule(AJAX_NS, {
		options: {
			settings: null,
			cursor: 'mfp-ajax-cur',
			tError: '<a href="%url%">The content</a> could not be loaded.'
		},
		proto: {
			initAjax: function () {
				mfp.types.push(AJAX_NS);
				_ajaxCur = mfp.st.ajax.cursor;
				_mfpOn(CLOSE_EVENT + '.' + AJAX_NS, _destroyAjaxRequest);
				_mfpOn('BeforeChange.' + AJAX_NS, _destroyAjaxRequest)
			},
			getAjax: function (item) {
				if (_ajaxCur)
					_body.addClass(_ajaxCur);
				mfp.updateStatus('loading');
				var opts = $.extend({
					url: item.src,
					success: function (data, textStatus, jqXHR) {
						var temp = {
							data: data,
							xhr: jqXHR
						};
						_mfpTrigger('ParseAjax', temp);
						mfp.appendContent($(temp.data), AJAX_NS);
						item.finished = true;
						_removeAjaxCursor();
						mfp._setFocus();
						setTimeout(function () {
							mfp.wrap.addClass(READY_CLASS)
						}, 16);
						mfp.updateStatus('ready');
						_mfpTrigger('AjaxContentAdded')
					},
					error: function () {
						_removeAjaxCursor();
						item.finished = item.loadError = true;
						mfp.updateStatus('error', mfp.st.ajax.tError.replace('%url%', item.src))
					}
				}, mfp.st.ajax.settings);
				mfp.req = $.ajax(opts);
				return ''
			}
		}
	});
	var _imgInterval, _getTitle = function (item) {
		if (item.data && item.data.title !== undefined)
			return item.data.title;
		var src = mfp.st.image.titleSrc;
		if (src) {
			if ($.isFunction(src)) {
				return src.call(mfp, item)
			} else if (item.el) {
				return item.el.attr(src) || ''
			}
		}
		return ''
	};
	$.magnificPopup.registerModule('image', {
		options: {
			markup: '<div class="mfp-figure">' + '<div class="mfp-close"></div>' + '<figure>' + '<div class="mfp-img"></div>' + '<figcaption>' + '<div class="mfp-bottom-bar">' + '<div class="mfp-title"></div>' + '<div class="mfp-counter"></div>' + '</div>' + '</figcaption>' + '</figure>' + '</div>',
			cursor: 'mfp-zoom-out-cur',
			titleSrc: 'title',
			verticalFit: true,
			tError: '<a href="%url%">The image</a> could not be loaded.'
		},
		proto: {
			initImage: function () {
				var imgSt = mfp.st.image
					, ns = '.image';
				mfp.types.push('image');
				_mfpOn(OPEN_EVENT + ns, function () {
					if (mfp.currItem.type === 'image' && imgSt.cursor) {
						_body.addClass(imgSt.cursor)
					}
				});
				_mfpOn(CLOSE_EVENT + ns, function () {
					if (imgSt.cursor) {
						_body.removeClass(imgSt.cursor)
					}
					_window.off('resize' + EVENT_NS)
				});
				_mfpOn('Resize' + ns, mfp.resizeImage);
				if (mfp.isLowIE) {
					_mfpOn('AfterChange', mfp.resizeImage)
				}
			},
			resizeImage: function () {
				var item = mfp.currItem;
				if (!item || !item.img)
					return;
				if (mfp.st.image.verticalFit) {
					var decr = 0;
					if (mfp.isLowIE) {
						decr = parseInt(item.img.css('padding-top'), 10) + parseInt(item.img.css('padding-bottom'), 10)
					}
					item.img.css('max-height', mfp.wH - decr)
				}
			},
			_onImageHasSize: function (item) {
				if (item.img) {
					item.hasSize = true;
					if (_imgInterval) {
						clearInterval(_imgInterval)
					}
					item.isCheckingImgSize = false;
					_mfpTrigger('ImageHasSize', item);
					if (item.imgHidden) {
						if (mfp.content)
							mfp.content.removeClass('mfp-loading');
						item.imgHidden = false
					}
				}
			},
			findImageSize: function (item) {
				var counter = 0
					, img = item.img[0]
					, mfpSetInterval = function (delay) {
						if (_imgInterval) {
							clearInterval(_imgInterval)
						}
						_imgInterval = setInterval(function () {
							if (img.naturalWidth > 0) {
								mfp._onImageHasSize(item);
								return
							}
							if (counter > 200) {
								clearInterval(_imgInterval)
							}
							counter++;
							if (counter === 3) {
								mfpSetInterval(10)
							} else if (counter === 40) {
								mfpSetInterval(50)
							} else if (counter === 100) {
								mfpSetInterval(500)
							}
						}, delay)
					};
				mfpSetInterval(1)
			},
			getImage: function (item, template) {
				var guard = 0
					, onLoadComplete = function () {
						if (item) {
							if (item.img[0].complete) {
								item.img.off('.mfploader');
								if (item === mfp.currItem) {
									mfp._onImageHasSize(item);
									mfp.updateStatus('ready')
								}
								item.hasSize = true;
								item.loaded = true;
								_mfpTrigger('ImageLoadComplete')
							} else {
								guard++;
								if (guard < 200) {
									setTimeout(onLoadComplete, 100)
								} else {
									onLoadError()
								}
							}
						}
					}
					, onLoadError = function () {
						if (item) {
							item.img.off('.mfploader');
							if (item === mfp.currItem) {
								mfp._onImageHasSize(item);
								mfp.updateStatus('error', imgSt.tError.replace('%url%', item.src))
							}
							item.hasSize = true;
							item.loaded = true;
							item.loadError = true
						}
					}
					, imgSt = mfp.st.image;
				var el = template.find('.mfp-img');
				if (el.length) {
					var img = document.createElement('img');
					img.className = 'mfp-img';
					if (item.el && item.el.find('img').length) {
						img.alt = item.el.find('img').attr('alt')
					}
					item.img = $(img).on('load.mfploader', onLoadComplete).on('error.mfploader', onLoadError);
					img.src = item.src;
					if (el.is('img')) {
						item.img = item.img.clone()
					}
					img = item.img[0];
					if (img.naturalWidth > 0) {
						item.hasSize = true
					} else if (!img.width) {
						item.hasSize = false
					}
				}
				mfp._parseMarkup(template, {
					title: _getTitle(item),
					img_replaceWith: item.img
				}, item);
				mfp.resizeImage();
				if (item.hasSize) {
					if (_imgInterval)
						clearInterval(_imgInterval);
					if (item.loadError) {
						template.addClass('mfp-loading');
						mfp.updateStatus('error', imgSt.tError.replace('%url%', item.src))
					} else {
						template.removeClass('mfp-loading');
						mfp.updateStatus('ready')
					}
					return template
				}
				mfp.updateStatus('loading');
				item.loading = true;
				if (!item.hasSize) {
					item.imgHidden = true;
					template.addClass('mfp-loading');
					mfp.findImageSize(item)
				}
				return template
			}
		}
	});
	var hasMozTransform, getHasMozTransform = function () {
		if (hasMozTransform === undefined) {
			hasMozTransform = document.createElement('p').style.MozTransform !== undefined
		}
		return hasMozTransform
	};
	$.magnificPopup.registerModule('zoom', {
		options: {
			enabled: false,
			easing: 'ease-in-out',
			duration: 300,
			opener: function (element) {
				return element.is('img') ? element : element.find('img')
			}
		},
		proto: {
			initZoom: function () {
				var zoomSt = mfp.st.zoom, ns = '.zoom', image;
				if (!zoomSt.enabled || !mfp.supportsTransition) {
					return
				}
				var duration = zoomSt.duration, getElToAnimate = function (image) {
					var newImg = image.clone().removeAttr('style').removeAttr('class').addClass('mfp-animated-image')
						, transition = 'all ' + (zoomSt.duration / 1000) + 's ' + zoomSt.easing
						, cssObj = {
							position: 'fixed',
							zIndex: 9999,
							left: 0,
							top: 0,
							'-webkit-backface-visibility': 'hidden'
						}
						, t = 'transition';
					cssObj['-webkit-' + t] = cssObj['-moz-' + t] = cssObj['-o-' + t] = cssObj[t] = transition;
					newImg.css(cssObj);
					return newImg
				}, showMainContent = function () {
					mfp.content.css('visibility', 'visible')
				}, openTimeout, animatedImg;
				_mfpOn('BuildControls' + ns, function () {
					if (mfp._allowZoom()) {
						clearTimeout(openTimeout);
						mfp.content.css('visibility', 'hidden');
						image = mfp._getItemToZoom();
						if (!image) {
							showMainContent();
							return
						}
						animatedImg = getElToAnimate(image);
						animatedImg.css(mfp._getOffset());
						mfp.wrap.append(animatedImg);
						openTimeout = setTimeout(function () {
							animatedImg.css(mfp._getOffset(true));
							openTimeout = setTimeout(function () {
								showMainContent();
								setTimeout(function () {
									animatedImg.remove();
									image = animatedImg = null;
									_mfpTrigger('ZoomAnimationEnded')
								}, 16)
							}, duration)
						}, 16)
					}
				});
				_mfpOn(BEFORE_CLOSE_EVENT + ns, function () {
					if (mfp._allowZoom()) {
						clearTimeout(openTimeout);
						mfp.st.removalDelay = duration;
						if (!image) {
							image = mfp._getItemToZoom();
							if (!image) {
								return
							}
							animatedImg = getElToAnimate(image)
						}
						animatedImg.css(mfp._getOffset(true));
						mfp.wrap.append(animatedImg);
						mfp.content.css('visibility', 'hidden');
						setTimeout(function () {
							animatedImg.css(mfp._getOffset())
						}, 16)
					}
				});
				_mfpOn(CLOSE_EVENT + ns, function () {
					if (mfp._allowZoom()) {
						showMainContent();
						if (animatedImg) {
							animatedImg.remove()
						}
						image = null
					}
				})
			},
			_allowZoom: function () {
				return mfp.currItem.type === 'image'
			},
			_getItemToZoom: function () {
				if (mfp.currItem.hasSize) {
					return mfp.currItem.img
				} else {
					return false
				}
			},
			_getOffset: function (isLarge) {
				var el;
				if (isLarge) {
					el = mfp.currItem.img
				} else {
					el = mfp.st.zoom.opener(mfp.currItem.el || mfp.currItem)
				}
				var offset = el.offset();
				var paddingTop = parseInt(el.css('padding-top'), 10);
				var paddingBottom = parseInt(el.css('padding-bottom'), 10);
				offset.top -= ($(window).scrollTop() - paddingTop);
				var obj = {
					width: el.width(),
					height: (_isJQ ? el.innerHeight() : el[0].offsetHeight) - paddingBottom - paddingTop
				};
				if (getHasMozTransform()) {
					obj['-moz-transform'] = obj['transform'] = 'translate(' + offset.left + 'px,' + offset.top + 'px)'
				} else {
					obj.left = offset.left;
					obj.top = offset.top
				}
				return obj
			}
		}
	});
	var IFRAME_NS = 'iframe'
		, _emptyPage = '//about:blank'
		, _fixIframeBugs = function (isShowing) {
			if (mfp.currTemplate[IFRAME_NS]) {
				var el = mfp.currTemplate[IFRAME_NS].find('iframe');
				if (el.length) {
					if (!isShowing) {
						el[0].src = _emptyPage
					}
					if (mfp.isIE8) {
						el.css('display', isShowing ? 'block' : 'none')
					}
				}
			}
		};
	$.magnificPopup.registerModule(IFRAME_NS, {
		options: {
			markup: '<div class="mfp-iframe-scaler">' + '<div class="mfp-close"></div>' + '<iframe class="mfp-iframe" src="//about:blank" frameborder="0" allowfullscreen></iframe>' + '</div>',
			srcAction: 'iframe_src',
			patterns: {
				youtube: {
					index: 'youtube.com',
					id: 'v=',
					src: '//www.youtube.com/embed/%id%?autoplay=1'
				},
				vimeo: {
					index: 'vimeo.com/',
					id: '/',
					src: '//player.vimeo.com/video/%id%?autoplay=1'
				},
				gmaps: {
					index: '//maps.google.',
					src: '%id%&output=embed'
				}
			}
		},
		proto: {
			initIframe: function () {
				mfp.types.push(IFRAME_NS);
				_mfpOn('BeforeChange', function (e, prevType, newType) {
					if (prevType !== newType) {
						if (prevType === IFRAME_NS) {
							_fixIframeBugs()
						} else if (newType === IFRAME_NS) {
							_fixIframeBugs(true)
						}
					}
				});
				_mfpOn(CLOSE_EVENT + '.' + IFRAME_NS, function () {
					_fixIframeBugs()
				})
			},
			getIframe: function (item, template) {
				var embedSrc = item.src;
				var iframeSt = mfp.st.iframe;
				$.each(iframeSt.patterns, function () {
					if (embedSrc.indexOf(this.index) > -1) {
						if (this.id) {
							if (typeof this.id === 'string') {
								embedSrc = embedSrc.substr(embedSrc.lastIndexOf(this.id) + this.id.length, embedSrc.length)
							} else {
								embedSrc = this.id.call(this, embedSrc)
							}
						}
						embedSrc = this.src.replace('%id%', embedSrc);
						return false
					}
				});
				var dataObj = {};
				if (iframeSt.srcAction) {
					dataObj[iframeSt.srcAction] = embedSrc
				}
				mfp._parseMarkup(template, dataObj, item);
				mfp.updateStatus('ready');
				return template
			}
		}
	});
	var _getLoopedId = function (index) {
		var numSlides = mfp.items.length;
		if (index > numSlides - 1) {
			return index - numSlides
		} else if (index < 0) {
			return numSlides + index
		}
		return index
	}
		, _replaceCurrTotal = function (text, curr, total) {
			return text.replace(/%curr%/gi, curr + 1).replace(/%total%/gi, total)
		};
	$.magnificPopup.registerModule('gallery', {
		options: {
			enabled: false,
			arrowMarkup: '<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>',
			preload: [0, 2],
			navigateByImgClick: true,
			arrows: true,
			tPrev: 'Previous (Left arrow key)',
			tNext: 'Next (Right arrow key)',
			tCounter: '%curr% of %total%'
		},
		proto: {
			initGallery: function () {
				var gSt = mfp.st.gallery
					, ns = '.mfp-gallery'
					, supportsFastClick = Boolean($.fn.mfpFastClick);
				mfp.direction = true;
				if (!gSt || !gSt.enabled)
					return false;
				_wrapClasses += ' mfp-gallery';
				_mfpOn(OPEN_EVENT + ns, function () {
					if (gSt.navigateByImgClick) {
						mfp.wrap.on('click' + ns, '.mfp-img', function () {
							if (mfp.items.length > 1) {
								mfp.next();
								return false
							}
						})
					}
					_document.on('keydown' + ns, function (e) {
						if (e.keyCode === 37) {
							mfp.prev()
						} else if (e.keyCode === 39) {
							mfp.next()
						}
					})
				});
				_mfpOn('UpdateStatus' + ns, function (e, data) {
					if (data.text) {
						data.text = _replaceCurrTotal(data.text, mfp.currItem.index, mfp.items.length)
					}
				});
				_mfpOn(MARKUP_PARSE_EVENT + ns, function (e, element, values, item) {
					var l = mfp.items.length;
					values.counter = l > 1 ? _replaceCurrTotal(gSt.tCounter, item.index, l) : ''
				});
				_mfpOn('BuildControls' + ns, function () {
					if (mfp.items.length > 1 && gSt.arrows && !mfp.arrowLeft) {
						var markup = gSt.arrowMarkup
							, arrowLeft = mfp.arrowLeft = $(markup.replace(/%title%/gi, gSt.tPrev).replace(/%dir%/gi, 'left')).addClass(PREVENT_CLOSE_CLASS)
							, arrowRight = mfp.arrowRight = $(markup.replace(/%title%/gi, gSt.tNext).replace(/%dir%/gi, 'right')).addClass(PREVENT_CLOSE_CLASS);
						var eName = supportsFastClick ? 'mfpFastClick' : 'click';
						arrowLeft[eName](function () {
							mfp.prev()
						});
						arrowRight[eName](function () {
							mfp.next()
						});
						if (mfp.isIE7) {
							_getEl('b', arrowLeft[0], false, true);
							_getEl('a', arrowLeft[0], false, true);
							_getEl('b', arrowRight[0], false, true);
							_getEl('a', arrowRight[0], false, true)
						}
						mfp.container.append(arrowLeft.add(arrowRight))
					}
				});
				_mfpOn(CHANGE_EVENT + ns, function () {
					if (mfp._preloadTimeout)
						clearTimeout(mfp._preloadTimeout);
					mfp._preloadTimeout = setTimeout(function () {
						mfp.preloadNearbyImages();
						mfp._preloadTimeout = null
					}, 16)
				});
				_mfpOn(CLOSE_EVENT + ns, function () {
					_document.off(ns);
					mfp.wrap.off('click' + ns);
					if (mfp.arrowLeft && supportsFastClick) {
						mfp.arrowLeft.add(mfp.arrowRight).destroyMfpFastClick()
					}
					mfp.arrowRight = mfp.arrowLeft = null
				})
			},
			next: function () {
				mfp.direction = true;
				mfp.index = _getLoopedId(mfp.index + 1);
				mfp.updateItemHTML()
			},
			prev: function () {
				mfp.direction = false;
				mfp.index = _getLoopedId(mfp.index - 1);
				mfp.updateItemHTML()
			},
			goTo: function (newIndex) {
				mfp.direction = (newIndex >= mfp.index);
				mfp.index = newIndex;
				mfp.updateItemHTML()
			},
			preloadNearbyImages: function () {
				var p = mfp.st.gallery.preload, preloadBefore = Math.min(p[0], mfp.items.length), preloadAfter = Math.min(p[1], mfp.items.length), i;
				for (i = 1; i <= (mfp.direction ? preloadAfter : preloadBefore); i++) {
					mfp._preloadItem(mfp.index + i)
				}
				for (i = 1; i <= (mfp.direction ? preloadBefore : preloadAfter); i++) {
					mfp._preloadItem(mfp.index - i)
				}
			},
			_preloadItem: function (index) {
				index = _getLoopedId(index);
				if (mfp.items[index].preloaded) {
					return
				}
				var item = mfp.items[index];
				if (!item.parsed) {
					item = mfp.parseEl(index)
				}
				_mfpTrigger('LazyLoad', item);
				if (item.type === 'image') {
					item.img = $('<img class="mfp-img" />').on('load.mfploader', function () {
						item.hasSize = true
					}).on('error.mfploader', function () {
						item.hasSize = true;
						item.loadError = true;
						_mfpTrigger('LazyLoadError', item)
					}).attr('src', item.src)
				}
				item.preloaded = true
			}
		}
	});
	var RETINA_NS = 'retina';
	$.magnificPopup.registerModule(RETINA_NS, {
		options: {
			replaceSrc: function (item) {
				return item.src.replace(/\.\w+$/, function (m) {
					return '@2x' + m
				})
			},
			ratio: 1
		},
		proto: {
			initRetina: function () {
				if (window.devicePixelRatio > 1) {
					var st = mfp.st.retina
						, ratio = st.ratio;
					ratio = !isNaN(ratio) ? ratio : ratio();
					if (ratio > 1) {
						_mfpOn('ImageHasSize' + '.' + RETINA_NS, function (e, item) {
							item.img.css({
								'max-width': item.img[0].naturalWidth / ratio,
								'width': '100%'
							})
						});
						_mfpOn('ElementParse' + '.' + RETINA_NS, function (e, item) {
							item.src = st.replaceSrc(item, ratio)
						})
					}
				}
			}
		}
	});
	(function () {
		var ghostClickDelay = 1000
			, supportsTouch = 'ontouchstart' in window
			, unbindTouchMove = function () {
				_window.off('touchmove' + ns + ' touchend' + ns)
			}
			, eName = 'mfpFastClick'
			, ns = '.' + eName;
		$.fn.mfpFastClick = function (callback) {
			return $(this).each(function () {
				var elem = $(this), lock;
				if (supportsTouch) {
					var timeout, startX, startY, pointerMoved, point, numPointers;
					elem.on('touchstart' + ns, function (e) {
						pointerMoved = false;
						numPointers = 1;
						point = e.originalEvent ? e.originalEvent.touches[0] : e.touches[0];
						startX = point.clientX;
						startY = point.clientY;
						_window.on('touchmove' + ns, function (e) {
							point = e.originalEvent ? e.originalEvent.touches : e.touches;
							numPointers = point.length;
							point = point[0];
							if (Math.abs(point.clientX - startX) > 10 || Math.abs(point.clientY - startY) > 10) {
								pointerMoved = true;
								unbindTouchMove()
							}
						}).on('touchend' + ns, function (e) {
							unbindTouchMove();
							if (pointerMoved || numPointers > 1) {
								return
							}
							lock = true;
							e.preventDefault();
							clearTimeout(timeout);
							timeout = setTimeout(function () {
								lock = false
							}, ghostClickDelay);
							callback()
						})
					})
				}
				elem.on('click' + ns, function () {
					if (!lock) {
						callback()
					}
				})
			})
		}
			;
		$.fn.destroyMfpFastClick = function () {
			$(this).off('touchstart' + ns + ' click' + ns);
			if (supportsTouch)
				_window.off('touchmove' + ns + ' touchend' + ns)
		}
	})();
	_checkInstance()
}));
jQuery.easing['jswing'] = jQuery.easing['swing'];
jQuery.extend(jQuery.easing, {
	def: 'easeOutQuad',
	swing: function (x, t, b, c, d) {
		return jQuery.easing[jQuery.easing.def](x, t, b, c, d)
	},
	easeInQuad: function (x, t, b, c, d) {
		return c * (t /= d) * t + b
	},
	easeOutQuad: function (x, t, b, c, d) {
		return -c * (t /= d) * (t - 2) + b
	},
	easeInOutQuad: function (x, t, b, c, d) {
		if ((t /= d / 2) < 1)
			return c / 2 * t * t + b;
		return -c / 2 * ((--t) * (t - 2) - 1) + b
	},
	easeInCubic: function (x, t, b, c, d) {
		return c * (t /= d) * t * t + b
	},
	easeOutCubic: function (x, t, b, c, d) {
		return c * ((t = t / d - 1) * t * t + 1) + b
	},
	easeInOutCubic: function (x, t, b, c, d) {
		if ((t /= d / 2) < 1)
			return c / 2 * t * t * t + b;
		return c / 2 * ((t -= 2) * t * t + 2) + b
	},
	easeInQuart: function (x, t, b, c, d) {
		return c * (t /= d) * t * t * t + b
	},
	easeOutQuart: function (x, t, b, c, d) {
		return -c * ((t = t / d - 1) * t * t * t - 1) + b
	},
	easeInOutQuart: function (x, t, b, c, d) {
		if ((t /= d / 2) < 1)
			return c / 2 * t * t * t * t + b;
		return -c / 2 * ((t -= 2) * t * t * t - 2) + b
	},
	easeInQuint: function (x, t, b, c, d) {
		return c * (t /= d) * t * t * t * t + b
	},
	easeOutQuint: function (x, t, b, c, d) {
		return c * ((t = t / d - 1) * t * t * t * t + 1) + b
	},
	easeInOutQuint: function (x, t, b, c, d) {
		if ((t /= d / 2) < 1)
			return c / 2 * t * t * t * t * t + b;
		return c / 2 * ((t -= 2) * t * t * t * t + 2) + b
	},
	easeInSine: function (x, t, b, c, d) {
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + b
	},
	easeOutSine: function (x, t, b, c, d) {
		return c * Math.sin(t / d * (Math.PI / 2)) + b
	},
	easeInOutSine: function (x, t, b, c, d) {
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b
	},
	easeInExpo: function (x, t, b, c, d) {
		return (t == 0) ? b : c * Math.pow(2, 10 * (t / d - 1)) + b
	},
	easeOutExpo: function (x, t, b, c, d) {
		return (t == d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b
	},
	easeInOutExpo: function (x, t, b, c, d) {
		if (t == 0)
			return b;
		if (t == d)
			return b + c;
		if ((t /= d / 2) < 1)
			return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
		return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b
	},
	easeInCirc: function (x, t, b, c, d) {
		return -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b
	},
	easeOutCirc: function (x, t, b, c, d) {
		return c * Math.sqrt(1 - (t = t / d - 1) * t) + b
	},
	easeInOutCirc: function (x, t, b, c, d) {
		if ((t /= d / 2) < 1)
			return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
		return c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b
	},
	easeInElastic: function (x, t, b, c, d) {
		var s = 1.70158;
		var p = 0;
		var a = c;
		if (t == 0)
			return b;
		if ((t /= d) == 1)
			return b + c;
		if (!p)
			p = d * .3;
		if (a < Math.abs(c)) {
			a = c;
			var s = p / 4
		} else
			var s = p / (2 * Math.PI) * Math.asin(c / a);
		return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b
	},
	easeOutElastic: function (x, t, b, c, d) {
		var s = 1.70158;
		var p = 0;
		var a = c;
		if (t == 0)
			return b;
		if ((t /= d) == 1)
			return b + c;
		if (!p)
			p = d * .3;
		if (a < Math.abs(c)) {
			a = c;
			var s = p / 4
		} else
			var s = p / (2 * Math.PI) * Math.asin(c / a);
		return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b
	},
	easeInOutElastic: function (x, t, b, c, d) {
		var s = 1.70158;
		var p = 0;
		var a = c;
		if (t == 0)
			return b;
		if ((t /= d / 2) == 2)
			return b + c;
		if (!p)
			p = d * (.3 * 1.5);
		if (a < Math.abs(c)) {
			a = c;
			var s = p / 4
		} else
			var s = p / (2 * Math.PI) * Math.asin(c / a);
		if (t < 1)
			return -.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
		return a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * .5 + c + b
	},
	easeInBack: function (x, t, b, c, d, s) {
		if (s == undefined)
			s = 1.70158;
		return c * (t /= d) * t * ((s + 1) * t - s) + b
	},
	easeOutBack: function (x, t, b, c, d, s) {
		if (s == undefined)
			s = 1.70158;
		return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b
	},
	easeInOutBack: function (x, t, b, c, d, s) {
		if (s == undefined)
			s = 1.70158;
		if ((t /= d / 2) < 1)
			return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b;
		return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b
	},
	easeInBounce: function (x, t, b, c, d) {
		return c - jQuery.easing.easeOutBounce(x, d - t, 0, c, d) + b
	},
	easeOutBounce: function (x, t, b, c, d) {
		if ((t /= d) < (1 / 2.75)) {
			return c * (7.5625 * t * t) + b
		} else if (t < (2 / 2.75)) {
			return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b
		} else if (t < (2.5 / 2.75)) {
			return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b
		} else {
			return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b
		}
	},
	easeInOutBounce: function (x, t, b, c, d) {
		if (t < d / 2)
			return jQuery.easing.easeInBounce(x, t * 2, 0, c, d) * .5 + b;
		return jQuery.easing.easeOutBounce(x, t * 2 - d, 0, c, d) * .5 + c * .5 + b
	}
});
(function ($) {
	$.fn.appear = function (fn, options) {
		var settings = $.extend({
			data: undefined,
			one: true,
			accX: 0,
			accY: 0
		}, options);
		return this.each(function () {
			var t = $(this);
			t.appeared = false;
			if (!fn) {
				t.trigger('appear', settings.data);
				return
			}
			var w = $(window);
			var check = function () {
				if (!t.is(':visible')) {
					t.appeared = false;
					return
				}
				var a = w.scrollLeft();
				var b = w.scrollTop();
				var o = t.offset();
				var x = o.left;
				var y = o.top;
				var ax = settings.accX;
				var ay = settings.accY;
				var th = t.height();
				var wh = w.height();
				var tw = t.width();
				var ww = w.width();
				if (y + th + ay >= b && y <= b + wh + ay && x + tw + ax >= a && x <= a + ww + ax) {
					if (!t.appeared)
						t.trigger('appear', settings.data)
				} else {
					t.appeared = false
				}
			};
			var modifiedFn = function () {
				t.appeared = true;
				if (settings.one) {
					w.unbind('scroll', check);
					var i = $.inArray(check, $.fn.appear.checks);
					if (i >= 0)
						$.fn.appear.checks.splice(i, 1)
				}
				fn.apply(this, arguments)
			};
			if (settings.one)
				t.one('appear', settings.data, modifiedFn);
			else
				t.bind('appear', settings.data, modifiedFn);
			w.scroll(check);
			$.fn.appear.checks.push(check);
			(check)()
		})
	}
		;
	$.extend($.fn.appear, {
		checks: [],
		timeout: null,
		checkAll: function () {
			var length = $.fn.appear.checks.length;
			if (length > 0)
				while (length--)
					($.fn.appear.checks[length])()
		},
		run: function () {
			if ($.fn.appear.timeout)
				clearTimeout($.fn.appear.timeout);
			$.fn.appear.timeout = setTimeout($.fn.appear.checkAll, 20)
		}
	});
	$.each(['append', 'prepend', 'after', 'before', 'attr', 'removeAttr', 'addClass', 'removeClass', 'toggleClass', 'remove', 'css', 'show', 'hide'], function (i, n) {
		var old = $.fn[n];
		if (old) {
			$.fn[n] = function () {
				var r = old.apply(this, arguments);
				$.fn.appear.run();
				return r
			}
		}
	})
})(jQuery);
(function ($) {
	$.fn.gMap = function (options, methods_options) {
		switch (options) {
			case 'addMarker':
				return $(this).trigger('gMap.addMarker', [methods_options.latitude, methods_options.longitude, methods_options.content, methods_options.icon, methods_options.popup]);
			case 'centerAt':
				return $(this).trigger('gMap.centerAt', [methods_options.latitude, methods_options.longitude, methods_options.zoom]);
			case 'clearMarkers':
				return $(this).trigger('gMap.clearMarkers')
		}
		var opts = $.extend({}, $.fn.gMap.defaults, options);
		return this.each(function () {
			var $gmap = new google.maps.Map(this);
			$(this).data('gMap.reference', $gmap);
			var $geocoder = new google.maps.Geocoder();
			if (opts.address) {
				$geocoder.geocode({
					address: opts.address
				}, function (gresult, status) {
					if (gresult && gresult.length) {
						$gmap.setCenter(gresult[0].geometry.location)
					}
				})
			} else {
				if (opts.latitude && opts.longitude) {
					$gmap.setCenter(new google.maps.LatLng(opts.latitude, opts.longitude))
				} else {
					if ($.isArray(opts.markers) && opts.markers.length > 0) {
						if (opts.markers[0].address) {
							$geocoder.geocode({
								address: opts.markers[0].address
							}, function (gresult, status) {
								if (gresult && gresult.length > 0) {
									$gmap.setCenter(gresult[0].geometry.location)
								}
							})
						} else {
							$gmap.setCenter(new google.maps.LatLng(opts.markers[0].latitude, opts.markers[0].longitude))
						}
					} else {
						$gmap.setCenter(new google.maps.LatLng(34.885931, 9.84375))
					}
				}
			}
			$gmap.setZoom(opts.zoom);
			$gmap.setMapTypeId(google.maps.MapTypeId[opts.maptype]);
			var map_options = {
				scrollwheel: opts.scrollwheel,
				disableDoubleClickZoom: !opts.doubleclickzoom
			};
			if (opts.controls === false) {
				$.extend(map_options, {
					disableDefaultUI: true
				})
			} else if (opts.controls.length !== 0) {
				$.extend(map_options, opts.controls, {
					disableDefaultUI: true
				})
			}
			$gmap.setOptions(map_options);
			var gicon = new google.maps.Marker();
			var marker_icon;
			var marker_shadow;
			marker_icon = new google.maps.MarkerImage(opts.icon.image);
			marker_icon.size = new google.maps.Size(opts.icon.iconsize[0], opts.icon.iconsize[1]);
			marker_icon.anchor = new google.maps.Point(opts.icon.iconanchor[0], opts.icon.iconanchor[1]);
			gicon.setIcon(marker_icon);
			if (opts.icon.shadow) {
				marker_shadow = new google.maps.MarkerImage(opts.icon.shadow);
				marker_shadow.size = new google.maps.Size(opts.icon.shadowsize[0], opts.icon.shadowsize[1]);
				marker_shadow.anchor = new google.maps.Point(opts.icon.shadowanchor[0], opts.icon.shadowanchor[1]);
				gicon.setShadow(marker_shadow)
			}
			$(this).bind('gMap.centerAt', function (e, latitude, longitude, zoom) {
				if (zoom) {
					$gmap.setZoom(zoom)
				}
				$gmap.panTo(new google.maps.LatLng(parseFloat(latitude), parseFloat(longitude)))
			});
			var overlays = [];
			$(this).bind('gMap.clearMarkers', function () {
				while (overlays[0]) {
					overlays.pop().setMap(null)
				}
			});
			var last_infowindow;
			$(this).bind('gMap.addMarker', function (e, latitude, longitude, content, icon, popup) {
				var marker_icon;
				var marker_shadow;
				var glatlng = new google.maps.LatLng(parseFloat(latitude), parseFloat(longitude));
				var gmarker = new google.maps.Marker({
					position: glatlng
				});
				if (icon) {
					marker_icon = new google.maps.MarkerImage(icon.image);
					marker_icon.size = new google.maps.Size(icon.iconsize[0], icon.iconsize[1]);
					marker_icon.anchor = new google.maps.Point(icon.iconanchor[0], icon.iconanchor[1]);
					gmarker.setIcon(marker_icon);
					if (icon.shadow) {
						marker_shadow = new google.maps.MarkerImage(icon.shadow);
						marker_shadow.size = new google.maps.Size(icon.shadowsize[0], icon.shadowsize[1]);
						marker_shadow.anchor = new google.maps.Point(icon.shadowanchor[0], icon.shadowanchor[1]);
						gicon.setShadow(marker_shadow)
					}
				} else {
					gmarker.setIcon(gicon.getIcon());
					gmarker.setShadow(gicon.getShadow())
				}
				if (content) {
					if (content === '_latlng') {
						content = latitude + ', ' + longitude
					}
					var infowindow = new google.maps.InfoWindow({
						content: opts.html_prepend + content + opts.html_append
					});
					google.maps.event.addListener(gmarker, 'click', function () {
						if (last_infowindow) {
							last_infowindow.close()
						}
						infowindow.open($gmap, gmarker);
						last_infowindow = infowindow
					});
					if (popup) {
						google.maps.event.addListenerOnce($gmap, 'tilesloaded', function () {
							infowindow.open($gmap, gmarker)
						})
					}
				}
				gmarker.setMap($gmap);
				overlays.push(gmarker)
			});
			var marker;
			var self = this;
			var geocode_callback = function (marker) {
				return function (gresult, status) {
					if (gresult && gresult.length > 0) {
						$(self).trigger('gMap.addMarker', [gresult[0].geometry.location.lat(), gresult[0].geometry.location.lng(), marker.html, marker.icon, marker.popup])
					}
				}
			};
			for (var j = 0; j < opts.markers.length; j++) {
				marker = opts.markers[j];
				if (marker.address) {
					if (marker.html === '_address') {
						marker.html = marker.address
					}
					$geocoder.geocode({
						address: marker.address
					}, geocode_callback(marker))
				} else {
					$(this).trigger('gMap.addMarker', [marker.latitude, marker.longitude, marker.html, marker.icon, marker.popup])
				}
			}
		})
	}
		;
	$.fn.gMap.defaults = {
		address: '',
		latitude: 0,
		longitude: 0,
		zoom: 1,
		markers: [],
		controls: [],
		scrollwheel: false,
		doubleclickzoom: true,
		maptype: 'ROADMAP',
		html_prepend: '<div class="gmap_marker">',
		html_append: '</div>',
		icon: {
			image: "http://www.google.com/mapfiles/marker.png",
			shadow: "http://www.google.com/mapfiles/shadow50.png",
			iconsize: [20, 34],
			shadowsize: [37, 34],
			iconanchor: [9, 34],
			shadowanchor: [6, 34]
		}
	}
})(jQuery);
(function ($) {
	$.extend({
		browserSelector: function () {
			(function (a) {
				(jQuery.browser = jQuery.browser || {}).mobile = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))
			})(navigator.userAgent || navigator.vendor || window.opera);
			var u = navigator.userAgent
				, ua = u.toLowerCase()
				, is = function (t) {
					return ua.indexOf(t) > -1
				}
				, g = 'gecko'
				, w = 'webkit'
				, s = 'safari'
				, o = 'opera'
				, h = document.documentElement
				, b = [(!(/opera|webtv/i.test(ua)) && /msie\s(\d)/.test(ua)) ? ('ie ie' + parseFloat(navigator.appVersion.split("MSIE")[1])) : is('firefox/2') ? g + ' ff2' : is('firefox/3.5') ? g + ' ff3 ff3_5' : is('firefox/3') ? g + ' ff3' : is('gecko/') ? g : is('opera') ? o + (/version\/(\d+)/.test(ua) ? ' ' + o + RegExp.jQuery1 : (/opera(\s|\/)(\d+)/.test(ua) ? ' ' + o + RegExp.jQuery2 : '')) : is('konqueror') ? 'konqueror' : is('chrome') ? w + ' chrome' : is('iron') ? w + ' iron' : is('applewebkit/') ? w + ' ' + s + (/version\/(\d+)/.test(ua) ? ' ' + s + RegExp.jQuery1 : '') : is('mozilla/') ? g : '', is('j2me') ? 'mobile' : is('iphone') ? 'iphone' : is('ipod') ? 'ipod' : is('mac') ? 'mac' : is('darwin') ? 'mac' : is('webtv') ? 'webtv' : is('win') ? 'win' : is('freebsd') ? 'freebsd' : (is('x11') || is('linux')) ? 'linux' : '', 'js'];
			c = b.join(' ');
			if ($.browser.mobile) {
				c += ' mobile'
			}
			h.className += ' ' + c;
			var isIE11 = !(window.ActiveXObject) && "ActiveXObject" in window;
			if (isIE11) {
				$('html').removeClass('gecko').addClass('ie ie11');
				return
			}
			if ($('body').hasClass('dark')) {
				$('html').addClass('dark')
			}
			if ($('body').hasClass('boxed')) {
				$('html').addClass('boxed')
			}
		}
	});
	$.browserSelector()
})(jQuery);
