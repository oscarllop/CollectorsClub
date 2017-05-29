define(['jquery', 'dojo/order!knockout', './Core.Utils', 'Globales/popup'], function ($, ko, utils, popup) {
	try {
		function BaseViewModel() {
			var self = this;

			self.InicializarViewModel = function (viewModel, settings) {
				viewModel.settings.InteraccionExterna = (typeof (viewModel.settings.InteraccionExterna) !== 'undefined' ? viewModel.settings.InteraccionExterna : false);
				viewModel.settings.ModuloPrincipal = (typeof (viewModel.settings.ModuloPrincipal) !== 'undefined' ? viewModel.settings.ModuloPrincipal : false);
				viewModel.settings.Modo = (typeof (viewModel.settings.Modo) !== 'undefined' ? viewModel.settings.Modo : ModoInicioModulo.Defecto);
				viewModel.settings.MostrarMensaje = (typeof (viewModel.settings.MostrarMensaje) !== 'undefined' ? viewModel.settings.MostrarMensaje : viewModel.settings.MostrarMensaje);
				viewModel.TraduccionCampos = ko.observableDictionary([]);
				viewModel.MetodosRespuesta = new Array();
				viewModel.Cargando = ko.observable(false);

				InicializarViewModel(viewModel, settings);

				viewModel.Inicializar(settings);
			};

			var InicializarViewModel = function (viewModel, settings) {
				viewModel.CargandoPartial = false;
			}

			self.CapaCargando = {
				Mostrar: utils.Cargando.Mostrar,
				Ocultar: utils.Cargando.Ocultar
			}

			self.Inicializar = function (viewModel, settings) {
				if (typeof (settings.MetodosRespuesta) !== 'undefined' && settings.MetodosRespuesta != null) { viewModel.MetodosRespuesta = settings.MetodosRespuesta; }
				viewModel.settings.Modo = (typeof (settings.Modo) !== 'undefined' && settings.Modo != null ? settings.Modo : ModoInicioModulo.Defecto);

				//OLL: Lo he incorporado. Ver que no falle con el gestor de archivos
				self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');

				// TODO: popup debería ser un parámetro del settings que se le pase a la partial de formulario, no un modo
				if (typeof (this.ExtendInicializar) !== 'undefined') { this.ExtendInicializar(this, viewModel, settings); }
			}

			function RegistrarController(controller, settings) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[controller]) == 'undefined') { eval('GlobalControllers[controller] = new ' + controller + '(settings)'); }
			}
		}
		return new BaseViewModel();
	} catch (excepcion) {
		console.log(excepcion);
	}
});