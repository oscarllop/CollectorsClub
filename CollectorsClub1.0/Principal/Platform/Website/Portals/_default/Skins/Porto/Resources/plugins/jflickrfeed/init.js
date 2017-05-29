// Flickr
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

}).apply(this, [jQuery]);