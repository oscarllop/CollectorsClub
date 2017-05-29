// Lightbox
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__lightbox';

    var PluginLightbox = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginLightbox.defaults = {
        tClose: 'Close (Esc)', // Alt text on close button
        tLoading: 'Loading...', // Text that is displayed during loading. Can contain %curr% and %total% keys
        gallery: {
            tPrev: 'Previous (Left arrow key)', // Alt text on left arrow
            tNext: 'Next (Right arrow key)', // Alt text on right arrow
            tCounter: '%curr% of %total%' // Markup for "1 of 7" counter
        },
        image: {
            tError: '<a href="%url%">The image</a> could not be loaded.' // Error message when image could not be loaded
        },
        ajax: {
            tError: '<a href="%url%">The content</a> could not be loaded.' // Error message when ajax request failed
        },
        callbacks: {
            open: function () {
                $('body').addClass('lightbox-opened');
            },
            close: function () {
                $('body').removeClass('lightbox-opened');
            }
        }
    };

    PluginLightbox.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginLightbox.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.magnificPopup))) {
                return this;
            }

            this.options.wrapper.magnificPopup(this.options);

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginLightbox: PluginLightbox
    });

    // jquery plugin
    $.fn.themePluginLightbox = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginLightbox($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Lightbox
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginLightbox'])) {

        $(function () {
            $('[data-plugin-lightbox]:not(.manual), .lightbox:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginLightbox(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Video Background
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__videobackground';

    var PluginVideoBackground = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginVideoBackground.defaults = {
        overlay: true,
        volume: 1,
        playbackRate: 1,
        muted: true,
        loop: true,
        autoplay: true,
        position: '50% 50%',
        posterType: 'detect'
    };

    PluginVideoBackground.prototype = {
        initialize: function ($el, opts) {
            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginVideoBackground.defaults, opts, {
                path: this.$el.data('video-path'),
                wrapper: this.$el
            });

            return this;
        },

        build: function () {

            if (!($.isFunction($.fn.vide)) || (!this.options.path)) {
                return this;
            }

            if (this.options.overlay) {
                this.options.wrapper.prepend(
					$('<div />').addClass('video-overlay')
				);
            }

            this.options.wrapper.vide(this.options.path, this.options);

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginVideoBackground: PluginVideoBackground
    });

    // jquery plugin
    $.fn.themePluginVideoBackground = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginVideoBackground($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Video Background
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginVideoBackground'])) {

        $(function () {
            $('[data-plugin-video-background]:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginVideoBackground(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Progress Bar
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__progressBar';

    var PluginProgressBar = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginProgressBar.defaults = {
        accX: 0,
        accY: -50,
        delay: 1
    };

    PluginProgressBar.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginProgressBar.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.appear))) {
                return this;
            }

            var self = this,
				$el = this.options.wrapper,
				delay = 1;

            $el.appear(function () {

                delay = ($el.attr('data-appear-animation-delay') ? $el.attr('data-appear-animation-delay') : self.options.delay);

                $el.addClass($el.attr('data-appear-animation'));

                setTimeout(function () {

                    $el.animate({
                        width: $el.attr('data-appear-progress-animation')
                    }, 1500, 'easeOutQuad', function () {
                        $el.find('.progress-bar-tooltip').animate({
                            opacity: 1
                        }, 500, 'easeOutQuad');
                    });

                }, delay);

            }, {
                accX: self.options.accX,
                accY: self.options.accY
            });

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginProgressBar: PluginProgressBar
    });

    // jquery plugin
    $.fn.themePluginProgressBar = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginProgressBar($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Progress Bar
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginProgressBar'])) {

        $(function () {
            $('[data-plugin-progress-bar]:not(.manual), [data-appear-progress-animation]').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginProgressBar(opts);
            });
        });

    }

}).apply(this, [jQuery]); window.theme = {};

