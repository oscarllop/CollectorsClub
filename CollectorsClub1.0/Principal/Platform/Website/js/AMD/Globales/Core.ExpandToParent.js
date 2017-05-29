define(['jquery'], function (jQuery) {
	(function ($) {
		$.fn.expandToParent = function (settings) {
			self.settings = $.extend({}, settings);
			return this.each(function () {
				var _elementoBase = $(this);

				if (!_elementoBase.data('ExpandToParentActivado')) {
					function expandir() {
						//console.log('Refrescando Expand to parent ' + _elementoBase.attr('id'));
						if (typeof (self.settings.SelectorPadre) !== 'undefined') {
							_elementoBase.css('width', _elementoBase.parents(self.settings.SelectorPadre).innerWidth() + 'px')
						} else {
							_elementoBase.css('width', (parseInt(_elementoBase.parent().innerWidth()) || 0) - parseInt((_elementoBase.parent().css('padding-left') || 0)) - parseInt((_elementoBase.parent().css('padding-right') || 0)) - parseInt((_elementoBase.parent().css('border-left') || 0)) - parseInt((_elementoBase.parent().css('border-right') || 0)) + 'px');
						}
					}

					function init() {
						_elementoBase.bind('refrescarExpandToParent', expandir);
						expandir();
						_elementoBase.data('ExpandToParentActivado', true);
					}

					$(window).resize(expandir);
					init();
				}
			});
		};
	})(jQuery);
});