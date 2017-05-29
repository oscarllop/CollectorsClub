// Progress Bar
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

}).apply(this, [jQuery]);

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