// Counter
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__counter';

    var PluginCounter = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginCounter.defaults = {
        accX: 0,
        accY: 0,
        speed: 3000,
        refreshInterval: 100,
        decimals: 0,
        onUpdate: null,
        onComplete: null
    };

    PluginCounter.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginCounter.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.countTo))) {
                return this;
            }

            var self = this,
				$el = this.options.wrapper;

            $.extend(self.options, {
                onComplete: function () {
                    if ($el.data('append')) {
                        $el.html($el.html() + $el.data('append'));
                    }

                    if ($el.data('prepend')) {
                        $el.html($el.data('prepend') + $el.html());
                    }
                }
            });

            $el.appear(function () {

                $el.countTo(self.options);

            }, {
                accX: self.options.accX,
                accY: self.options.accY
            });

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginCounter: PluginCounter
    });

    // jquery plugin
    $.fn.themePluginCounter = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginCounter($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Match Height
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__matchHeight';

    var PluginMatchHeight = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginMatchHeight.defaults = {
        byRow: true,
        property: 'height',
        target: null,
        remove: false
    };

    PluginMatchHeight.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginMatchHeight.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.matchHeight))) {
                return this;
            }

            var self = this;

            self.options.wrapper.matchHeight(self.options);

            return this;
        }

    };

    // expose to scope
    $.extend(theme, {
        PluginMatchHeight: PluginMatchHeight
    });

    // jquery plugin
    $.fn.themePluginMatchHeight = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginMatchHeight($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Sticky
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__sticky';

    var PluginSticky = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginSticky.defaults = {
        minWidth: 991,
        activeClass: 'sticky-active'
    };

    PluginSticky.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginSticky.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.pin))) {
                return this;
            }

            this.options.wrapper.pin(this.options);

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginSticky: PluginSticky
    });

    // jquery plugin
    $.fn.themePluginSticky = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginSticky($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Toggle
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__toggle';

    var PluginToggle = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginToggle.defaults = {
        duration: 350,
        isAccordion: false
    };

    PluginToggle.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginToggle.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            var self = this,
				$wrapper = this.options.wrapper,
				$items = $wrapper.find('.toggle'),
				$el = null;

            $items.each(function () {
                $el = $(this);

                if ($el.hasClass('active')) {
                    $el.find('> p').addClass('preview-active');
                    $el.find('> .toggle-content').slideDown(self.options.duration);
                }

                self.events($el);
            });

            if (self.options.isAccordion) {
                self.options.duration = self.options.duration / 2;
            }

            return this;
        },

        events: function ($el) {
            var self = this,
				previewParCurrentHeight = 0,
				previewParAnimateHeight = 0,
				toggleContent = null;

            $el.find('> label').click(function (e) {

                var $this = $(this),
					parentSection = $this.parent(),
					parentWrapper = $this.parents('.toggle'),
					previewPar = null,
					closeElement = null;

                if (self.options.isAccordion && typeof (e.originalEvent) != 'undefined') {
                    closeElement = parentWrapper.find('.toggle.active > label');

                    if (closeElement[0] == $this[0]) {
                        return;
                    }
                }

                parentSection.toggleClass('active');

                // Preview Paragraph
                if (parentSection.find('> p').get(0)) {

                    previewPar = parentSection.find('> p');
                    previewParCurrentHeight = previewPar.css('height');
                    previewPar.css('height', 'auto');
                    previewParAnimateHeight = previewPar.css('height');
                    previewPar.css('height', previewParCurrentHeight);

                }

                // Content
                toggleContent = parentSection.find('> .toggle-content');

                if (parentSection.hasClass('active')) {

                    $(previewPar).animate({
                        height: previewParAnimateHeight
                    }, self.options.duration, function () {
                        $(this).addClass('preview-active');
                    });

                    toggleContent.slideDown(self.options.duration, function () {
                        if (closeElement) {
                            closeElement.trigger('click');
                        }
                    });

                } else {

                    $(previewPar).animate({
                        height: 0
                    }, self.options.duration, function () {
                        $(this).removeClass('preview-active');
                    });

                    toggleContent.slideUp(self.options.duration);

                }

            });
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginToggle: PluginToggle
    });

    // jquery plugin
    $.fn.themePluginToggle = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginToggle($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Word Rotate
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__wordRotate';

    var PluginwordRotate = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginwordRotate.defaults = {
        delay: 2000,
        animDelay: 300
    };

    PluginwordRotate.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginwordRotate.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            var self = this,
				$el = this.options.wrapper,
				itemsWrapper = $el.find(".word-rotate-items"),
				items = itemsWrapper.find("> span"),
				firstItem = items.eq(0),
				firstItemClone = firstItem.clone(),
				currentItem = 1,
				currentTop = 0,
				itemWidth = 0;

            itemsWrapper
				.width(firstItem.width() + "px")
				.append(firstItemClone);

            $el
				.addClass("active");

            setInterval(function () {

                currentTop = (currentItem * $el.height());
                currentItem++;

                if (currentItem <= items.length) {
                    itemWidth = items.eq(currentItem - 1).width();
                } else {
                    itemWidth = items.eq(0).width();
                }

                itemsWrapper.animate({
                    top: -(currentTop) + "px",
                    width: itemWidth + "px"
                }, self.options.animDelay, "easeOutQuad", function () {

                    if (currentItem > items.length) {

                        itemsWrapper.css("top", 0);
                        currentItem = 1;

                    }

                });

            }, self.options.delay);

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginwordRotate: PluginwordRotate
    });

    // jquery plugin
    $.fn.themePluginwordRotate = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginwordRotate($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Animate
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__animate';

    var PluginAnimate = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginAnimate.defaults = {
        accX: 0,
        accY: -150,
        delay: 1
    };

    PluginAnimate.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginAnimate.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            var self = this,
				$el = this.options.wrapper,
				delay = 0;

            $el.addClass('appear-animation');

            if (!$('html').hasClass('no-csstransitions') && $(window).width() > 767) {

                $el.appear(function () {

                    delay = ($el.attr('data-appear-animation-delay') ? $el.attr('data-appear-animation-delay') : self.options.delay);

                    if (delay > 1) {
                        $el.css('animation-delay', delay + 'ms');
                    }

                    $el.addClass($el.attr('data-appear-animation'));

                    setTimeout(function () {
                        $el.addClass('appear-animation-visible');
                    }, delay);

                }, {
                    accX: self.options.accX,
                    accY: self.options.accY
                });

            } else {

                $el.addClass('appear-animation-visible');

            }

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginAnimate: PluginAnimate
    });

    // jquery plugin
    $.fn.themePluginAnimate = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginAnimate($this, opts);
            }

        });
    };

}).apply(this, [window.theme, jQuery]);

