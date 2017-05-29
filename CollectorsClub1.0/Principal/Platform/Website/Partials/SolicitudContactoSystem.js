define(['Globales/BaseSystem', 'Globales/Core.Utils', 'partials/SolicitudContactoViewModel', 'use!porto/js/skin'], function (baseSystem, utils, viewModel, skin) {
	try {
		return function SolicitudContactoSystem($, ko, settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.System = self;
			self.Entidad = 'SolicitudContacto';
			self.Recursos = {},
			self.Repositorio = {};
			self.ViewModel;
			self.RutaRecursos = self.settings.ApplicationPath + '/DesktopModules/_extension/Recursos.aspx?Ruta=DesktopModules__CollectorsClub__SolicitudContacto__App_LocalResources&Modulo=SolicitudContacto';

			self.init = function (element) { return baseSystem.init($, ko, self, element); }
			self.IncluirSelectorColumnas = function (viewModel, containerElement) { baseSystem.IncluirSelectorColumnas($, ko, self, viewModel, containerElement); }
			self.GuardarColumnasSeleccionadasEnRepositorio = function (columnas) { baseSystem.GuardarColumnasSeleccionadasEnRepositorio(self, columnas); }
			self.ObtenerColumnasSeleccionadasDeRepositorio = function () { return baseSystem.ObtenerColumnasSeleccionadasDeRepositorio(self); }
			self.GuardarRegistrosFijosEnRepositorio = function (registros) { baseSystem.GuardarRegistrosFijosEnRepositorio(self, registros); }
			self.ObtenerRegistrosFijosDeRepositorio = function () { return baseSystem.ObtenerRegistrosFijosDeRepositorio(self); }
			self.GuardarFiltroEnRepositorio = function (filtro) { baseSystem.GuardarFiltroEnRepositorio(self, filtro); }
			self.ObtenerFiltroDeRepositorio = function () { return baseSystem.ObtenerFiltroDeRepositorio(self); }

			require(['global/knockout/localization/' + settings.Cultura], function (locale) {
				// OLL ahora el init siempre retorna true. Ver como reconocer que el require del viewModel ha fallado. Un try catch?
				if (!self.init(self.settings.Contenedor)) {
					utils.MostrarMensaje('#' + self.settings.ErrorContainer, self.settings.MensajeErrorCarga, 'dnnFormError', false);
				}
			});
		}
	} catch (excepcion) {
		console.log(excepcion);
	}
});
