define(function () {
	// OLL: Mejora. Devolver objeto con el define. Declarar una propiedad para indicar el elemento de referencia y la capa de blqueo y así no tener que usar window.ParametrosGlobales.
	// Poner aquí los metodos de cargando de Core.Utils

	//window.checkForChanges = function () {
	//	var _elemento = $('#' + window.ParametrosGlobales.ElementoReferenciaCargando);
	//	var _contenedorCargando = $('#' + window.ParametrosGlobales.CapaBloqueoCargando);
	//	if (_elemento[0].clientWidth > 50 && _elemento[0].clientWidth != _contenedorCargando[0].clientWidth) { _contenedorCargando.css('width', _elemento[0].clientWidth + 'px'); }
	//	else if (_elemento[0].clientWidth == 0) { _contenedorCargando.css('width', _elemento.parent()[0].clientWidth + 'px'); }
	//	if (_elemento[0].clientHeight > 50 && _elemento[0].clientHeight != _contenedorCargando[0].clientHeight) { _contenedorCargando.css('height', _elemento[0].clientHeight + 'px'); }

	//	window.setTimeout(window.checkForChanges, 100);
	//}


	window.RevisarContenedoresCargando = function () {
		$('.ContenedorCargando:visible').each(function (indice, contenedorCargando) {
			var _$contenedorCargando = $(contenedorCargando);
			var _elemento = $('#' + _$contenedorCargando.data('elementoreferencia'));
			if (_elemento[0].clientWidth > 50 && _elemento[0].clientWidth != contenedorCargando.clientWidth) { _$contenedorCargando.css('width', _elemento[0].clientWidth + 'px'); }
			else if (_elemento[0].clientWidth == 0) { _$contenedorCargando.css('width', _elemento.parent()[0].clientWidth + 'px'); }
			if (_elemento[0].clientHeight > 50 && _elemento[0].clientHeight != contenedorCargando.clientHeight) { _$contenedorCargando.css('height', _elemento[0].clientHeight + 'px'); }
		});

		window.setTimeout(window.RevisarContenedoresCargando, 100);
	}

	window.setTimeout(window.RevisarContenedoresCargando, 100);
});
	