// Loading Overlay
(function (theme, $) {

    'use strict';

    theme = theme || {};

    var loadingOverlayTemplate = [
		'<div class="loading-overlay">',
			'<div class="loader"></div>',
		'</div>'
    ].join('');

    var LoadingOverlay = function ($wrapper, options) {
        return this.initialize($wrapper, options);
    };

    LoadingOverlay.prototype = {

        options: {
            css: {}
        },

        initialize: function ($wrapper, options) {
            this.$wrapper = $wrapper;

            this
				.setVars()
				.setOptions(options)
				.build()
				.events();

            this.$wrapper.data('loadingOverlay', this);
        },

        setVars: function () {
            this.$overlay = this.$wrapper.find('.loading-overlay');

            return this;
        },

        setOptions: function (options) {
            if (!this.$overlay.get(0)) {
                this.matchProperties();
            }
            this.options = $.extend(true, {}, this.options, options);
            this.loaderClass = this.getLoaderClass(this.options.css.backgroundColor);

            return this;
        },

        build: function () {
            if (!this.$overlay.closest(document.documentElement).get(0)) {
                if (!this.$cachedOverlay) {
                    this.$overlay = $(loadingOverlayTemplate).clone();

                    if (this.options.css) {
                        this.$overlay.css(this.options.css);
                        this.$overlay.find('.loader').addClass(this.loaderClass);
                    }
                } else {
                    this.$overlay = this.$cachedOverlay.clone();
                }

                this.$wrapper.append(this.$overlay);
            }

            if (!this.$cachedOverlay) {
                this.$cachedOverlay = this.$overlay.clone();
            }

            return this;
        },

        events: function () {
            var _self = this;

            if (this.options.startShowing) {
                _self.show();
            }

            if (this.$wrapper.is('body') || this.options.hideOnWindowLoad) {
                $(window).on('load error', function () {
                    _self.hide();
                });
            }

            if (this.options.listenOn) {
                $(this.options.listenOn)
					.on('loading-overlay:show beforeSend.ic', function (e) {
					    e.stopPropagation();
					    _self.show();
					})
					.on('loading-overlay:hide complete.ic', function (e) {
					    e.stopPropagation();
					    _self.hide();
					});
            }

            this.$wrapper
				.on('loading-overlay:show beforeSend.ic', function (e) {
				    e.stopPropagation();
				    _self.show();
				})
				.on('loading-overlay:hide complete.ic', function (e) {
				    e.stopPropagation();
				    _self.hide();
				});

            return this;
        },

        show: function () {
            this.build();

            this.position = this.$wrapper.css('position').toLowerCase();
            if (this.position != 'relative' || this.position != 'absolute' || this.position != 'fixed') {
                this.$wrapper.css({
                    position: 'relative'
                });
            }
            this.$wrapper.addClass('loading-overlay-showing');
        },

        hide: function () {
            var _self = this;

            this.$wrapper.removeClass('loading-overlay-showing');
            setTimeout(function () {
                if (this.position != 'relative' || this.position != 'absolute' || this.position != 'fixed') {
                    _self.$wrapper.css({ position: '' });
                }
            }, 500);
        },

        matchProperties: function () {
            var i,
				l,
				properties;

            properties = [
				'backgroundColor',
				'borderRadius'
            ];

            l = properties.length;

            for (i = 0; i < l; i++) {
                var obj = {};
                obj[properties[i]] = this.$wrapper.css(properties[i]);

                $.extend(this.options.css, obj);
            }
        },

        getLoaderClass: function (backgroundColor) {
            if (!backgroundColor || backgroundColor === 'transparent' || backgroundColor === 'inherit') {
                return 'black';
            }

            var hexColor,
				r,
				g,
				b,
				yiq;

            var colorToHex = function (color) {
                var hex,
					rgb;

                if (color.indexOf('#') > -1) {
                    hex = color.replace('#', '');
                } else {
                    rgb = color.match(/\d+/g);
                    hex = ('0' + parseInt(rgb[0], 10).toString(16)).slice(-2) + ('0' + parseInt(rgb[1], 10).toString(16)).slice(-2) + ('0' + parseInt(rgb[2], 10).toString(16)).slice(-2);
                }

                if (hex.length === 3) {
                    hex = hex + hex;
                }

                return hex;
            };

            hexColor = colorToHex(backgroundColor);

            r = parseInt(hexColor.substr(0, 2), 16);
            g = parseInt(hexColor.substr(2, 2), 16);
            b = parseInt(hexColor.substr(4, 2), 16);
            yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;

            return (yiq >= 128) ? 'black' : 'white';
        }

    };

    // expose to scope
    $.extend(theme, {
        LoadingOverlay: LoadingOverlay
    });

    // expose as a jquery plugin
    $.fn.loadingOverlay = function (opts) {
        return this.each(function () {
            var $this = $(this);

            var loadingOverlay = $this.data('loadingOverlay');
            if (loadingOverlay) {
                return loadingOverlay;
            } else {
                var options = opts || $this.data('loading-overlay-options') || {};
                return new LoadingOverlay($this, options);
            }
        });
    }

    // auto init
    $(function () {
        $('[data-loading-overlay]').loadingOverlay();
    });

}).apply(this, [window.theme, jQuery]);

