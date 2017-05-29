define(['jquery', 'dojo/order!knockout', './Core.Utils', 'Globales/popup'], function ($, ko, utils, popup) {
	function BaseViewModel() {
		var self = this;

		self.InicializarViewModel = function (viewModel, settings, modelo) {
			viewModel.settings.PermitirCrear = (typeof (viewModel.settings.PermitirCrear) !== 'undefined' ? viewModel.settings.PermitirCrear : true);
			viewModel.settings.PermitirGuardar = (typeof (viewModel.settings.PermitirGuardar) !== 'undefined' ? viewModel.settings.PermitirGuardar : true);
			viewModel.settings.PermitirBorrar = (typeof (viewModel.settings.PermitirBorrar) !== 'undefined' ? viewModel.settings.PermitirBorrar : true);
			viewModel.settings.InteraccionExterna = (typeof (viewModel.settings.InteraccionExterna) !== 'undefined' ? viewModel.settings.InteraccionExterna : false);
			viewModel.settings.ModuloPrincipal = (typeof (viewModel.settings.ModuloPrincipal) !== 'undefined' ? viewModel.settings.ModuloPrincipal : false);
			viewModel.settings.Modo = (typeof (viewModel.settings.Modo) !== 'undefined' ? viewModel.settings.Modo : ModoInicioModulo.Listado);
			//viewModel.TraduccionCampos = ko.observableDictionary(viewModel.settings.System.Recursos);
			viewModel.TraduccionCampos = ko.observableDictionary([]);
			viewModel.MetodosRespuesta = new Array();
			viewModel.FiltroFijado = ko.observable();
			viewModel.Cargando = ko.observable(false);

			InicializarViewModelEdicion(viewModel, settings, modelo);
			//viewModel.EntidadesRelacionadas.forEach(function (entidad) { RegistrarController(entidad + 'Controller', settings); });

			viewModel.Inicializar(settings);
		};

		var InicializarViewModelEdicion = function (viewModel, settings, modelo) {
			viewModel.MostrarElemento = ko.observable(viewModel.CamposVisiblesInsercion);
			viewModel.HabilitarElemento = ko.observable(viewModel.CamposHabilitadosInsercion);
			viewModel.CargandoPartial = false;
			viewModel.Registro = ko.validatedObservable(new modelo({}));
			viewModel.CargandoFormulario = ko.observable(false);
			viewModel.MostrarFormulario = ko.observable(false);
			viewModel.MostrarAcciones = ko.observable(!viewModel.settings.InteraccionExterna);
		}

		//self.AplicarFiltro = function (filtroExterno, filtroInterno, camposHabilitados) {
		//	for (var _propiedad in filtroExterno) {
		//		if (filtroExterno.hasOwnProperty(_propiedad)) {
		//			filtroInterno[_propiedad] = (typeof (filtroExterno[_propiedad]) === 'function' ? filtroExterno[_propiedad]() : filtroExterno[_propiedad]);
		//			if (typeof (camposHabilitados) !== 'undefined') { camposHabilitados[_propiedad] = false; }
		//		}
		//	}
		//}

		self.CapaCargando = {
			Mostrar: utils.Cargando.Mostrar,
			Ocultar: utils.Cargando.Ocultar
		}

		self.AplicarFiltro = function (filtroExterno, filtroInterno, camposHabilitados) {
			var _filtroExterno = ko.toJS(filtroExterno);
			for (var _propiedad in _filtroExterno) {
				if (_filtroExterno.hasOwnProperty(_propiedad) && ((ko.isObservable(filtroInterno) && filtroInterno().hasOwnProperty(_propiedad)) || filtroInterno.hasOwnProperty(_propiedad)) && _propiedad != 'IdMarca') {
					if (ko.isObservable(filtroInterno[_propiedad])) { filtroInterno[_propiedad](_filtroExterno[_propiedad]); } else { filtroInterno[_propiedad] = _filtroExterno[_propiedad]; }
					if (typeof (camposHabilitados) !== 'undefined') { camposHabilitados[_propiedad] = false; }
				}
			}
		}

		// OLL: Debería realizar un GetPorId, no un Get, pero no hay registro aún.
		self.Select = function (viewModel, registro, opciones) {
			viewModel.CargandoPartial = true; // OLL: Lo pongo porque así estaba en BaseViewModelEditor. Es correcto?
			viewModel.MostrarFormulario(true);
			GlobalControllers[viewModel.Entidad + 'Controller'].Get(viewModel.Registro, $.extend({
				Todos: true,
				PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
				PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
				RespuestaPeticionCorrecta: function (observable) {
					viewModel.CargandoPartial = false; // OLL: Lo pongo porque así estaba en BaseViewModelEditor. Es correcto?
					var _camposDeshabilitados = viewModel.CamposHabilitadosEdicion;
					if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltro(viewModel.FiltroFijado(), observable, _camposDeshabilitados); }
					viewModel.MostrarElemento(viewModel.CamposVisiblesEdicion);
					viewModel.HabilitarElemento(_camposDeshabilitados);
					if (typeof (viewModel.PostCargaFinalizada) !== 'undefined') { viewModel.PostCargaFinalizada(observable); }
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			}, opciones));
		};

		self.New = function (viewModel, modelo) {
			if (viewModel.settings.PermitirCrear) {
				viewModel.CargandoPartial = true;
				popup.AbrirDialogo(viewModel.settings.IdModulo + 'PanelFormulario', 1000, 600, 'Nueva...', _cerrarPopup(viewModel));
				viewModel.MostrarFormulario(true);
				var _datosPorDefecto = { IdMarca: viewModel.settings.IdMarca };
				var _camposDeshabilitados = viewModel.CamposHabilitadosInsercion;
				if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltro(viewModel.FiltroFijado(), _datosPorDefecto, _camposDeshabilitados); }
				viewModel.MostrarElemento(viewModel.CamposVisiblesInsercion);
				viewModel.HabilitarElemento(_camposDeshabilitados);
				viewModel.Registro(new modelo(_datosPorDefecto));
				viewModel.CargandoPartial = false;
			}
		};

		self.Update = function (viewModel, registro) {
			if (viewModel.settings.PermitirGuardar) {
				GlobalControllers[viewModel.Entidad + 'Controller'].Update(viewModel.Registro, registro, {
					PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
					PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
					MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (observable, registro) { }
				});
			}
		}

		self.Inicializar = function (viewModel, settings, modelo) {
			if (typeof (settings.Filtro) !== 'undefined' && settings.Filtro != null) {
				viewModel.FiltroFijado(settings.Filtro);
				self.AplicarFiltro(settings.Filtro, viewModel.Filtro());
			}
			if (typeof (settings.MetodosRespuesta) !== 'undefined' && settings.MetodosRespuesta != null) {
				if (typeof (settings.MetodosRespuesta.Actualizado) === 'function') { viewModel.MetodosRespuesta.Actualizado = settings.MetodosRespuesta.Actualizado; }
				if (typeof (settings.MetodosRespuesta.Insertado) === 'function') { viewModel.MetodosRespuesta.Insertado = settings.MetodosRespuesta.Insertado; }
			}
			viewModel.settings.Modo = (typeof (settings.Modo) !== 'undefined' && settings.Modo != null ? settings.Modo : ModoInicioModulo.Edicion);
			if (viewModel.settings.Modo == ModoInicioModulo.Insercion) {
				viewModel.New();
			} else if (viewModel.settings.Modo == ModoInicioModulo.Edicion) {
				viewModel.Select(new modelo(settings.Filtro));
			}
		}

		function RegistrarController(controller, settings) {
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[controller]) == 'undefined') { eval('GlobalControllers[controller] = new ' + controller + '(settings)'); }
		}
	}
	return new BaseViewModel();
});