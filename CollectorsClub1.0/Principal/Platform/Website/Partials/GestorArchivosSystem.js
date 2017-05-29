define(['Globales/BaseBaseSystem', 'Globales/Core.Utils', 'partials/GestorArchivosViewModel', 'Plugins/DropZone/dropzone.knockout', 'jquery', 'adobeeditor'], function (baseSystem, utils, viewModel, kodropzone, $, adobeeditor) {
	try {
		return function GestorAcrhivosSystem($, ko, settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.System = self;
			self.Recursos = {},
			self.Repositorio = {};
			self.ViewModel;
			self.RutaRecursos = self.settings.ApplicationPath + '/DesktopModules/_extension/Recursos.aspx?Ruta=DesktopModules__Bailarte__Editores__App_LocalResources&Modulo=GestorArchivosView';

			self.CSDKImageEditor;
			self.IniciarAdobeEditor = function () {
				self.CSDKImageEditor = new Aviary.Feather({
					apiKey: 'd87df390040445719530009dbe47362f',
					onSave: function (idElementoImagen, nuevaUrl) {
						if (typeof (self.ViewModel.MetodoGuardarEdicionImagen) !== 'undefined') {
							self.ViewModel.MetodoGuardarEdicionImagen(idElementoImagen, nuevaUrl);
						} else {
							$('#' + idElementoImagen).attr('src', nuevaUrl);
							$('#' + idElementoImagen).removeAttr('id');
							self.CSDKImageEditor.close();
							console.log(nuevaUrl);
						}
					},
					onError: function (errorObj) {
						console.log(errorObj.code);
						console.log(errorObj.message);
						console.log(errorObj.args);
					}
				});
			}

			self.init = function (element) {
				self.IniciarAdobeEditor();
				var _respuesta = baseSystem.init($, ko, self, element);
				return _respuesta;
			}

			// OLL ahora el init siempre retorna true. Ver como reconocer que el require del viewModel ha fallado. Un try catch?
			if (!self.init(self.settings.Contenedor)) {
				utils.MostrarMensaje('#' + self.settings.ErrorContainer, self.settings.MensajeErrorCarga, 'dnnFormError', false);
			}
		}
	} catch (excepcion) {
		console.log(excepcion);
	}
});