// Nav
(function (theme, $) {

    theme = theme || {};

    var initialized = false;

    $.extend(theme, {

        Nav: {

            defaults: {
                wrapper: $('#mainMenu'),
                scrollDelay: 600,
                scrollAnimation: 'easeOutQuad'
            },

            initialize: function ($wrapper, opts) {
                if (initialized) {
                    return this;
                }

                initialized = true;
                this.$wrapper = ($wrapper || this.defaults.wrapper);

                this
					.setOptions(opts)
					.build()
					.events();

                return this;
            },

            setOptions: function (opts) {
                this.options = $.extend(true, {}, this.defaults, opts, this.$wrapper.data('plugin-options'));

                return this;
            },

            build: function () {

                return this;
            },

            events: function () {
                var self = this,
					target = "",
					delay = 1,
					$header = $('header'),
					headerHeight = $header.outerHeight();

                $header.find('[href=#]').on('click', function (e) {
                    e.preventDefault();
                });
                //VerticalMenu


                $vMenu = $('#verticalMenu');

                if ($vMenu.length > 0)
                    $vMenu.find('.dropdown-toggle, .dropdown:not(.mega-menu-item) .dropdown-submenu > a').append($('<i />').addClass('fa fa-caret-down'));

                $('.nav-main').find('.dropdown-toggle[href=#], .dropdown-submenu [href=#], .dropdown-toggle[href!=#] .fa-caret-down, .dropdown-submenu a[href!=#] .fa-caret-down').on('click', function (e) {

                    e.preventDefault();

                    if ($(window).width() > 991 && $(this).parents('#verticalMenu').length < 0)
                        return this;

                    $(this).parent().parent().toggleClass('resp-active');

                    return this;
                });



                // Add Arrows
                if ($(window).width() > 992)
                    $header.find('.dropdown-toggle, .dropdown:not(.mega-menu-item) .dropdown-submenu > a').append($('<i />').addClass('fa fa-caret-down'));
                else
                    $header.find('.dropdown-toggle, .dropdown .dropdown-submenu > a').append($('<i />').addClass('fa fa-caret-down'));

                // Mobile Arrows
                $header.find('.dropdown-toggle[href=#], .dropdown-submenu [href=#], .dropdown-toggle[href!=#] .fa-caret-down, .dropdown-submenu a[href!=#] .fa-caret-down').on('click', function (e) {
                    e.preventDefault();
                    if ($(window).width() < 992) {
                        $(this).closest('li').toggleClass('opened');
                    }
                });

                // Anchors Position
                $('[data-hash]').on('click', function (e) {
                    e.preventDefault();

                    target = $(this).attr('href');

                    if ($(window).scrollTop() == 0) {
                        $('html, body').animate({
                            scrollTop: headerHeight
                        }, 200);

                        delay = 200;
                    }

                    setTimeout(function () {
                        self.scrollToTarget(target);
                    }, delay);

                    return;
                });

                // Mobile Redirect - (Ignores the Dropdown from Bootstrap)
                $('.mobile-redirect').on('click', function () {
                    if ($(window).width() < 991) {
                        self.location = $(this).attr('href');
                    }
                });

                // Submenu Check Visible Space
                $("#mainMenu li.dropdown-submenu").hover(function () {

                    if ($(window).width() < 767) return;

                    var subMenu = $(this).find("ul.dropdown-menu");

                    if (!subMenu.get(0)) return;

                    var screenWidth = $(window).width(),
                        subMenuWidth = subMenu.width(),
                        subMenuParentWidth = $(this).parent().width(),
                        subMenuPosRight = subMenu.offset().left + subMenu.width();

                    if (subMenuPosRight > screenWidth)
                        subMenu.css("margin-left", "-" + (subMenuParentWidth + subMenuWidth + 10) + "px");
                    else
                        subMenu.css("margin-left", 0);
                });

                return this;
            },

            scrollToTarget: function (target) {

                $('body').addClass('scrolling');

                var self = this,
					$header = $('header'),
					headerHeight = $header.outerHeight(),
					headerTop = $header.offset().top - $(window).scrollTop();

                $('html, body').animate({
                    scrollTop: $(target).offset().top - (headerHeight + headerTop)
                }, self.options.scrollDelay, self.options.scrollAnimation, function () {
                    $('body').removeClass('scrolling');
                });

                return this;

            }

        }

    });

}).apply(this, [window.theme, jQuery]);

