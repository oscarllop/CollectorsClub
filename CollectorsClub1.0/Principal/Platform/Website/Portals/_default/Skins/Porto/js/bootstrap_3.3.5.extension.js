(function (factory) {
	if (typeof define === 'function' && define.amd) {
		define(['jquery'], factory)
	} else if (typeof exports === 'object') {
		module.exports = factory(require('jquery'))
	} else {
		factory(jQuery)
	}
}(function ($) {
	var eventNamespace = 'waitForImages';
	$.waitForImages = {
		hasImageProperties: ['backgroundImage', 'listStyleImage', 'borderImage', 'borderCornerImage', 'cursor'],
		hasImageAttributes: ['srcset']
	};
	$.expr[':'].uncached = function (obj) {
		if (!$(obj).is('img[src][src!=""]')) {
			return false
		}
		return !obj.complete
	}
		;
	$.fn.waitForImages = function () {
		var allImgsLength = 0;
		var allImgsLoaded = 0;
		var deferred = $.Deferred();
		var finishedCallback;
		var eachCallback;
		var waitForAll;
		if ($.isPlainObject(arguments[0])) {
			waitForAll = arguments[0].waitForAll;
			eachCallback = arguments[0].each;
			finishedCallback = arguments[0].finished
		} else {
			if (arguments.length === 1 && $.type(arguments[0]) === 'boolean') {
				waitForAll = arguments[0]
			} else {
				finishedCallback = arguments[0];
				eachCallback = arguments[1];
				waitForAll = arguments[2]
			}
		}
		finishedCallback = finishedCallback || $.noop;
		eachCallback = eachCallback || $.noop;
		waitForAll = !!waitForAll;
		if (!$.isFunction(finishedCallback) || !$.isFunction(eachCallback)) {
			throw new TypeError('An invalid callback was supplied.')
		}
		this.each(function () {
			var obj = $(this);
			var allImgs = [];
			var hasImgProperties = $.waitForImages.hasImageProperties || [];
			var hasImageAttributes = $.waitForImages.hasImageAttributes || [];
			var matchUrl = /url\(\s*(['"]?)(.*?)\1\s*\)/g;
			if (waitForAll) {
				obj.find('*').addBack().each(function () {
					var element = $(this);
					if (element.is('img:uncached')) {
						allImgs.push({
							src: element.attr('src'),
							element: element[0]
						})
					}
					$.each(hasImgProperties, function (i, property) {
						var propertyValue = element.css(property);
						var match;
						if (!propertyValue) {
							return true
						}
						while (match = matchUrl.exec(propertyValue)) {
							allImgs.push({
								src: match[2],
								element: element[0]
							})
						}
					});
					$.each(hasImageAttributes, function (i, attribute) {
						var attributeValue = element.attr(attribute);
						var attributeValues;
						if (!attributeValue) {
							return true
						}
						attributeValues = attributeValue.split(',');
						$.each(attributeValues, function (i, value) {
							value = $.trim(value).split(' ')[0];
							allImgs.push({
								src: value,
								element: element[0]
							})
						})
					})
				})
			} else {
				obj.find('img:uncached').each(function () {
					allImgs.push({
						src: this.src,
						element: this
					})
				})
			}
			allImgsLength = allImgs.length;
			allImgsLoaded = 0;
			if (allImgsLength === 0) {
				finishedCallback.call(obj[0]);
				deferred.resolveWith(obj[0])
			}
			$.each(allImgs, function (i, img) {
				var image = new Image();
				var events = 'load.' + eventNamespace + ' error.' + eventNamespace;
				$(image).one(events, function me(event) {
					var eachArguments = [allImgsLoaded, allImgsLength, event.type == 'load'];
					allImgsLoaded++;
					eachCallback.apply(img.element, eachArguments);
					deferred.notifyWith(img.element, eachArguments);
					$(this).off(events, me);
					if (allImgsLoaded == allImgsLength) {
						finishedCallback.call(obj[0]);
						deferred.resolveWith(obj[0]);
						return false
					}
				});
				image.src = img.src
			})
		});
		return deferred.promise()
	}
}));
(function ($) {
	$.fn.countTo = function (options) {
		options = options || {};
		return $(this).each(function () {
			var settings = $.extend({}, $.fn.countTo.defaults, {
				from: $(this).data('from'),
				to: $(this).data('to'),
				speed: $(this).data('speed'),
				refreshInterval: $(this).data('refresh-interval'),
				decimals: $(this).data('decimals')
			}, options);
			var loops = Math.ceil(settings.speed / settings.refreshInterval)
				, increment = (settings.to - settings.from) / loops;
			var self = this
				, $self = $(this)
				, loopCount = 0
				, value = settings.from
				, data = $self.data('countTo') || {};
			$self.data('countTo', data);
			if (data.interval) {
				clearInterval(data.interval)
			}
			data.interval = setInterval(updateTimer, settings.refreshInterval);
			render(value);
			function updateTimer() {
				value += increment;
				loopCount++;
				render(value);
				if (typeof (settings.onUpdate) == 'function') {
					settings.onUpdate.call(self, value)
				}
				if (loopCount >= loops) {
					$self.removeData('countTo');
					clearInterval(data.interval);
					value = settings.to;
					if (typeof (settings.onComplete) == 'function') {
						settings.onComplete.call(self, value)
					}
				}
			}
			function render(value) {
				var formattedValue = settings.formatter.call(self, value, settings);
				$self.html(formattedValue)
			}
		})
	}
		;
	$.fn.countTo.defaults = {
		from: 0,
		to: 0,
		speed: 1000,
		refreshInterval: 100,
		decimals: 0,
		formatter: formatter,
		onUpdate: null,
		onComplete: null
	};
	function formatter(value, settings) {
		return value.toFixed(settings.decimals)
	}
}(jQuery));
(function ($) {
	"use strict";
	var defaults = {
		action: function () { },
		runOnLoad: false,
		duration: 500
	};
	var settings = defaults, running = false, start;
	var methods = {};
	methods.init = function () {
		for (var i = 0; i <= arguments.length; i++) {
			var arg = arguments[i];
			switch (typeof arg) {
				case "function":
					settings.action = arg;
					break;
				case "boolean":
					settings.runOnLoad = arg;
					break;
				case "number":
					settings.duration = arg;
					break
			}
		}
		return this.each(function () {
			if (settings.runOnLoad) {
				settings.action()
			}
			$(this).resize(function () {
				methods.timedAction.call(this)
			})
		})
	}
		;
	methods.timedAction = function (code, millisec) {
		var doAction = function () {
			var remaining = settings.duration;
			if (running) {
				var elapse = new Date() - start;
				remaining = settings.duration - elapse;
				if (remaining <= 0) {
					clearTimeout(running);
					running = false;
					settings.action();
					return
				}
			}
			wait(remaining)
		};
		var wait = function (time) {
			running = setTimeout(doAction, time)
		};
		start = new Date();
		if (typeof millisec === 'number') {
			settings.duration = millisec
		}
		if (typeof code === 'function') {
			settings.action = code
		}
		if (!running) {
			doAction()
		}
	}
		;
	$.fn.afterResize = function (method) {
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1))
		} else {
			return methods.init.apply(this, arguments)
		}
	}
})(jQuery);
(function ($) {
	$.extend({
		smoothScroll: function () {
			var defaults = {
				frameRate: 60,
				animationTime: 700,
				stepSize: 120,
				pulseAlgorithm: true,
				pulseScale: 10,
				pulseNormalize: 1,
				accelerationDelta: 20,
				accelerationMax: 1,
				keyboardSupport: true,
				arrowScroll: 50,
				touchpadSupport: true,
				fixedBackground: true,
				excluded: ""
			};
			var options = defaults;
			var isExcluded = false;
			var isFrame = false;
			var direction = {
				x: 0,
				y: 0
			};
			var initDone = false;
			var root = document.documentElement;
			var activeElement;
			var observer;
			var deltaBuffer = [120, 120, 120];
			var key = {
				left: 37,
				up: 38,
				right: 39,
				down: 40,
				spacebar: 32,
				pageup: 33,
				pagedown: 34,
				end: 35,
				home: 36
			};
			function initTest() {
				var disableKeyboard = false;
				if (document.URL.indexOf("google.com/reader/view") > -1) {
					disableKeyboard = true
				}
				if (options.excluded) {
					var domains = options.excluded.split(/[,\n] ?/);
					domains.push("mail.google.com");
					for (var i = domains.length; i--;) {
						if (document.URL.indexOf(domains[i]) > -1) {
							observer && observer.disconnect();
							removeEvent("mousewheel", wheel);
							disableKeyboard = true;
							isExcluded = true;
							break
						}
					}
				}
				if (disableKeyboard) {
					removeEvent("keydown", keydown)
				}
				if (options.keyboardSupport && !disableKeyboard) {
					addEvent("keydown", keydown)
				}
			}
			function init() {
				if (!document.body)
					return;
				var body = document.body;
				var html = document.documentElement;
				var windowHeight = window.innerHeight;
				var scrollHeight = body.scrollHeight;
				root = (document.compatMode.indexOf('CSS') >= 0) ? html : body;
				activeElement = body;
				initTest();
				initDone = true;
				if (top != self) {
					isFrame = true
				} else if (scrollHeight > windowHeight && (body.offsetHeight <= windowHeight || html.offsetHeight <= windowHeight)) {
					var pending = false;
					var refresh = function () {
						if (!pending && html.scrollHeight != document.height) {
							pending = true;
							setTimeout(function () {
								html.style.height = document.height + 'px';
								pending = false
							}, 500)
						}
					};
					html.style.height = 'auto';
					setTimeout(refresh, 10);
					var config = {
						attributes: true,
						childList: true,
						characterData: false
					};
					observer = new MutationObserver(refresh);
					observer.observe(body, config);
					if (root.offsetHeight <= windowHeight) {
						var underlay = document.createElement("div");
						underlay.style.clear = "both";
						body.appendChild(underlay)
					}
				}
				if (document.URL.indexOf("mail.google.com") > -1) {
					var s = document.createElement("style");
					s.innerHTML = ".iu { visibility: hidden }";
					(document.getElementsByTagName("head")[0] || html).appendChild(s)
				} else if (document.URL.indexOf("www.facebook.com") > -1) {
					var home_stream = document.getElementById("home_stream");
					home_stream && (home_stream.style.webkitTransform = "translateZ(0)")
				}
				if (!options.fixedBackground && !isExcluded) {
					body.style.backgroundAttachment = "scroll";
					html.style.backgroundAttachment = "scroll"
				}
			}
			var que = [];
			var pending = false;
			var lastScroll = +new Date;
			function scrollArray(elem, left, top, delay) {
				delay || (delay = 1000);
				directionCheck(left, top);
				if (options.accelerationMax != 1) {
					var now = +new Date;
					var elapsed = now - lastScroll;
					if (elapsed < options.accelerationDelta) {
						var factor = (1 + (30 / elapsed)) / 2;
						if (factor > 1) {
							factor = Math.min(factor, options.accelerationMax);
							left *= factor;
							top *= factor
						}
					}
					lastScroll = +new Date
				}
				que.push({
					x: left,
					y: top,
					lastX: (left < 0) ? 0.99 : -0.99,
					lastY: (top < 0) ? 0.99 : -0.99,
					start: +new Date
				});
				if (pending) {
					return
				}
				var scrollWindow = (elem === document.body);
				var step = function (time) {
					var now = +new Date;
					var scrollX = 0;
					var scrollY = 0;
					for (var i = 0; i < que.length; i++) {
						var item = que[i];
						var elapsed = now - item.start;
						var finished = (elapsed >= options.animationTime);
						var position = (finished) ? 1 : elapsed / options.animationTime;
						if (options.pulseAlgorithm) {
							position = pulse(position)
						}
						var x = (item.x * position - item.lastX) >> 0;
						var y = (item.y * position - item.lastY) >> 0;
						scrollX += x;
						scrollY += y;
						item.lastX += x;
						item.lastY += y;
						if (finished) {
							que.splice(i, 1);
							i--
						}
					}
					if (scrollWindow) {
						window.scrollBy(scrollX, scrollY)
					} else {
						if (scrollX)
							elem.scrollLeft += scrollX;
						if (scrollY)
							elem.scrollTop += scrollY
					}
					if (!left && !top) {
						que = []
					}
					if (que.length) {
						requestFrame(step, elem, (delay / options.frameRate + 1))
					} else {
						pending = false
					}
				};
				requestFrame(step, elem, 0);
				pending = true
			}
			function wheel(event) {
				if (!initDone) {
					init()
				}
				var target = event.target;
				var overflowing = overflowingAncestor(target);
				if (!overflowing || event.defaultPrevented || isNodeName(activeElement, "embed") || (isNodeName(target, "embed") && /\.pdf/i.test(target.src))) {
					return true
				}
				var deltaX = event.wheelDeltaX || 0;
				var deltaY = event.wheelDeltaY || 0;
				if (!deltaX && !deltaY) {
					deltaY = event.wheelDelta || 0
				}
				if (!options.touchpadSupport && isTouchpad(deltaY)) {
					return true
				}
				if (Math.abs(deltaX) > 1.2) {
					deltaX *= options.stepSize / 120
				}
				if (Math.abs(deltaY) > 1.2) {
					deltaY *= options.stepSize / 120
				}
				scrollArray(overflowing, -deltaX, -deltaY);
				event.preventDefault()
			}
			function keydown(event) {
				var target = event.target;
				var modifier = event.ctrlKey || event.altKey || event.metaKey || (event.shiftKey && event.keyCode !== key.spacebar);
				if (/input|textarea|select|embed/i.test(target.nodeName) || target.isContentEditable || event.defaultPrevented || modifier) {
					return true
				}
				if (isNodeName(target, "button") && event.keyCode === key.spacebar) {
					return true
				}
				var shift, x = 0, y = 0;
				var elem = overflowingAncestor(activeElement);
				var clientHeight = elem.clientHeight;
				if (elem == document.body) {
					clientHeight = window.innerHeight
				}
				switch (event.keyCode) {
					case key.up:
						y = -options.arrowScroll;
						break;
					case key.down:
						y = options.arrowScroll;
						break;
					case key.spacebar:
						shift = event.shiftKey ? 1 : -1;
						y = -shift * clientHeight * 0.9;
						break;
					case key.pageup:
						y = -clientHeight * 0.9;
						break;
					case key.pagedown:
						y = clientHeight * 0.9;
						break;
					case key.home:
						y = -elem.scrollTop;
						break;
					case key.end:
						var damt = elem.scrollHeight - elem.scrollTop - clientHeight;
						y = (damt > 0) ? damt + 10 : 0;
						break;
					case key.left:
						x = -options.arrowScroll;
						break;
					case key.right:
						x = options.arrowScroll;
						break;
					default:
						return true
				}
				scrollArray(elem, x, y);
				event.preventDefault()
			}
			function mousedown(event) {
				activeElement = event.target
			}
			var cache = {};
			setInterval(function () {
				cache = {}
			}, 10 * 1000);
			var uniqueID = (function () {
				var i = 0;
				return function (el) {
					return el.uniqueID || (el.uniqueID = i++)
				}
			})();
			function setCache(elems, overflowing) {
				for (var i = elems.length; i--;)
					cache[uniqueID(elems[i])] = overflowing;
				return overflowing
			}
			function overflowingAncestor(el) {
				var elems = [];
				var rootScrollHeight = root.scrollHeight;
				do {
					var cached = cache[uniqueID(el)];
					if (cached) {
						return setCache(elems, cached)
					}
					elems.push(el);
					if (rootScrollHeight === el.scrollHeight) {
						if (!isFrame || root.clientHeight + 10 < rootScrollHeight) {
							return setCache(elems, document.body)
						}
					} else if (el.clientHeight + 10 < el.scrollHeight) {
						overflow = getComputedStyle(el, "").getPropertyValue("overflow-y");
						if (overflow === "scroll" || overflow === "auto") {
							return setCache(elems, el)
						}
					}
				} while (el = el.parentNode)
			}
			function addEvent(type, fn, bubble) {
				window.addEventListener(type, fn, (bubble || false))
			}
			function removeEvent(type, fn, bubble) {
				window.removeEventListener(type, fn, (bubble || false))
			}
			function isNodeName(el, tag) {
				return (el.nodeName || "").toLowerCase() === tag.toLowerCase()
			}
			function directionCheck(x, y) {
				x = (x > 0) ? 1 : -1;
				y = (y > 0) ? 1 : -1;
				if (direction.x !== x || direction.y !== y) {
					direction.x = x;
					direction.y = y;
					que = [];
					lastScroll = 0
				}
			}
			var deltaBufferTimer;
			function isTouchpad(deltaY) {
				if (!deltaY)
					return;
				deltaY = Math.abs(deltaY);
				deltaBuffer.push(deltaY);
				deltaBuffer.shift();
				clearTimeout(deltaBufferTimer);
				var allEquals = (deltaBuffer[0] == deltaBuffer[1] && deltaBuffer[1] == deltaBuffer[2]);
				var allDivisable = (isDivisible(deltaBuffer[0], 120) && isDivisible(deltaBuffer[1], 120) && isDivisible(deltaBuffer[2], 120));
				return !(allEquals || allDivisable)
			}
			function isDivisible(n, divisor) {
				return (Math.floor(n / divisor) == n / divisor)
			}
			var requestFrame = (function () {
				return window.requestAnimationFrame || window.webkitRequestAnimationFrame || function (callback, element, delay) {
					window.setTimeout(callback, delay || (1000 / 60))
				}
			})();
			var MutationObserver = window.MutationObserver || window.WebKitMutationObserver;
			function pulse_(x) {
				var val, start, expx;
				x = x * options.pulseScale;
				if (x < 1) {
					val = x - (1 - Math.exp(-x))
				} else {
					start = Math.exp(-1);
					x -= 1;
					expx = 1 - Math.exp(-x);
					val = start + (expx * (1 - start))
				}
				return val * options.pulseNormalize
			}
			function pulse(x) {
				if (x >= 1)
					return 1;
				if (x <= 0)
					return 0;
				if (options.pulseNormalize == 1) {
					options.pulseNormalize /= pulse_(1)
				}
				return pulse_(x)
			}
			addEvent("mousedown", mousedown);
			addEvent("mousewheel", wheel);
			addEvent("load", init)
		}
	});
	if (navigator.userAgent.toLowerCase().indexOf('chrome') > -1) {
		$.smoothScroll()
	}
})(jQuery);
(function ($) {
	var _previousResizeWidth = -1
		, _updateTimeout = -1;
	var _rows = function (elements) {
		var tolerance = 1
			, $elements = $(elements)
			, lastTop = null
			, rows = [];
		$elements.each(function () {
			var $that = $(this)
				, top = $that.offset().top - _parse($that.css('margin-top'))
				, lastRow = rows.length > 0 ? rows[rows.length - 1] : null;
			if (lastRow === null) {
				rows.push($that)
			} else {
				if (Math.floor(Math.abs(lastTop - top)) <= tolerance) {
					rows[rows.length - 1] = lastRow.add($that)
				} else {
					rows.push($that)
				}
			}
			lastTop = top
		});
		return rows
	};
	var _parse = function (value) {
		return parseFloat(value) || 0
	};
	var _parseOptions = function (options) {
		var opts = {
			byRow: true,
			remove: false,
			property: 'height'
		};
		if (typeof options === 'object') {
			return $.extend(opts, options)
		}
		if (typeof options === 'boolean') {
			opts.byRow = options
		} else if (options === 'remove') {
			opts.remove = true
		}
		return opts
	};
	var matchHeight = $.fn.matchHeight = function (options) {
		var opts = _parseOptions(options);
		if (opts.remove) {
			var that = this;
			this.css(opts.property, '');
			$.each(matchHeight._groups, function (key, group) {
				group.elements = group.elements.not(that)
			});
			return this
		}
		if (this.length <= 1)
			return this;
		matchHeight._groups.push({
			elements: this,
			options: opts
		});
		matchHeight._apply(this, opts);
		return this
	}
		;
	matchHeight._groups = [];
	matchHeight._throttle = 80;
	matchHeight._maintainScroll = false;
	matchHeight._beforeUpdate = null;
	matchHeight._afterUpdate = null;
	matchHeight._apply = function (elements, options) {
		var opts = _parseOptions(options)
			, $elements = $(elements)
			, rows = [$elements];
		var scrollTop = $(window).scrollTop()
			, htmlHeight = $('html').outerHeight(true);
		var $hiddenParents = $elements.parents().filter(':hidden');
		$hiddenParents.each(function () {
			var $that = $(this);
			$that.data('style-cache', $that.attr('style'))
		});
		$hiddenParents.css('display', 'block');
		if (opts.byRow) {
			$elements.each(function () {
				var $that = $(this)
					, display = $that.css('display') === 'inline-block' ? 'inline-block' : 'block';
				$that.data('style-cache', $that.attr('style'));
				$that.css({
					'display': display,
					'padding-top': '0',
					'padding-bottom': '0',
					'margin-top': '0',
					'margin-bottom': '0',
					'border-top-width': '0',
					'border-bottom-width': '0',
					'height': '100px'
				})
			});
			rows = _rows($elements);
			$elements.each(function () {
				var $that = $(this);
				$that.attr('style', $that.data('style-cache') || '')
			})
		}
		$.each(rows, function (key, row) {
			var $row = $(row)
				, maxHeight = 0;
			if (opts.byRow && $row.length <= 1) {
				$row.css(opts.property, '');
				return
			}
			$row.each(function () {
				var $that = $(this)
					, display = $that.css('display') === 'inline-block' ? 'inline-block' : 'block';
				var css = {
					'display': display
				};
				css[opts.property] = '';
				$that.css(css);
				if ($that.outerHeight(false) > maxHeight)
					maxHeight = $that.outerHeight(false);
				$that.css('display', '')
			});
			$row.each(function () {
				var $that = $(this)
					, verticalPadding = 0;
				if ($that.css('box-sizing') !== 'border-box') {
					verticalPadding += _parse($that.css('border-top-width')) + _parse($that.css('border-bottom-width'));
					verticalPadding += _parse($that.css('padding-top')) + _parse($that.css('padding-bottom'))
				}
				$that.css(opts.property, maxHeight - verticalPadding)
			})
		});
		$hiddenParents.each(function () {
			var $that = $(this);
			$that.attr('style', $that.data('style-cache') || null)
		});
		if (matchHeight._maintainScroll)
			$(window).scrollTop((scrollTop / htmlHeight) * $('html').outerHeight(true));
		return this
	}
		;
	matchHeight._applyDataApi = function () {
		var groups = {};
		$('[data-match-height], [data-mh]').each(function () {
			var $this = $(this)
				, groupId = $this.attr('data-match-height') || $this.attr('data-mh');
			if (groupId in groups) {
				groups[groupId] = groups[groupId].add($this)
			} else {
				groups[groupId] = $this
			}
		});
		$.each(groups, function () {
			this.matchHeight(true)
		})
	}
		;
	var _update = function (event) {
		if (matchHeight._beforeUpdate)
			matchHeight._beforeUpdate(event, matchHeight._groups);
		$.each(matchHeight._groups, function () {
			matchHeight._apply(this.elements, this.options)
		});
		if (matchHeight._afterUpdate)
			matchHeight._afterUpdate(event, matchHeight._groups)
	};
	matchHeight._update = function (throttle, event) {
		if (event && event.type === 'resize') {
			var windowWidth = $(window).width();
			if (windowWidth === _previousResizeWidth)
				return;
			_previousResizeWidth = windowWidth
		}
		if (!throttle) {
			_update(event)
		} else if (_updateTimeout === -1) {
			_updateTimeout = setTimeout(function () {
				_update(event);
				_updateTimeout = -1
			}, matchHeight._throttle)
		}
	}
		;
	$(matchHeight._applyDataApi);
	$(window).bind('load', function (event) {
		matchHeight._update(false, event)
	});
	$(window).bind('resize orientationchange', function (event) {
		matchHeight._update(true, event)
	})
})(jQuery);
(function ($) {
	"use strict";
	$.fn.pin = function (options) {
		var scrollY = 0
			, elements = []
			, disabled = false
			, $window = $(window);
		options = options || {};
		var recalculateLimits = function () {
			for (var i = 0, len = elements.length; i < len; i++) {
				var $this = elements[i];
				if (options.minWidth && $window.width() <= options.minWidth) {
					if ($this.parent().is(".pin-wrapper")) {
						$this.unwrap()
					}
					$this.css({
						width: "",
						left: "",
						top: "",
						position: ""
					});
					if (options.activeClass) {
						$this.removeClass(options.activeClass)
					}
					disabled = true;
					continue
				} else {
					disabled = false
				}
				var $container = options.containerSelector ? $this.closest(options.containerSelector) : $(document.body);
				var offset = $this.offset();
				var containerOffset = $container.offset();
				var parentOffset = $this.parent().offset();
				if (!$this.parent().is(".pin-wrapper")) {
					$this.wrap("<div class='pin-wrapper'>")
				}
				var pad = $.extend({
					top: 0,
					bottom: 0
				}, options.padding || {});
				$this.data("pin", {
					pad: pad,
					from: (options.containerSelector ? containerOffset.top : offset.top) - pad.top,
					to: containerOffset.top + $container.height() - $this.outerHeight() - pad.bottom,
					end: containerOffset.top + $container.height(),
					parentTop: parentOffset.top
				});
				$this.css({
					width: $this.outerWidth()
				});
				$this.parent().css("height", $this.outerHeight())
			}
		};
		var onScroll = function () {
			if (disabled) {
				return
			}
			scrollY = $window.scrollTop();
			var elmts = [];
			for (var i = 0, len = elements.length; i < len; i++) {
				var $this = $(elements[i])
					, data = $this.data("pin");
				if (!data) {
					continue
				}
				elmts.push($this);
				var from = data.from - data.pad.bottom
					, to = data.to - data.pad.top;
				if (from + $this.outerHeight() > data.end) {
					$this.css('position', '');
					continue
				}
				if (from < scrollY && to > scrollY) {
					!($this.css("position") == "fixed") && $this.css({
						left: $this.offset().left,
						top: data.pad.top
					}).css("position", "fixed");
					if (options.activeClass) {
						$this.addClass(options.activeClass)
					}
				} else if (scrollY >= to) {
					$this.css({
						left: "",
						top: to - data.parentTop + data.pad.top
					}).css("position", "absolute");
					if (options.activeClass) {
						$this.addClass(options.activeClass)
					}
				} else {
					$this.css({
						position: "",
						top: "",
						left: ""
					});
					if (options.activeClass) {
						$this.removeClass(options.activeClass)
					}
				}
			}
			elements = elmts
		};
		var update = function () {
			recalculateLimits();
			onScroll()
		};
		this.each(function () {
			var $this = $(this)
				, data = $(this).data('pin') || {};
			if (data && data.update) {
				return
			}
			elements.push($this);
			$("img", this).one("load", recalculateLimits);
			data.update = update;
			$(this).data('pin', data)
		});
		$window.scroll(onScroll);
		$window.resize(function () {
			recalculateLimits()
		});
		recalculateLimits();
		$window.load(update);
		$(window).on('stickyMenu.active stickyMenu.deactive', function () {
			update()
		});
		return this
	}
})(jQuery);