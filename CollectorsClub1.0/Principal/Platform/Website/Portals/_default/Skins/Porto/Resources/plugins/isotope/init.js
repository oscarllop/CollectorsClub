// Sort
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

}).apply(this, [jQuery]);