// Sticky Menu
(function (theme, $) {

    theme = theme || {};

    var initialized = false;

    $.extend(theme, {

        StickyMenu: {

            defaults: {
                wrapper: $('header'),
                stickyEnabled: true,
                stickyEnableOnBoxed: true,
                stickyEnableOnMobile: true,
                stickyWithGap: true,
                stickyChangeLogoSize: true,
                stickyBodyPadding: true,
                menuAfterHeader: false,
                alwaysStickyEnabled: false,
                stickyForceHeaderTop: false,
                logoPaddingTop: 28,
                logoSmallHeight: 40
            },

            initialize: function ($wrapper, opts) {
                if (initialized) {
                    return this;
                }

                initialized = true;
                this.$wrapper = ($wrapper || this.defaults.wrapper);

                this
					.setOptions(opts)
					.build()
					.events();

                return this;
            },

            setOptions: function (opts) {
                this.options = $.extend(true, {}, this.defaults, opts, this.$wrapper.data('plugin-options'));

                return this;
            },

            build: function () {
                if (!this.options.stickyEnableOnBoxed && $('body').hasClass('boxed') || !this.options.stickyEnabled) {
                    return this;
                }

                var self = this,
					$window = $(window);
                $body = $('body'),
                $header = self.$wrapper,
                $headerContainer = $header.parent(),
                $headerNavItems = $header.find('ul.nav-main > li > a'),
                $logoWrapper = $header.find('.logo'),
                $logo = $logoWrapper.find('img'),
                logoHeight = $logo.height(),
                logoPaddingTop = parseInt($logo.attr('data-sticky-padding') ? $logo.attr('data-sticky-padding') : self.options.logoPaddingTop),
                logoSmallHeight = parseInt($logo.attr('data-sticky-height') ? $logo.attr('data-sticky-height') : self.options.logoSmallHeight),
                headerHeight = $header.height(),
                stickyGap = 0;

                if (this.options.menuAfterHeader) {
                    $headerContainer.css('min-height', $header.height());
                }

                $window.afterResize(function () {
                    $headerContainer.css('min-height', $header.height());
                });

                self.checkStickyMenu = function () {

                    if ((!self.options.stickyEnableOnBoxed && $body.hasClass('boxed')) || ($window.width() < 991 && !self.options.stickyEnableOnMobile)) {
                        self.stickyMenuDeactivate();
                        $header.removeClass('fixed')
                        return false;
                    }

                    if (self.options.stickyWithGap) {
                        stickyGap = ((headerHeight - 15) - logoSmallHeight);
                    } else {
                        stickyGap = 0;
                    }

                    // Menu After Header
                    if (!this.options.menuAfterHeader) {

                        if ($window.scrollTop() > stickyGap) {
                            self.stickyMenuActivate();
                        } else {
                            self.stickyMenuDeactivate();
                        }

                    } else {

                        if ($window.scrollTop() > $headerContainer.offset().top) {
                            $header.addClass('fixed');
                        } else {
                            $header.removeClass('fixed');
                        }

                    }

                }

                self.stickyMenuActivate = function () {

                    if ($body.hasClass('sticky-menu-active')) {
                        return false;
                    }

                    $logo.stop(true, true);

                    $body.addClass('sticky-menu-active').removeClass('sticky-menu-deactive');

                    if (self.options.stickyBodyPadding) {
                        $body.css('padding-top', headerHeight);
                    }

                    // Flat Menu Items
                    if ($header.hasClass('flat-menu')) {
                        $headerNavItems.addClass('sticky-menu-active');
                    }

                    if (self.options.stickyChangeLogoSize) {

                        $logoWrapper.addClass('logo-sticky-active');

                        $logo.animate({
                            height: logoSmallHeight,
                            top: logoPaddingTop + 'px'
                        }, 200, function () {
                            $.event.trigger({
                                type: 'stickyMenu.active'
                            });
                        });

                    } else {
                        $.event.trigger({
                            type: 'stickyMenu.active'
                        });
                    }

                    if (self.options.stickyForceHeaderTop) {
                        $header.css('top', self.options.stickyForceHeaderTop);
                    }

                }

                self.stickyMenuDeactivate = function () {

                    if ($body.hasClass('sticky-menu-active')) {

                        $body.removeClass('sticky-menu-active').addClass('sticky-menu-deactive');

                        if (self.options.stickyBodyPadding) {
                            $body.css('padding-top', 0);
                        }

                        // Flat Menu Items
                        if ($header.hasClass('flat-menu')) {
                            $headerNavItems.removeClass('sticky-menu-active');
                        }

                        if (self.options.stickyChangeLogoSize) {

                            $logoWrapper.removeClass('logo-sticky-active');

                            $logo.animate({
                                height: logoHeight,
                                top: '0px'
                            }, 200, function () {
                                $.event.trigger({
                                    type: 'stickyMenu.deactive'
                                });
                                $window.trigger('resize');
                            });

                        } else {
                            $.event.trigger({
                                type: 'stickyMenu.deactive'
                            });
                        }

                    }

                    if (self.options.stickyForceHeaderTop) {
                        $header.css('top', '0');
                    }

                }

                if (!self.options.alwaysStickyEnabled) {

                    $body.addClass('sticky-menu-deactive');

                    self.checkStickyMenu();

                } else {

                    $body.addClass('sticky-menu-active always-sticky').removeClass('sticky-menu-deactive');

                    if (self.options.stickyBodyPadding) {
                        $body.css('padding-top', $header.height() + ($header.hasClass('narrow') ? 0 : 22));
                    }

                }

                return this;
            },

            events: function () {
                var self = this;

                if (!this.options.stickyEnableOnBoxed && $('body').hasClass('boxed') || !this.options.stickyEnabled) {
                    return this;
                }

                if (!self.options.alwaysStickyEnabled) {
                    $(window).on('scroll resize', function () {
                        self.checkStickyMenu();
                    });
                }

                $('.btn-responsive-nav').on('click', function (e) {
                    e.preventDefault();
                });

                return this;
            }

        }

    });

}).apply(this, [window.theme, jQuery]);

// Scroll to Top
(function (theme, $) {

    theme = theme || {};

    $.extend(theme, {

        PluginScrollToTop: {

            defaults: {
                wrapper: $('body'),
                offset: 150,
                buttonClass: 'scroll-to-top',
                iconClass: 'fa fa-chevron-up',
                delay: 500,
                visibleMobile: false,
                label: false
            },

            initialize: function (opts) {
                initialized = true;

                this
					.setOptions(opts)
					.build()
					.events();

                return this;
            },

            setOptions: function (opts) {
                this.options = $.extend(true, {}, this.defaults, opts);

                return this;
            },

            build: function () {
                var self = this,
					$el;

                // Base HTML Markup
                $el = $('<a />')
					.addClass(self.options.buttonClass)
					.attr({
					    'href': '#',
					})
					.append(
						$('<i />')
						.addClass(self.options.iconClass)
				);

                // Visible Mobile
                if (!self.options.visibleMobile) {
                    $el.addClass('hidden-mobile');
                }

                // Label
                if (self.options.label) {
                    $el.append(
						$('<span />').html(self.options.label)
					);
                }

                this.options.wrapper.append($el);

                this.$el = $el;

                return this;
            },

            events: function () {
                var self = this,
					_isScrolling = false;

                // Click Element Action
                self.$el.on('click', function (e) {
                    e.preventDefault();
                    $('body, html').animate({
                        scrollTop: 0
                    }, self.options.delay);
                    return false;
                });

                // Show/Hide Button on Window Scroll event.
                $(window).scroll(function () {

                    if (!_isScrolling) {

                        _isScrolling = true;

                        if ($(window).scrollTop() > self.options.offset) {

                            self.$el.stop(true, true).addClass('visible');
                            _isScrolling = false;

                        } else {

                            self.$el.stop(true, true).removeClass('visible');
                            _isScrolling = false;

                        }

                    }

                });

                return this;
            }

        }

    });

}).apply(this, [window.theme, jQuery]);

