if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Main: Antes de obtener dependencias'); }
require(['ParametrosGlobales', 'knockout', 'dojox/json/ref', 'Globales/Cargando', 'Globales/Partials', 'WebAPI/knockout.mapping-latest', 'jquery', 'Globales/Error', 'DNN/dnn.modalpopup', 'global/bootstrap/js/bootstrap.min', 'Globales/popup'], function (parametrosGlobales, ko, dojoref, cargando, partials, mapping, $, error, modalPopup, bootstrap, popup) {
	if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Iniciando main'); }
	window.ko = ko;
	window.ko.mapping = mapping;

	// Deshabilita los eventos del link del menú que se está visualizando para evitar que se disparen eventos de validación al ir desde el menú a la misma página
	function DeshabilitarEventosMenuitemActual() {
		var old_element = $('.subcurrent a').get(0);
		if (old_element != null) {
			var new_element = old_element.cloneNode(true);
			old_element.parentNode.replaceChild(new_element, old_element);
		}
	}
	DeshabilitarEventosMenuitemActual();

	partials.InicializarGlobalStylesheets();
	if (!$("#dvContenedorTipoColeccionCalendario_IdiomaEditor #PanelListado").length) {
		require(['dojo/text!' + parametrosGlobales.RutaPartials + '/TipoColeccionCalendario_IdiomaEditorView.html'], function (contenidoHtml) {
			try {
				var _parametros = $.extend({
					PermitirCrear: false,
					PermitirGuardar: true,
					PermitirBorrar: false,
					BusquedaAutomatica: true,
					IdModulo: 'TipoColeccionCalendario_IdiomaEditor',
					Contenedor: '#dvContenedorTipoColeccionCalendario_IdiomaEditor',
					TamanyoPagina: 50,
					ColumnaOrden: 'FechaAlta',
					TipoOrden: 0
				}, parametrosGlobales);
				$("#dvContenedorTipoColeccionCalendario_IdiomaEditor").html(contenidoHtml.replace(/~\//g, _parametros.ApplicationPath));
				if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Cargado contenido ' + _parametros.IdModulo); }
				TipoColeccionCalendario_IdiomaEditor_Iniciar(_parametros);
			} catch (exception) {
				console.error(exception);
			}
		});
	}
});