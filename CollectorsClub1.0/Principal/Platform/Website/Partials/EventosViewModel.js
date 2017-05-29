define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/EventoController', 'WebAPI/Models/EventoModel', 'WebAPI/Controllers/TipoEventoController', 'WebAPI/Models/TipoEventoModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, EventoController, EventoModel, TipoEventoController, TipoEventoModel) {
	try {
		return function EventosViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'Evento';
			self.FormatearFecha = utils.FormatearFecha;
			self.CadenaFormatoFecha = utils.CadenaFormatoFecha;
			self.CadenaFormatoHora = utils.CadenaFormatoHora;

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[self.Entidad + 'Controller']) == 'undefined') { GlobalControllers[self.Entidad + 'Controller'] = new EventoController(settings); }
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['TipoEventoController']) == 'undefined') { GlobalControllers['TipoEventoController'] = new TipoEventoController(settings); }

				self.Get(self);
			};

			self.Actualizar = function (parametros) { }

			self.Registros = ko.observableArray([]);
			self.RegistrosPorFecha = ko.computed(function () {
				var _registros = self.Registros();
				var _fechas = new Array();
				$(_registros).each(function (indice) {
					var _registro = this;
					if (_fechas.length == 0 || (_fechas.length > 0 && _fechas[_fechas.length - 1].Fecha != _registro.Fecha)) { _fechas.push({ Fecha: _registro.Fecha, Registros: ko.observableArray([]) }) }
					_fechas[_fechas.length - 1].Registros.push(_registro);
				});
				return _fechas;
			});
			self.TiposEvento = ko.observableArray([]);
			self.FiltroPorDefecto = {
				IdDesde: null,
				IdHasta: null,
				IdTipo: (utils.ObtenerUltimoParametroQuerystring().indexOf('cial') >= 0 ? 1 : 2),
				Activa: true,
				Nombre: null,
				FechaDesde: null,
				FechaHasta: null,
				HoraInicioDesde: null,
				HoraInicioHasta: null,
				HoraFinDesde: null,
				HoraFinHasta: null,
				Ubicacion: null,
				Descripcion: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdMarca: self.settings.IdMarca,
			};
			self.MetodoObtenerPorFiltros = 'Evento_ObtenerPorFiltrosExtensionOrdenadoPorFechaYHora';
			self.RegistroInicial = 1;
			self.RegistroFinal = 100000;
			self.ColumnaOrden = 'Fecha';
			self.TipoOrden = 1;

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=IdTipo|smallint|' + (typeof (filtro.IdTipo) !== 'undefined' && filtro.IdTipo !== null ? filtro.IdTipo : '') +
					'&parameter=Activa|bit|' + (typeof (filtro.Activa) !== 'undefined' && filtro.Activa !== null ? filtro.Activa : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|750' +
					'&parameter=FechaDesde|date|' + (typeof (filtro.FechaDesde) !== 'undefined' && filtro.FechaDesde !== null ? filtro.FechaDesde : '') +
					'&parameter=FechaHasta|date|' + (typeof (filtro.FechaHasta) !== 'undefined' && filtro.FechaHasta !== null ? filtro.FechaHasta : '') +
					'&parameter=HoraInicioDesde|time|' + (typeof (filtro.HoraInicioDesde) !== 'undefined' && filtro.HoraInicioDesde !== null ? filtro.HoraInicioDesde : '') +
					'&parameter=HoraInicioHasta|time|' + (typeof (filtro.HoraInicioHasta) !== 'undefined' && filtro.HoraInicioHasta !== null ? filtro.HoraInicioHasta : '') +
					'&parameter=HoraFinDesde|time|' + (typeof (filtro.HoraFinDesde) !== 'undefined' && filtro.HoraFinDesde !== null ? filtro.HoraFinDesde : '') +
					'&parameter=HoraFinHasta|time|' + (typeof (filtro.HoraFinHasta) !== 'undefined' && filtro.HoraFinHasta !== null ? filtro.HoraFinHasta : '') +
					'&parameter=Ubicacion|nvarchar|' + (typeof (filtro.Ubicacion) !== 'undefined' && filtro.Ubicacion !== null ? filtro.Ubicacion : '') + '|500' +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|-1' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '');
			}
			// #endregion Propiedades y métodos que difieren por entidad

			var GenerarOpcionesObtenerRegistrosListado = function (viewModel, filtro) {
				return {
					Todos: (viewModel.RegistroInicial <= 1),
					Parameters: 'query=' + viewModel.MetodoObtenerPorFiltros +
					'&parameter=RegistroInicial|int|' + viewModel.RegistroInicial +
					'&parameter=RegistroFinal|int|' + viewModel.RegistroFinal +
					'&parameter=ColumnaOrden|nvarchar|' + (ko.isObservable(viewModel.ColumnaOrden) ? viewModel.ColumnaOrden() : viewModel.ColumnaOrden) + '|50' +
					'&parameter=TipoOrden|smallint|' + (ko.isObservable(viewModel.TipoOrden) ? viewModel.TipoOrden() : viewModel.TipoOrden) + viewModel.ObtenerFiltros(filtro),
					PrellamadaApi: function () { viewModel.Cargando(true); },
					PostllamadaApi: function () { viewModel.Cargando(false); },
					MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (registros) { },
					PeticionFinalizada: function (observable) { baseViewModel.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); },
					RegistrosObtenidos: function (observable, registros) { return registros; },
					RegistrosCargados: function (observable, registros) { },
					TamanyoPagina: function () { }
				}
			}

			self.Get = function (viewModel) {
				GlobalControllers[self.Entidad + 'Controller'].GetQuery(self.Registros, GenerarOpcionesObtenerRegistrosListado(self, self.FiltroPorDefecto));

				GlobalControllers['TipoEventoController'].GetQuery(self.TiposEvento, {
					Todos: true,
					Parameters: 'query=TipoEvento_ObtenerComboPorIdMarca' +
					'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
					'&parameter=Cultura|char|' + self.settings.Cultura + '|5',
					PrellamadaApi: function () { self.Cargando(true); },
					PostllamadaApi: function () { self.Cargando(false); },
					MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (observable) { },
					RegistrosObtenidos: function (observable, registros) {
						$(registros).each(function () { this.Registros = ko.observableArray(); })
						return registros;
					},
				});
			}

			self.CadenaVacia = function (cadena) {
				return (cadena != null && cadena.trim() != '' && cadena.trim() != '&nbsp;');
			}
			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