// Parallax
(function (theme, $) {

    theme = theme || {};

    $.extend(theme, {

        PluginParallax: {

            defaults: {
                itemsSelector: '.parallax',
                horizontalScrolling: false
            },

            initialize: function (opts) {

                this
					.setOptions(opts)
					.build();

                return this;
            },

            setOptions: function (opts) {
                this.options = $.extend(true, {}, this.defaults, opts);

                return this;
            },

            build: function () {
                if (!($.isFunction($.fn.stellar)) || typeof (Modernizr.touch) == 'undefined') {
                    return this;
                }

                var self = this;

                $(window).load(function () {

                    if (!Modernizr.touch) {
                        $.stellar(self.options).addClass('parallax-ready');
                    } else {
                        $(self.options.itemsSelector).addClass('parallax-disabled');
                    }

                });

                return this;
            }

        }

    });

}).apply(this, [window.theme, jQuery]);

// Commom Plugins
(function ($) {

    'use strict';

    // Scroll to Top Button.
    if (typeof theme.PluginScrollToTop !== 'undefined') {
        theme.PluginScrollToTop.initialize();
    }

    // Parallax
    if (typeof theme.PluginParallax !== 'undefined') {
        theme.PluginParallax.initialize();
    }

    // Tooltips
    if ($.isFunction($.fn['tooltip'])) {

        //Added rel selector to support backward compatibility
        $('[data-tooltip]:not(.manual), [data-plugin-tooltip]:not(.manual), a[rel=tooltip]').mtooltip();
    }

    // Popover
    if ($.isFunction($.fn['popover'])) {
        $(function () {
            $('[data-plugin-popover]:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.popover(opts);
            });
        });
    }


    // Match Height
    if ($.isFunction($.fn['matchHeight'])) {

        $('.match-height').matchHeight();

        // Featured Boxes
        $('.featured-boxes .featured-box').matchHeight();

        // Featured Box Full
        $('.featured-box-full').matchHeight();

    }

}).apply(this, [jQuery]);

