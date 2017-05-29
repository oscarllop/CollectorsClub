// Chart Circular
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

}).apply(this, [jQuery]);