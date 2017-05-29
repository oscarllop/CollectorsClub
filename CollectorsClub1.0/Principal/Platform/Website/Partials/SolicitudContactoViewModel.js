define(['Globales/BaseViewModel', 'knockout', 'knockout.validation', 'Globales/ko.observableDictionary', 'WebAPI/Controllers/SolicitudContactoController', 'WebAPI/Models/SolicitudContactoModel', 'WebAPI/Controllers/MarcaController', 'WebAPI/Models/MarcaModel', 'Globales/Core.Utils', 'Globales/popup'], function (baseViewModel, ko, validation, observableDictionary, SolicitudContactoController, SolicitudContactoModel, MarcaController, MarcaModel, utils, popup) {
	try {
		return function SolicitudContactoViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);

			require(['global/knockout/localization/' + settings.Cultura ], function (locale) {
				validation.locale(settings.Cultura);
			});

			// #region Propiedades y métodos que difieren por entidad
			self.Entidad = 'SolicitudContacto';
			self.CamposVisiblesInsercion = { Id: true, Nombre: true, Asunto: true, Contenido: true, FechaAlta: true, FechaUltimaModificacion: true, IdMarca: true, CorreoElectronico: true };
			self.CamposVisiblesEdicion = { Id: true, Nombre: true, Asunto: true, Contenido: true, FechaAlta: true, FechaUltimaModificacion: true, IdMarca: true, CorreoElectronico: true };
			self.CamposHabilitadosInsercion = { Id: false, Nombre: true, Asunto: true, Contenido: true, FechaAlta: false, FechaUltimaModificacion: false, IdMarca: false, CorreoElectronico: true };
			self.CamposHabilitadosEdicion = { Id: false, Nombre: true, Asunto: true, Contenido: true, FechaAlta: false, FechaUltimaModificacion: false, IdMarca: false, CorreoElectronico: true };
			self.settings.VolveraInsertarAlGuardar = true;
			self.SerializarClave = function (registro) { return registro.Id; }
			self.EntidadesRelacionadas = ['Marca'];
			self.MetodoExtensionNew = 'PostExtension'


			// #region Métodos comúnes a todas las entidades
			self.FormatearFecha = utils.FormatearFecha;
			self.Select = function (registro) { baseViewModel.Select(self, registro); };
			self.New = function () { baseViewModel.New(self, SolicitudContactoModel, self.settings.DatosPorDefecto); };
			self.Cancel = function () { baseViewModel.Cancel(self); };
			self.Update = function (registro) { baseViewModel.Update(self, registro); };
			self.Delete = function (registro, pedirConfirmacion) { baseViewModel.Delete(self, registro, pedirConfirmacion); };
			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings, SolicitudContactoModel, self.settings.DatosPorDefecto);
				self.Registro().IdMarca(settings.IdMarca);
				baseViewModel.CapaCargando.Ocultar(self.settings.IdPartial + 'ContenedorCargando');
			};
			// #endregion Métodos comúnes a todas las entidades

			// #region Definición relaciones
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['SolicitudContactoController']) == 'undefined') { GlobalControllers['SolicitudContactoController'] = new SolicitudContactoController(settings); }
			// OLL: Este código no debería estar aquí, pero por ahora no funcionan bien los DescargarScripts
			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			self.Marcas = ko.lazyObservableArray(GlobalControllers['MarcaController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Marca_ObtenerCombo', 
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			// #endregion Definición relaciones

			// #region Métodos sobreescritos o añadidos
			self.settings.ErrorContainer = self.settings.IdPartial + 'Errores';
			self.settings.MostrarMensaje = function (placeholderSelector, mensaje, tipo, ocultar) {
				ocultar = false;
				if (typeof (tipo) === 'undefined') { tipo = 'Mensaje'; }
				var _estilo = '';
				switch (tipo) {
					case 'Correcto': _estilo = 'alert-success'; break;
					case 'Error': _estilo = 'alert-danger'; break;
					case 'Advertencia': _estilo = 'alert-warning'; break;
					default: _estilo = '';
				}

				$(placeholderSelector).stop();
				$(placeholderSelector).removeClass();
				$(placeholderSelector).addClass('alert ' + (typeof (_estilo) !== '' ? ' ' + _estilo : '')).html(mensaje);
				$(placeholderSelector).show();

				if (typeof (ocultar) === 'undefined' || ocultar) { $(placeholderSelector).fadeOut(10000, 'easeInExpo', function () { $(placeholderSelector).hide(); }); }
			}
			// #endregion Métodos sobreescritos o añadidos

			baseViewModel.InicializarViewModel(self, settings, SolicitudContactoModel);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
