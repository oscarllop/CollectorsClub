define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/PaginaGestorContenidosController', 'WebAPI/Models/PaginaGestorContenidosModel', 'WebAPI/Controllers/CategoriaFotoController', 'WebAPI/Models/CategoriaFotoModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, PaginaGestorContenidosController, PaginaGestorContenidosModel, CategoriaFotoController, CategoriaFotoModel) {
	try {
		return function MenuBarraLateralViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'PaginaGestorContenidos';
			self.FormatearFecha = utils.FormatearFecha;

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[self.Entidad + 'Controller']) == 'undefined') { GlobalControllers[self.Entidad + 'Controller'] = new PaginaGestorContenidosController(settings); }
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['CategoriaFotoController']) == 'undefined') { GlobalControllers['CategoriaFotoController'] = new CategoriaFotoController(settings); }

				if (self.settings.TabInfo.ParentId != -1) {
					self.Get(self);
				}
			};

			self.Actualizar = function (parametros) { }

			self.Registros = ko.observableArray([]);
			self.CategoriasFotos = ko.observableArray([]);

			self.FiltroPorDefecto = {
				IdDesde: null,
				IdHasta: null,
				OrdenDesde: null,
				OrdenHasta: null,
				Nombre: null,
				Descripcion: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdPadre: self.settings.TabInfo.ParentId
			};
			self.MetodoObtenerPorFiltros = 'PaginaGestorContenidos_ObtenerPorFiltrosExtension';
			self.RegistroInicial = 1;
			self.RegistroFinal = 100000;
			self.ColumnaOrden = 'Apellidos';
			self.TipoOrden = 1;


			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=OrdenDesde|smallint|' + (typeof (filtro.OrdenDesde) !== 'undefined' && filtro.OrdenDesde !== null ? filtro.OrdenDesde : '') +
					'&parameter=OrdenHasta|smallint|' + (typeof (filtro.OrdenHasta) !== 'undefined' && filtro.OrdenHasta !== null ? filtro.OrdenHasta : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|500' +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|500' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=IdPadre|int|' + (typeof (filtro.IdPadre) !== 'undefined' && filtro.IdPadre !== null ? filtro.IdPadre : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5'
			}

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
					RegistrosObtenidos: function (observable, registros) {
						var _categoria = utils.ObtenerUltimoParametroQuerystring();
						var _idCategoria = (Math.floor(_categoria) == _categoria && $.isNumeric(_categoria) ? parseInt(_categoria) : -1);
						return $.map(registros, function (registro) {
							registro.PaginaActual = (registro.Id == viewModel.settings.TabInfo.TabId);
							registro.Url = registro.Url.replace('//', '/');
							if (registro.Nombre == 'Fotogalería' || registro.Nombre == 'Photogallery' || registro.Nombre == 'Fotogaleria') {
								registro.Registros = ko.computed(function () {
									var _registros = new Array();
									$(self.CategoriasFotos()).each(function (indice) { _registros.push({ Id: 0, Nombre: this.Nombre, Url: registro.Url + '/' + this.Id, PaginaActual: (_idCategoria == -1 ? ((_categoria == 'Fotogalería' || _categoria == 'Photogallery' || _categoria == 'Fotogaleria') && _registros.length == 0) : (this.Id == _idCategoria)), VerEnNuevaVentana: false }); });
									return _registros;
								});
							} else if (registro.Nombre == 'Videoteca' || registro.Nombre == 'Video library') {
								registro.Registros = ko.computed(function () {
									var _registros = new Array();
									//$([2016, 2015, 2014, 2013]).each(function (indice) { _registros.push({ Id: 0, Nombre: this, Url: registro.Url + '/' + this, PaginaActual: (_idCategoria == -1 ? ((_categoria == 'Videoteca' || _categoria == 'Video-library' || _categoria == 'Videoteca') && _registros.length == 0) : (this == _idCategoria)), VerEnNuevaVentana: false }); });
									return _registros;
								});
							} else {
								registro.Registros = null;
							}
							return registro;
						});
					},
					RegistrosCargados: function (observable, registros) { },
					TamanyoPagina: function () { }
				}
			}

			self.Get = function (viewModel) {
				GlobalControllers[self.Entidad + 'Controller'].GetQuery(self.Registros, GenerarOpcionesObtenerRegistrosListado(self, self.FiltroPorDefecto));

				GlobalControllers['CategoriaFotoController'].GetQuery(self.CategoriasFotos, {
					Todos: true,
					Parameters: 'query=CategoriaFoto_ObtenerComboPorIdMarca' +
					'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
					'&parameter=Cultura|char|' + self.settings.Cultura + '|5',
					PrellamadaApi: function () { self.Cargando(true); },
					PostllamadaApi: function () { self.Cargando(false); },
					MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (observable) { },
				});
			}

			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
