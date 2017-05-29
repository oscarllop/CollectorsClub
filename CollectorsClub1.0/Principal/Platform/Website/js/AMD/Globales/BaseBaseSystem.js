if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes de cargar dependencias'); }
define(['dojo/order!WebAPI/jquery.extensions', 'dojo/order!jquery', 'knockout', './Core.Utils', ], function (jqueryExtensions, $, ko, utils) {
	try {
		function BaseSystem() {
			if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Inicio clase'); }
			var self = this;

			self.init = function ($, ko, system, element) {
				if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Ejecutando init ' + system.settings.IdModulo); }
				var containerElement = system.settings.Container = element;

				require(['moment/moment-with-locales.min'], function (moment) {
					try {
						moment.locale(system.settings.Cultura);
					} catch (excepcion) {
						console.log(excepcion);
					}
				});

				if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Esperando viewmodel ' + system.settings.IdModulo); }
				require(['partials/' + system.settings.IdModulo + 'ViewModel'], function (viewModel) {
					//try {
						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - viewmodel cargado ' + system.settings.IdModulo); }
						system.ViewModel = new viewModel(system.settings);
						GlobalViewModels[system.settings.IdPartial + 'ViewModel'] = system.ViewModel;

						// Cargamos los recursos
						self.ObtenerRecursos(system);

						$(containerElement).css('visibility', 'hidden');
						$(containerElement).css('display', 'block');

						if (typeof (this.ExtendBeforeBinding) === 'function') { this.ExtendBeforeBinding(this, item); }

						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes de applybindings ' + system.settings.IdModulo); }
						ko.applyBindingsToDescendants(system.ViewModel, $(system.settings.Contenedor)[0]);
						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Después de applybindings ' + system.settings.IdModulo); }

						if (typeof (this.ExtendAfterBinding) === 'function') { this.ExtendAfterBinding(this, item); }

						$(containerElement).css('visibility', 'visible');

						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Fin. Módulo visible.' + system.settings.IdModulo); }
					//} catch (excepcion) {
					//	console.log(excepcion);
					//}
				});
				return true;
			};

			self.ObtenerRecursos = function (system) {
				require(['dojo/text!' + utils.RevisarUrl(system.RutaRecursos + '&Cultura=' + system.settings.Cultura)], function (recursos) {
					try {
						var _Recursos;
						eval('_Recursos = ' + recursos);
						system.settings.Recursos = _Recursos;
						system.settings.MensajeCargandoRegistros = _Recursos['CargandoRegistros_Text'];
						system.settings.MensajeCargandoRegistro = _Recursos['CargandoRegistro_Text'];
						system.settings.MensajeRegistroGuardado = _Recursos['RegistroGuardado_Text'];
						system.settings.MensajeRegistroEliminado = _Recursos['RegistroEliminado_Text'];
						system.settings.MensajeError = _Recursos['MensajeError_Text'];
						system.settings.MensajeEstaSeguroBorrar = _Recursos['MensajeEstaSeguroBorrar_Text'];
						system.settings.MensajeEstaSeguroBorrarSeleccionados = _Recursos['MensajeEstaSeguroBorrarSeleccionados_Text'];
						system.settings.MensajeRespuestaServicioVacia = _Recursos['MensajeRespuestaServicioVacia_Text'];
						system.settings.MensajeErrorValidacion = _Recursos['MensajeErrorValidacion_Text'];
						system.ViewModel.TraduccionCampos.pushAll(_Recursos);
					} catch (excepcion) {
						console.log(excepcion);
					}
				});
			}
		}
		if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Fin clase'); }
		return new BaseSystem();
	} catch (excepcion) {
		console.log(excepcion);
	}
});