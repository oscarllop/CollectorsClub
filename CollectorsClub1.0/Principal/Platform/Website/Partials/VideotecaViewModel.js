define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/VideoController', 'WebAPI/Models/VideoModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, VideoController, VideoModel) {
	try {
		return function VideotecaViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'Video';
			self.FormatearFecha = utils.FormatearFecha;

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[self.Entidad + 'Controller']) == 'undefined') { GlobalControllers[self.Entidad + 'Controller'] = new VideoController(settings); }

				self.Get(self);
			};

			self.Actualizar = function (parametros) { }

			self.Registros = ko.observableArray([]);

			self.FiltroPorDefecto = {
				IdDesde: null,
				IdHasta: null,
				Nombre: null,
				Descripcion: null,
				Url: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdMarca: self.settings.IdMarca,
			};
			self.MetodoObtenerPorFiltros = 'Video_ObtenerPorFiltrosExtension';
			self.RegistroInicial = 1;
			self.RegistroFinal = 100000;
			self.ColumnaOrden = 'Nombre';
			self.TipoOrden = 1;

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|250' +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|1000' +
					'&parameter=Url|varchar|' + (typeof (filtro.Url) !== 'undefined' && filtro.Url !== null ? filtro.Url : '') + '|250' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '');
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
					PeticionFinalizada: function (observable) {
						var _hash = window.location.hash;
						if (_hash != null && _hash != '') {
							var timeout = function () {
								if ($(_hash).length > 0) {
									$('html, body').animate({
										scrollTop: $(_hash).offset().top + 'px'
									}, 'fast');
								} else {
									setTimeout(function () { timeout(); }, 100);
								}
							}
							timeout();
						}
						baseViewModel.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
					},
					RegistrosObtenidos: function (observable, registros) { return registros; },
					RegistrosCargados: function (observable, registros) { },
					TamanyoPagina: function () { }
				}
			}


			self.Get = function (viewModel) {
				GlobalControllers[self.Entidad + 'Controller'].GetQuery(self.Registros, GenerarOpcionesObtenerRegistrosListado(self, self.FiltroPorDefecto));
			}

			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
