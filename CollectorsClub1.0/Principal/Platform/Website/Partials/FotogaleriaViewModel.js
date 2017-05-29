define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/FotoController', 'WebAPI/Models/FotoModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, FotoController, FotoModel) {
	try {
		return function FotogaleriaViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'Foto';
			self.FormatearFecha = utils.FormatearFecha;

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[self.Entidad + 'Controller']) == 'undefined') { GlobalControllers[self.Entidad + 'Controller'] = new FotoController(settings); }

				self.Get(self);
			};

			self.Actualizar = function (parametros) { }

			self.Registros = ko.observableArray([]);
			self.Grupos = ko.computed(function () {
				var _grupos = new Array();
				$(self.Registros()).each(function (indice) {
					if (_grupos.length == 0 || _grupos.length > 0 && _grupos[_grupos.length - 1].Registros().length == 4) { _grupos.push({ Registros: ko.observableArray([]) }); }
					if (_grupos[_grupos.length - 1].Registros().length < 4) { _grupos[_grupos.length - 1].Registros().push(this); }
				});
				return _grupos
			});

			var _categoria = utils.ObtenerUltimoParametroQuerystring();
			var _idCategoria = (Math.floor(_categoria) == _categoria && $.isNumeric(_categoria) ? parseInt(_categoria) : null);

			self.FiltroPorDefecto = {
				IdDesde: null,
				IdHasta: null,
				OrdenDesde: null,
				OrdenHasta: null,
				IdCategoria: _idCategoria,
				Activa: true,
				Nombre: null,
				Descripcion: null,
				NombreArchivoImagen: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdMarca: self.settings.IdMarca,
			};
			self.MetodoObtenerPorFiltros = 'Foto_ObtenerPorFiltrosExtension';
			self.RegistroInicial = 1;
			self.RegistroFinal = 100000;
			self.ColumnaOrden = 'Apellidos';
			self.TipoOrden = 1;


			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=OrdenDesde|smallint|' + (typeof (filtro.OrdenDesde) !== 'undefined' && filtro.OrdenDesde !== null ? filtro.OrdenDesde : '') +
					'&parameter=OrdenHasta|smallint|' + (typeof (filtro.OrdenHasta) !== 'undefined' && filtro.OrdenHasta !== null ? filtro.OrdenHasta : '') +
					'&parameter=IdCategoria|int|' + (typeof (filtro.IdCategoria) !== 'undefined' && filtro.IdCategoria !== null ? filtro.IdCategoria : '') +
					'&parameter=Activa|bit|' + (typeof (filtro.Activa) !== 'undefined' && filtro.Activa !== null ? filtro.Activa : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|750' +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|-1' +
					'&parameter=NombreArchivoImagen|nvarchar|' + (typeof (filtro.NombreArchivoImagen) !== 'undefined' && filtro.NombreArchivoImagen !== null ? filtro.NombreArchivoImagen : '') + '|150' +
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
						$('#' + self.settings.IdPartial + 'ContenedorInterno').find('.lightbox').each(function () {
							var $this = $(this), opts;
							var pluginOptions = $this.data('plugin-options');
							if (pluginOptions) { opts = jQuery.parseJSON(pluginOptions.replace(/'/g, '\"')); }
							$this.themePluginLightbox(opts);
						});
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
