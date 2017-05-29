define(['jquery'], function (jQuery) {
	(function ($) {
		$.fn.doubleScroll = function (settings) {
			return this.each(function () {
				var _elementoBase = $(this),
					_barraScroll = null,
					_contenedorScroll = null;

				if (!_elementoBase.data('DoubleScrollActivado')) {
					function cambiarTamanyoBarra() {
						//console.log('Refrescando double scroll de ' + _elementoBase.attr('id'));
						_barraScroll.css('width', _elementoBase.width() + 'px');
						_contenedorScroll.css('width', _elementoBase[0].scrollWidth + 'px');
						_barraScroll.css('display', _elementoBase.width() < _elementoBase[0].scrollWidth ? 'block' : 'none');
					}

					function init() {
						_barraScroll = _elementoBase.prev('.contenedorScrollSuperiorListado');
						_elementoBase.bind('refrescarDoubleScroll', cambiarTamanyoBarra);
						if (_barraScroll.length == 0) {
							_barraScroll = $('<div class="contenedorScrollSuperiorListado"><div class="contenedorScroll"></div></div>')
							_elementoBase.before(_barraScroll);
						}
						_contenedorScroll = _barraScroll.find('.contenedorScroll');
						if (!_elementoBase.hasClass('scrollSuperior')) { _elementoBase.addClass('scrollSuperior'); }
						cambiarTamanyoBarra();
						_elementoBase.scroll(function () { _barraScroll.scrollLeft(_elementoBase.scrollLeft()); });
						_barraScroll.scroll(function () { _elementoBase.scrollLeft(_barraScroll.scrollLeft()); });
						_elementoBase.data('DoubleScrollActivado', true);
					}

					$(window).resize(cambiarTamanyoBarra);
					init();
				}
			});
		};
	})(jQuery);
});