// Counter
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginCounter'])) {

        $(function () {
            $('[data-plugin-counter]:not(.manual), .counters [data-to]').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginCounter(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Match Height
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginMatchHeight'])) {

        $(function () {
            $('[data-plugin-match-height]:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginMatchHeight(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Sticky
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginSticky'])) {

        $(function () {
            $('[data-plugin-sticky]:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginSticky(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Move Cloud
(function ($) {

    'use strict';

    if ($('.cloud').get(0)) {
        var moveCloud = function () {
            $('.cloud').animate({
                'top': '+=20px'
            }, 3000, 'linear', function () {
                $('.cloud').animate({
                    'top': '-=20px'
                }, 3000, 'linear', function () {
                    moveCloud();
                });
            });
        };

        moveCloud();
    }

}).apply(this, [jQuery]);

// Toggle
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginToggle'])) {

        $(function () {

            //Added toogle class to support backward compatibility
            $('[data-plugin-toggle]:not(.manual), .toogle').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginToggle(opts);
            });

            //Added toggle class to support backward compatibility
            $('.toggle').parent(':not([class])').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginToggle(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Word Rotate
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginwordRotate'])) {

        $(function () {
            $('[data-plugin-word-rotate]:not(.manual), .word-rotate:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginwordRotate(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Animate
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginAnimate'])) {

        $(function () {
            $('[data-plugin-animate], [data-appear-animation]').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginAnimate(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Commom Partials
(function ($) {

    'use strict';

    // Sticky Menu
    if (typeof theme.StickyMenu !== 'undefined') {
        theme.StickyMenu.initialize();
    }

    // Nav Menu
    if (typeof theme.Nav !== 'undefined') {
        theme.Nav.initialize();
    }

}).apply(this, [jQuery]);

// Added below code to support backward compatibility
/* Circular Bars - Knob */
if (typeof ($.fn.knob) != "undefined") {
    $(".knob").knob({});
}

$(document).on('click.bs.modal.data-api', '[data-toggle="modal"]', function (e) {
    e.preventDefault();
});

(function ($) {

    'use strict';

    // Videos
    $('#videos').owlCarousel({
        items: 1,
        merge: true,
        loop: true,
        margin: 10,
        video: true,
        lazyLoad: true,
        center: true,
        responsive: {
            480: {
                items: 2
            },
            600: {
                items: 4
            }
        }
    })

}).apply(this, [jQuery]);
/*
Name: 			Shortcodes - Lightboxes - Examples
Written by: 	Okler Themes - (http://www.okler.net)
Theme Version:	3.8.0
*/

(function ($) {

    'use strict';

    /*
	Popup with video or map
	*/
    $('.popup-youtube, .popup-vimeo, .popup-gmaps').magnificPopup({
        disableOn: 700,
        type: 'iframe',
        mainClass: 'mfp-fade',
        removalDelay: 160,
        preloader: false,

        fixedContentPos: false
    });

    /*
	Dialog with CSS animation
	*/
    $('.popup-with-zoom-anim').magnificPopup({
        type: 'inline',

        fixedContentPos: false,
        fixedBgPos: true,

        overflowY: 'auto',

        closeBtnInside: true,
        preloader: false,

        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-zoom-in'
    });

    $('.popup-with-move-anim').magnificPopup({
        type: 'inline',

        fixedContentPos: false,
        fixedBgPos: true,

        overflowY: 'auto',

        closeBtnInside: true,
        preloader: false,

        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-slide-bottom'
    });

    /*
	Form
	*/
    $('.popup-with-form').magnificPopup({
        type: 'inline',
        preloader: false,
        focus: '#name',

        // When elemened is focused, some mobile browsers in some cases zoom in
        // It looks not nice, so we disable it:
        callbacks: {
            open: function () {
                $('body').addClass('lightbox-opened');
            },
            close: function () {
                $('body').removeClass('lightbox-opened');
            },
            beforeOpen: function () {
                if ($(window).width() < 700) {
                    this.st.focus = false;
                } else {
                    this.st.focus = '#name';
                }
            }
        }
    });

    /*
	Ajax
	*/
    $('.simple-ajax-popup').magnificPopup({
        type: 'ajax',
        callbacks: {
            open: function () {
                $('body').addClass('lightbox-opened');
            },
            close: function () {
                $('body').removeClass('lightbox-opened');
            }
        }
    });

}).apply(this, [jQuery]);// Chart Circular
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__chartCircular';

    var PluginChartCircular = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginChartCircular.defaults = {
        accX: 0,
        accY: -150,
        delay: 1,
        barColor: '#0088CC',
        trackColor: '#f2f2f2',
        scaleColor: false,
        scaleLength: 5,
        lineCap: 'round',
        lineWidth: 13,
        size: 175,
        rotate: 0,
        animate: ({
            duration: 2500,
            enabled: true
        })
    };

    PluginChartCircular.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginChartCircular.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.appear)) || !($.isFunction($.fn.easyPieChart))) {
                return this;
            }

            var self = this,
				$el = this.options.wrapper,
				value = ($el.attr('data-percent') ? $el.attr('data-percent') : 0),
				percentEl = $el.find('.percent');

            $.extend(true, self.options, {
                onStep: function (from, to, currentValue) {
                    percentEl.html(parseInt(currentValue));
                }
            });

            $el.attr('data-percent', 0);

            $el.appear(function () {

                $el.easyPieChart(self.options);

                setTimeout(function () {

                    $el.data('easyPieChart').update(value);
                    $el.attr('data-percent', value);

                }, self.options.delay);

            }, {
                accX: self.options.accX,
                accY: self.options.accY
            });

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginChartCircular: PluginChartCircular
    });

    // jquery plugin
    $.fn.themePluginChartCircular = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginChartCircular($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Chart.Circular
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginChartCircular'])) {

        $(function () {
            $('[data-plugin-chart-circular]:not(.manual), .circular-bar-chart:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginChartCircular(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Sort
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__sort';

    var PluginSort = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginSort.defaults = {
        useHash: true,
        itemSelector: 'li',
        layoutMode: 'masonry',
        filter: '*',
        isOriginLeft: ($('html').attr('dir') == 'rtl' ? false : true)
    };

    PluginSort.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginSort.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.isotope))) {
                return this;
            }

            var self = this,
				$source = this.options.wrapper,
				$destination = $('.sort-destination[data-sort-id="' + $source.attr('data-sort-id') + '"]');

            if ($destination.get(0)) {

                self.$source = $source;
                self.$destination = $destination;

                self.setParagraphHeight($destination);

                $(window).load(function () {

                    $destination.isotope(self.options).isotope('layout');

                    self.$destination.isotope('on', 'layoutComplete', function (isoInstance, laidOutItems) {
                        if (self.options.useHash || typeof (isoInstance.options.filter != 'undefined')) {
                            if (window.location.hash != '' || isoInstance.options.filter.replace('.', '') != '*') {
                                window.location.hash = isoInstance.options.filter.replace('.', '');
                            }
                        }
                    });

                    self.events();

                });

            }

            return this;
        },

        events: function () {
            var self = this,
				filter = null;

            self.$source.find('a').click(function (e) {
                e.preventDefault();

                filter = $(this).parent().attr('data-option-value');

                self.setFilter(filter);

                return this;
            });

            if (self.options.useHash) {
                self.hashEvents();
            }

            return this;
        },

        setFilter: function (filter) {
            var self = this;

            //if (self.filter == filter) {
            //    return this;
            //}

            self.$source.find('li.active').removeClass('active');
            self.$source.find('li[data-option-value="' + filter + '"]').addClass('active');

            self.$destination.isotope({
                filter: filter
            });

            self.filter = filter;

            return this;
        },

        hashEvents: function () {
            var self = this,
				hash = null,
				hashFilter = null,
				initHashFilter = '.' + location.hash.replace('#', '');

            if (initHashFilter != '.' && initHashFilter != '.*') {
                self.setFilter(initHashFilter);
            }

            $(window).bind('hashchange', function (e) {

                hashFilter = '.' + location.hash.replace('#', '');
                hash = (hashFilter == '.' || hashFilter == '.*' ? '*' : hashFilter);

                self.setFilter(hash);

            });

            return this;
        },

        setParagraphHeight: function () {
            var self = this,
				minParagraphHeight = 0,
				paragraphs = $('span.thumb-info-caption p', self.$destination);

            paragraphs.each(function () {
                if ($(this).height() > minParagraphHeight) {
                    minParagraphHeight = ($(this).height() + 10);
                }
            });

            paragraphs.height(minParagraphHeight);

            return this;
        }

    };

    // expose to scope
    $.extend(theme, {
        PluginSort: PluginSort
    });

    // jquery plugin
    $.fn.themePluginSort = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginSort($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Sort
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginSort'])) {

        $(function () {
            $('[data-plugin-sort]:not(.manual), .sort-source:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginSort(opts);
            });
        });

    }

}).apply(this, [jQuery]);

// Masonry
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__masonry';

    var PluginMasonry = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginMasonry.defaults = {
        itemSelector: 'li'
    };

    PluginMasonry.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginMasonry.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.isotope))) {
                return this;
            }

            this.options.wrapper.isotope(this.options);

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginMasonry: PluginMasonry
    });

    // jquery plugin
    $.fn.themePluginMasonry = function (opts) {
        return this.map(function () {
            var $this = $(this);

            $this.waitForImages(function () {
                if ($this.data(instanceName)) {
                    return $this.data(instanceName);
                } else {
                    return new PluginMasonry($this, opts);
                }
            });

        });
    }

}).apply(this, [window.theme, jQuery]);

