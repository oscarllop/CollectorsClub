define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/CalendarioController', 'WebAPI/Models/CalendarioModel', 'WebAPI/Controllers/UsuarioController', 'WebAPI/Models/UsuarioModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, CalendarioController, CalendarioModel, UsuarioController, UsuarioModel) {
	try {
		return function DestacadosBarraLateralViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'Usuario';
			self.FormatearFecha = utils.FormatearFecha;

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['CalendarioController']) == 'undefined') { GlobalControllers['CalendarioController'] = new CalendarioController(settings); }
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['UsuarioController']) == 'undefined') { GlobalControllers['UsuarioController'] = new UsuarioController(settings); }

				self.Get(self);
			};

			self.Actualizar = function (parametros) { }

			self.Calendarios = ko.observableArray([]);
			self.CalendariosDestacados = ko.computed(function () {
				var _registros = self.Calendarios();
				var _cantidad = _registros.length;
				if (_cantidad > 0) {
					var _primero = Math.floor(Math.random() * _cantidad);
					var _segundo = _primero;
					while (_segundo == _primero) { _segundo = Math.floor(Math.random() * _cantidad); }
					var _tercero = _primero;
					while (_tercero == _primero || _tercero == _segundo) { _tercero = Math.floor(Math.random() * _cantidad); }
					return [_registros[_primero], _registros[_segundo], _registros[_tercero]];
				} else {
					return [];
				}
			});
			self.FiltroPorDefectoCalendarios = {
				IdDesde: null,
				IdHasta: null,
				OrdenDesde: null,
				OrdenHasta: null,
				Activo: true,
				AsistenciaConfirmada: null,
				Nombre: null,
				Destacado: null,
				DestacadoLateral: true,
				Apellidos: null,
				IdPais: null,
				Cargo: null,
				Empresa: null,
				Ciudad: null,
				Descripcion: null,
				NombreArchivoImagen: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdMarca: self.settings.IdMarca,
				DestacadoEnFrasesListado: null
			};
			self.MetodoObtenerPorFiltrosCalendarios = 'Calendario_ObtenerPorFiltrosExtension';
			self.RegistroInicial = 1;
			self.RegistroFinal = 10000;
			self.ColumnaOrden = 'Apellidos';
			self.TipoOrden = 1;

			self.ObtenerFiltrosCalendarios = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=OrdenDesde|smallint|' + (typeof (filtro.OrdenDesde) !== 'undefined' && filtro.OrdenDesde !== null ? filtro.OrdenDesde : '') +
					'&parameter=OrdenHasta|smallint|' + (typeof (filtro.OrdenHasta) !== 'undefined' && filtro.OrdenHasta !== null ? filtro.OrdenHasta : '') +
					'&parameter=Activo|bit|' + (typeof (filtro.Activo) !== 'undefined' && filtro.Activo !== null ? filtro.Activo : '') +
					'&parameter=AsistenciaConfirmada|bit|' + (typeof (filtro.AsistenciaConfirmada) !== 'undefined' && filtro.AsistenciaConfirmada !== null ? filtro.AsistenciaConfirmada : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|500' +
					'&parameter=Destacado|bit|' + (typeof (filtro.Destacado) !== 'undefined' && filtro.Destacado !== null ? filtro.Destacado : '') +
					'&parameter=DestacadoLateral|bit|' + (typeof (filtro.DestacadoLateral) !== 'undefined' && filtro.DestacadoLateral !== null ? filtro.DestacadoLateral : '') +
					'&parameter=Apellidos|nvarchar|' + (typeof (filtro.Apellidos) !== 'undefined' && filtro.Apellidos !== null ? filtro.Apellidos : '') + '|500' +
					'&parameter=IdPais|int|' + (typeof (filtro.IdPais) !== 'undefined' && filtro.IdPais !== null ? filtro.IdPais : '') +
					'&parameter=Cargo|nvarchar|' + (typeof (filtro.Cargo) !== 'undefined' && filtro.Cargo !== null ? filtro.Cargo : '') + '|500' +
					'&parameter=Empresa|nvarchar|' + (typeof (filtro.Empresa) !== 'undefined' && filtro.Empresa !== null ? filtro.Empresa : '') + '|500' +
					'&parameter=Ciudad|nvarchar|' + (typeof (filtro.Ciudad) !== 'undefined' && filtro.Ciudad !== null ? filtro.Ciudad : '') + '|500' +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|-1' +
					'&parameter=NombreArchivoImagen|nvarchar|' + (typeof (filtro.NombreArchivoImagen) !== 'undefined' && filtro.NombreArchivoImagen !== null ? filtro.NombreArchivoImagen : '') + '|500' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '|3') +
					'&parameter=DestacadoEnFrasesListado|bit|' + (typeof (filtro.DestacadoEnFrasesListado) !== 'undefined' && filtro.DestacadoEnFrasesListado !== null ? filtro.DestacadoEnFrasesListado : '');
			}

			var GenerarOpcionesObtenerCalendariosListado = function (viewModel, filtro) {
				return {
					Todos: (viewModel.RegistroInicial <= 1),
					Parameters: 'query=' + viewModel.MetodoObtenerPorFiltrosCalendarios +
					'&parameter=RegistroInicial|int|' + viewModel.RegistroInicial +
					'&parameter=RegistroFinal|int|' + viewModel.RegistroFinal +
					'&parameter=ColumnaOrden|nvarchar|' + (ko.isObservable(viewModel.ColumnaOrden) ? viewModel.ColumnaOrden() : viewModel.ColumnaOrden) + '|50' +
					'&parameter=TipoOrden|smallint|' + (ko.isObservable(viewModel.TipoOrden) ? viewModel.TipoOrden() : viewModel.TipoOrden) + viewModel.ObtenerFiltrosCalendarios(filtro),
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

			self.UrlCalendarios = function () {
				switch (self.settings.Cultura) {
					case 'es-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Qué-es-BMP/Calendarios/Detalle';
					case 'en-US': return self.settings.ApplicationPath + self.settings.Cultura + '/What-is-BMP/Calendarios/Detail';
					case 'ca-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Què-és-BMP/Calendarios/Detall';
				}
			}

			self.Usuarios = ko.observableArray([]);
			self.UsuariosDestacados = ko.computed(function () {
				var _registros = self.Usuarios();
				var _cantidad = _registros.length;
				if (_cantidad > 0) {
					var _primero = Math.floor(Math.random() * _cantidad);
					var _segundo = _primero;
					while (_segundo == _primero) { _segundo = Math.floor(Math.random() * _cantidad); }
					var _tercero = _primero;
					while (_tercero == _primero || _tercero == _segundo) { _tercero = Math.floor(Math.random() * _cantidad); }
					return [_registros[_primero], _registros[_segundo], _registros[_tercero]];
				} else {
					return [];
				}
			});
			self.FiltroPorDefectoUsuarios = {
				IdDesde: null,
				IdHasta: null,
				OrdenDesde: null,
				OrdenHasta: null,
				Activo: true,
				AsistenciaConfirmada: null,
				Destacado: null,
				DestacadoLateral: true,
				Nombre: null,
				Apellidos: null,
				IdPais: null,
				Cargo: null,
				Empresa: null,
				Ciudad: null,
				EsUsuario: true,
				EsModerador: true,
				Descripcion: null,
				NombreArchivoImagen: null,
				FechaAltaDesde: null,
				FechaAltaHasta: null,
				FechaUltimaModificacionDesde: null,
				FechaUltimaModificacionHasta: null,
				Cultura: self.settings.Cultura,
				IdMarca: self.settings.IdMarca,
			};
			self.MetodoObtenerPorFiltrosUsuarios = 'Usuario_ObtenerPorFiltrosExtensionFront';
			self.RegistroInicial = 1;
			self.RegistroFinal = 10000;
			self.ColumnaOrden = 'Apellidos';
			self.TipoOrden = 1;

			self.ObtenerFiltrosUsuarios = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=OrdenDesde|smallint|' + (typeof (filtro.OrdenDesde) !== 'undefined' && filtro.OrdenDesde !== null ? filtro.OrdenDesde : '') +
					'&parameter=OrdenHasta|smallint|' + (typeof (filtro.OrdenHasta) !== 'undefined' && filtro.OrdenHasta !== null ? filtro.OrdenHasta : '') +
					'&parameter=Activo|bit|' + (typeof (filtro.Activo) !== 'undefined' && filtro.Activo !== null ? filtro.Activo : '') +
					'&parameter=AsistenciaConfirmada|bit|' + (typeof (filtro.AsistenciaConfirmada) !== 'undefined' && filtro.AsistenciaConfirmada !== null ? filtro.AsistenciaConfirmada : '') +
					'&parameter=Destacado|bit|' + (typeof (filtro.Destacado) !== 'undefined' && filtro.Destacado !== null ? filtro.Destacado : '') +
					'&parameter=DestacadoLateral|bit|' + (typeof (filtro.DestacadoLateral) !== 'undefined' && filtro.DestacadoLateral !== null ? filtro.DestacadoLateral : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|500' +
					'&parameter=Apellidos|nvarchar|' + (typeof (filtro.Apellidos) !== 'undefined' && filtro.Apellidos !== null ? filtro.Apellidos : '') + '|500' +
					'&parameter=IdPais|int|' + (typeof (filtro.IdPais) !== 'undefined' && filtro.IdPais !== null ? filtro.IdPais : '') +
					'&parameter=Cargo|nvarchar|' + (typeof (filtro.Cargo) !== 'undefined' && filtro.Cargo !== null ? filtro.Cargo : '') + '|500' +
					'&parameter=Empresa|nvarchar|' + (typeof (filtro.Empresa) !== 'undefined' && filtro.Empresa !== null ? filtro.Empresa : '') + '|500' +
					'&parameter=Ciudad|nvarchar|' + (typeof (filtro.Ciudad) !== 'undefined' && filtro.Ciudad !== null ? filtro.Ciudad : '') + '|500' +
					'&parameter=EsUsuario|bit|' + (typeof (filtro.EsUsuario) !== 'undefined' && filtro.EsUsuario !== null ? filtro.EsUsuario : '') +
					'&parameter=EsModerador|bit|' + (typeof (filtro.EsModerador) !== 'undefined' && filtro.EsModerador !== null ? filtro.EsModerador : '') +
					'&parameter=Descripcion|nvarchar|' + (typeof (filtro.Descripcion) !== 'undefined' && filtro.Descripcion !== null ? filtro.Descripcion : '') + '|-1' +
					'&parameter=NombreArchivoImagen|nvarchar|' + (typeof (filtro.NombreArchivoImagen) !== 'undefined' && filtro.NombreArchivoImagen !== null ? filtro.NombreArchivoImagen : '') + '|500' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '|3');
			}

			var GenerarOpcionesObtenerUsuariosListado = function (viewModel, filtro) {
				return {
					Todos: (viewModel.RegistroInicial <= 1),
					Parameters: 'query=' + viewModel.MetodoObtenerPorFiltrosUsuarios +
					'&parameter=RegistroInicial|int|' + viewModel.RegistroInicial +
					'&parameter=RegistroFinal|int|' + viewModel.RegistroFinal +
					'&parameter=ColumnaOrden|nvarchar|' + (ko.isObservable(viewModel.ColumnaOrden) ? viewModel.ColumnaOrden() : viewModel.ColumnaOrden) + '|50' +
					'&parameter=TipoOrden|smallint|' + (ko.isObservable(viewModel.TipoOrden) ? viewModel.TipoOrden() : viewModel.TipoOrden) + viewModel.ObtenerFiltrosUsuarios(filtro),
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

			self.UrlUsuarios = function () {
				switch (self.settings.Cultura) {
					case 'es-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Symposium/Moderadores-y-Usuarios/Detalle';
					case 'en-US': return self.settings.ApplicationPath + self.settings.Cultura + '/Symposium/Moderators-and-speakers/Detail';
					case 'ca-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Simposi/Moderadors-i-ponents/Detall';
				}
			}

			self.Get = function (viewModel) {
				//GlobalControllers['CalendarioController'].GetQuery(self.Calendarios, GenerarOpcionesObtenerCalendariosListado(self, self.FiltroPorDefectoCalendarios));
				//GlobalControllers['UsuarioController'].GetQuery(self.Usuarios, GenerarOpcionesObtenerUsuariosListado(self, self.FiltroPorDefectoUsuarios));
			}

			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
