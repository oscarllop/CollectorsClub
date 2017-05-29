define(['Globales/BaseBaseSystem', 'Globales/Core.Utils', 'partials/FotogaleriaViewModel', 'use!porto/js/skin'], function (baseSystem, utils, viewModel, skin) {
	try {
		return function FotogaleriaSystem($, ko, settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.System = self;
			self.Recursos = {},
			self.Repositorio = {};
			self.ViewModel;
			self.RutaRecursos = self.settings.ApplicationPath + '/DesktopModules/_extension/Recursos.aspx?Ruta=DesktopModules__CollectorsClub__Fotogaleria__App_LocalResources&Modulo=Fotogaleria';

			self.init = function (element) { return baseSystem.init($, ko, self, element); }

			// OLL ahora el init siempre retorna true. Ver como reconocer que el require del viewModel ha fallado. Un try catch?
			if (!self.init(self.settings.Contenedor)) {
				utils.MostrarMensaje('#' + self.settings.ErrorContainer, self.settings.MensajeErrorCarga, 'dnnFormError', false);
			}
		}
	} catch (excepcion) {
		console.log(excepcion);
	}
});