// Masonry
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginMasonry'])) {

        $(function () {
            $('[data-plugin-masonry]:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginMasonry(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Carousel
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__carousel';

    var PluginCarousel = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginCarousel.defaults = {
        loop: true,
        responsive: {
            0: {
                items: 1
            },
            479: {
                items: 1
            },
            768: {
                items: 2
            },
            979: {
                items: 3
            },
            1199: {
                items: 4
            }
        },
        navText: []
    };

    PluginCarousel.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginCarousel.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.owlCarousel))) {
                return this;
            }

            var self = this,
				$el = this.options.wrapper,
				activeItemHeight = 0;

            // Force RTL according to HTML dir attribute
            if ($('html').attr('dir') == 'rtl') {
                this.options = $.extend(true, {}, this.options, {
                    rtl: true
                });
            }

            if (this.options.items == 1) {
                this.options.responsive = {}
            }

            if (this.options.items > 4) {
                this.options = $.extend(true, {}, this.options, {
                    responsive: {
                        1199: {
                            items: this.options.items
                        }
                    }
                });
            }

            // Auto Height
            $(window).afterResize(function () {
                activeItemHeight = $el.find('.owl-item.active').height();
                $el.find('.owl-stage-outer').height(activeItemHeight);
            });

            this.options.wrapper.owlCarousel(this.options).addClass("owl-carousel-init");

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginCarousel: PluginCarousel
    });

    // jquery plugin
    $.fn.themePluginCarousel = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginCarousel($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Carousel
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginCarousel'])) {

        $(function () {
            $('[data-plugin-carousel]:not(.manual), .owl-carousel:not(.manual)').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginCarousel(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Flickr
(function (theme, $) {

    theme = theme || {};

    var instanceName = '__flickr';

    var PluginFlickr = function ($el, opts) {
        return this.initialize($el, opts);
    };

    PluginFlickr.defaults = {
        flickrbase: 'http://api.flickr.com/services/feeds/',
        feedapi: 'photos_public.gne',
        limit: 6,
        qstrings: {
            lang: 'en-us',
            format: 'json',
            jsoncallback: '?'
        },
        cleanDescription: true,
        useTemplate: true,
        itemTemplate: '<li><a href="{{image_b}}" title="{{title}}"><span class="thumbnail"><img src="{{image_s}}" /></span></a></li>',
        itemCallback: function () { }
    };

    PluginFlickr.prototype = {
        initialize: function ($el, opts) {
            if ($el.data(instanceName)) {
                return this;
            }

            this.$el = $el;

            this
				.setData()
				.setOptions(opts)
				.build();

            return this;
        },

        setData: function () {
            this.$el.data(instanceName, this);

            return this;
        },

        setOptions: function (opts) {
            this.options = $.extend(true, {}, PluginFlickr.defaults, opts, {
                wrapper: this.$el
            });

            return this;
        },

        build: function () {
            if (!($.isFunction($.fn.jflickrfeed)) || !($.isFunction($.fn.magnificPopup))) {
                return this;
            }

            var self = this;

            self.options.wrapper.jflickrfeed(this.options, function (data) {

                self.options.wrapper.magnificPopup({
                    delegate: 'a',
                    type: 'image',
                    gallery: {
                        enabled: true,
                        navigateByImgClick: true,
                        preload: [0, 1]
                    },
                    zoom: {
                        enabled: true,
                        duration: 300,
                        opener: function (element) {
                            return element.find('img');
                        }
                    }
                });

            });

            return this;
        }
    };

    // expose to scope
    $.extend(theme, {
        PluginFlickr: PluginFlickr
    });

    // jquery plugin
    $.fn.themePluginFlickr = function (opts) {
        return this.map(function () {
            var $this = $(this);

            if ($this.data(instanceName)) {
                return $this.data(instanceName);
            } else {
                return new PluginFlickr($this, opts);
            }

        });
    }

}).apply(this, [window.theme, jQuery]);

// Flickr
(function ($) {

    'use strict';

    if ($.isFunction($.fn['themePluginFlickr'])) {

        $(function () {
            //Added ul.flickr-feed selector to support backward compatibility
            $('[data-plugin-flickr]:not(.manual), ul.flickr-feed').each(function () {
                var $this = $(this),
					opts;

                var pluginOptions = $this.data('plugin-options');
                if (pluginOptions)
                    opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"'));

                $this.themePluginFlickr(opts);
            });
        });

    }

}).apply(this, [jQuery]);// Circle Slider
(function ($) {

    'use strict';

    if ($.isFunction($.fn.flipshow)) {
        var circleContainer = $('#fcSlideshow');

        if (circleContainer.get(0)) {
            circleContainer.flipshow();

            setTimeout(function circleFlip() {
                circleContainer.data().flipshow._navigate(circleContainer.find('div.fc-right span:first'), 'right');
                setTimeout(circleFlip, 3000);
            }, 3000);
        }
    }

}).apply(this, [jQuery]);