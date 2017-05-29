define(['Globales/BaseSystem', 'Globales/Core.Utils', 'partials/Video_IdiomaEditorViewModel', 'use!porto/js/skin', 'ParametrosGlobales', 'dojo/order!Plugins/ckeditor/ckeditor'], function (baseSystem, utils, viewModel, skin, parametrosGlobales, ckeditor) {
	try {
		return function Video_IdiomaEditorSystem($, ko, settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.System = self;
			self.Entidad = 'Video_Idioma';
			self.Recursos = {},
			self.Repositorio = {};
			self.ViewModel;
			self.RutaRecursos = self.settings.ApplicationPath + '/DesktopModules/_extension/Recursos.aspx?Ruta=DesktopModules__CollectorsClub__Editores__App_LocalResources&Modulo=Video_IdiomaEditorView';

			self.init = function (element) { return baseSystem.init($, ko, self, element); }
			self.IncluirSelectorColumnas = function (viewModel, containerElement) { baseSystem.IncluirSelectorColumnas($, ko, self, viewModel, containerElement); }
			self.GuardarColumnasSeleccionadasEnRepositorio = function (columnas) { baseSystem.GuardarColumnasSeleccionadasEnRepositorio(self, columnas); }
			self.ObtenerColumnasSeleccionadasDeRepositorio = function () { return baseSystem.ObtenerColumnasSeleccionadasDeRepositorio(self); }
			self.GuardarRegistrosFijosEnRepositorio = function (registros) { baseSystem.GuardarRegistrosFijosEnRepositorio(self, registros); }
			self.ObtenerRegistrosFijosDeRepositorio = function () { return baseSystem.ObtenerRegistrosFijosDeRepositorio(self); }
			self.GuardarFiltroEnRepositorio = function (filtro) { baseSystem.GuardarFiltroEnRepositorio(self, filtro); }
			self.ObtenerFiltroDeRepositorio = function () { return baseSystem.ObtenerFiltroDeRepositorio(self); }

			require(['Plugins/ckeditor/adapters/jquery', (parametrosGlobales.ApplicationPath == '/' ? '' : parametrosGlobales.ApplicationPath) + '/js/AMD/Plugins/ckeditor/lang/es.js?t=E8PB', (parametrosGlobales.ApplicationPath == '/' ? '' : parametrosGlobales.ApplicationPath) + '/js/AMD/Plugins/ckeditor/styles.js?t=E8PB'], function (jqueryAdapter, lang, styles) {
				try {
					// OLL ahora el init siempre retorna true. Ver como reconocer que el require del viewModel ha fallado. Un try catch?
					if (!self.init(self.settings.Contenedor)) {
						self.settings.MostrarMensaje('#' + self.settings.ErrorContainer, self.settings.MensajeErrorCarga, 'Error', false);
					}
				} catch (excepcion) {
					console.log(excepcion);
				}
			});
		}
	} catch (excepcion) {
		console.log(excepcion);
	}
});
