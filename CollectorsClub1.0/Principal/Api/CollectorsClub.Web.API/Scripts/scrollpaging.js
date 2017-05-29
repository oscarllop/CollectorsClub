/*
**	Anderson Ferminiano
**	contato@andersonferminiano.com -- feel free to contact me for bugs or new implementations.
**	jQuery ScrollPagination
**	28th/March/2011
**	http://andersonferminiano.com/jqueryscrollpagination/
**	You may use this script for free, but keep my credits.
**	Thank you.
*/

(function ($) {


	$.fn.scrollPagination = function (options) {
		var opts = $.extend($.fn.scrollPagination.defaults, options);
		var target = opts.scrollTarget;
		if (target == null) { target = obj; }
		opts.scrollTarget = target;

		return this.each(function () {
			$.fn.scrollPagination.init($(this), opts);
		});
	};

	$.fn.stopScrollPagination = function () {
		return this.each(function () {
			$(this).attr('scrollPagination', 'disabled');
		});
	};

	$.fn.scrollPagination.execute = function (obj, opts) {
		var target = opts.scrollTarget;
		var launchCallback = $(target).scrollTop() + opts.heightOffset >= $(document).height() - $(target).height();
		if (launchCallback && opts.callback != null) { opts.callback(); }
	};

	$.fn.scrollPagination.init = function (obj, opts) {
		var target = opts.scrollTarget;
		$(obj).attr('scrollPagination', 'enabled');

		$(target).scroll(function (event) {
			if ($(obj).attr('scrollPagination') == 'enabled') {
				$.fn.scrollPagination.execute(obj, opts);
			} else {
				event.stopPropagation();
			}
		});

		$.fn.scrollPagination.execute(obj, opts);
	};

	$.fn.scrollPagination.defaults = {
		'callback': null,
		'scrollTarget': null,
		'heightOffset': 0
	};
})(jQuery);