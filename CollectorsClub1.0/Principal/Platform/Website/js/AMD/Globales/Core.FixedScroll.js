define(['jquery'], function (jQuery) {
	(function ($) {
		$.fn.fix = function (settings) {
			return this.each(function () {
				var _elementoBase = $(this),
					_elementoFijo = null;

				if (!_elementoBase.data('FixedScrollActivado')) {
					function scrollElementoFijo() {
						if (_elementoBase.is(':visible')) {
							// OLL: Esto calculando aquí el parámetro. Tendríamos que definir una función que lo calcule en todo momento
							_top = (typeof (settings.CalcularPosicionSuperior) === 'function' ? settings.CalcularPosicionSuperior() : 0);
							var _offset = $(this).scrollTop(),
								_elementoAScrollar = (typeof (settings.ObtenerElementoAScrollar) === 'function' ? settings.ObtenerElementoAScrollar(_elementoBase) : _elementoBase),
								_offsetTop = _elementoAScrollar.offset().top - _top, 
								_offsetBottom = _offsetTop + _elementoAScrollar.height();
							if (_offset < _offsetTop || _offset > _offsetBottom) {
								if (typeof (settings.AntesEliminarElementoFijo) === 'function') { settings.AntesEliminarElementoFijo(_elementoBase, _elementoFijo); }
								if (_elementoFijo != null) { _elementoFijo.remove(); _elementoFijo = null; }
							} else if (_offset >= _offsetTop && _offset <= _offsetBottom) {
								if (_elementoFijo == null) {
									//_elementoFijo = (typeof (settings.CrearElementoFijo) === 'function' ? settings.CrearElementoFijo(_elementoBase) : _elementoBase.clone(true, true));
									if (typeof (settings.CrearElementoFijo) === 'function') {
										_elementoFijo = settings.CrearElementoFijo(_elementoBase);
									} else {
										// OLL: Si lo pongo a false porque se ejecutaban 2 veces los clicks de los botones. He quitado el databinding que se ejecuta en DespuesCrearElementoFijo.
										//_elementoFijo = _elementoBase.clone(true, false); 
										_elementoFijo = _elementoBase.clone(true, true);
									}
									_elementoFijo.css('top', _top + 'px');
									_elementoFijo.addClass("scrollfixed").insertBefore(_elementoBase);
									if (typeof (settings.DespuesCrearElementoFijo) === 'function') { settings.DespuesCrearElementoFijo(_elementoBase, _elementoFijo); }
									_elementoFijo.show();
								} else if (_offset > _offsetBottom - _elementoFijo.height()) {
									_elementoFijo.css('top', _offsetBottom - _offset - _elementoFijo.height() + _top);
								} else if (_elementoBase.css('top') != _top + 'px') {
									_elementoFijo.css('top', _top + 'px');
								}
							}
						}
					}

					function refrescar() {
						scrollElementoFijo();
						cambiarTamanyoElementoFijo();
					}

					function cambiarTamanyoElementoFijo() {
						//console.log('Refrescando el tamaño del fixed scroll' + _elementoBase.attr('id'));
						if (typeof (settings.CambiarTamanyoElementoFijo) === 'function' && _elementoFijo != null) { settings.CambiarTamanyoElementoFijo(_elementoBase, _elementoFijo); }
					}

					function init() {
						_elementoBase.bind('refrescarFix', refrescar);
						cambiarTamanyoElementoFijo();
						_elementoBase.data('FixedScrollActivado', true);
					}

					$(window).resize(cambiarTamanyoElementoFijo);
					$(window).scroll(scrollElementoFijo);
					init();
				}
			});
		};
	})(jQuery);
});