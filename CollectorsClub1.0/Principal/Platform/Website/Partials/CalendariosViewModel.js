define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup', 'WebAPI/Controllers/CalendarioController', 'WebAPI/Models/CalendarioModel', 'WebAPI/Controllers/TipoColeccionCalendarioController', 'WebAPI/Models/TipoColeccionCalendarioModel', 'WebAPI/Controllers/CategoriaCalendarioController', 'WebAPI/Models/CategoriaCalendarioModel', 'WebAPI/Controllers/SubcategoriaCalendarioController', 'WebAPI/Models/SubcategoriaCalendarioModel', 'WebAPI/Controllers/EstadoCalendarioController', 'WebAPI/Models/EstadoCalendarioModel', 'WebAPI/Controllers/EntidadController', 'WebAPI/Models/EntidadModel', 'WebAPI/Controllers/FabricanteController', 'WebAPI/Models/FabricanteModel', 'WebAPI/Controllers/UsuarioController', 'WebAPI/Models/UsuarioModel'], function (baseViewModel, ko, validation, observableDictionary, utils, popup, CalendarioController, CalendarioModel, TipoColeccionCalendarioController, TipoColeccionCalendarioModel, CategoriaCalendarioController, CategoriaCalendarioModel, SubcategoriaCalendarioController, SubcategoriaCalendarioModel, EstadoCalendarioController, EstadoCalendarioModel, EntidadController, EntidadModel, FabricanteController, FabricanteModel, UsuarioController, UsuarioModel) {
	try {
		return function CalendariosViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.Entidad = 'Calendario';
			self.FormatearFecha = utils.FormatearFecha;
			self.CamposHabilitadosFiltro = { Id: true, IdsTipoColeccion: true, IdsCategoria: true, IdsSubcategoria: true, Visible: true, Imagen: true, Nombre: true, IdsEstado: true, Anyo: true, IdsEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdsEntidadContratante: true, DL: true, Variante: true, IdsFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true, Cultura: false, IdMarca: true };
			self.EntidadesRelacionadas = ['TipoColeccionCalendario', 'CategoriaCalendario', 'SubcategoriaCalendario', 'EstadoCalendario', 'Entidad', 'Fabricante', 'Usuario'];

			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			self.Inicializar = function (settings) {
				baseViewModel.Inicializar(self, settings);
				self.OpcionesFiltrosBooleanos = ko.observableArray([{ Nombre: self.TraduccionCampos.get('Todos_Text'), Valor: 'null' }, { Nombre: self.TraduccionCampos.get('Si_Text'), Valor: 'true' }, { Nombre: self.TraduccionCampos.get('No_Text'), Valor: 'false' }]);
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[self.Entidad + 'Controller']) == 'undefined') { GlobalControllers[self.Entidad + 'Controller'] = new CalendarioController(settings); }

				self.Get(self);
			};

			self.Actualizar = function (parametros) { }

			self.HabilitarFiltro = ko.observable(self.CamposHabilitadosFiltro);
			self.FiltroModificado = ko.observable(false);
			self.ListadoCargado = ko.observable(false);
			self.IdsRegistrosFijos = [];
			self.Registros = ko.observableArray([]);

			self.ElementosPorGrupo = 3;
			self.Grupos = ko.computed(function () {
				var _grupos = new Array();
				$(self.Registros()).each(function (indice) {
					if (_grupos.length == 0 || _grupos.length > 0 && _grupos[_grupos.length - 1].Registros().length == self.ElementosPorGrupo) { _grupos.push({ Registros: ko.observableArray([]) }); }
					if (_grupos[_grupos.length - 1].Registros().length < self.ElementosPorGrupo) { _grupos[_grupos.length - 1].Registros().push(this); }
				});
				return _grupos
			});
			self.FiltroPorDefecto = {
				IdDesde: ko.observable(),
				IdHasta: ko.observable(),
				IdsTipoColeccion: ko.observable(),
				IdsCategoria: ko.observableArray(),
				IdsSubcategoria: ko.observableArray(),
				Visible: ko.observable(null),
				Imagen: ko.observable(),
				Nombre: ko.observable(),
				IdsEstado: ko.observable(),
				Anyo: ko.observable(),
				IdsEntidad: ko.observableArray(),
				Serie: ko.observable(),
				TieneRepetidos: ko.observable(),
				NumeroSerie: ko.observable(),
				IdsEntidadContratante: ko.observableArray(),
				DL: ko.observable(),
				Variante: ko.observable(),
				IdsFabricante: ko.observableArray(),
				PaginaWeb: ko.observable(),
				Codigo: ko.observable(),
				IdUsuario: ko.observable(),
				Cultura: ko.observable(self.settings.Cultura),
				IdMarca: ko.observable(self.settings.IdMarca),
			};
			self.Filtro = ko.observable(self.FiltroPorDefecto);
			self.MetodoObtenerPorFiltros = 'Calendario_ObtenerPorFiltrosExtensionFront';
			self.RegistroInicial = 1;
			self.RegistroFinal = 100000;
			self.ColumnaOrden = 'Nombre';
			self.TipoOrden = 1;

			self.TodosIdsTipoColeccion = [];
			self.TodosIdsCategoria = [];
			self.TodosIdsSubcategoria = [];
			self.TodosIdsEstado = [];
			self.TodosIdsEntidad = [];
			self.TodosIdsFabricante = [];

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=IdsTipoColeccion|smallint|' + (typeof (filtro.IdsTipoColeccion) !== 'undefined' && (filtro.IdsTipoColeccion !== null && filtro.IdsTipoColeccion.length != self.TodosIdsTipoColeccion.length) ? filtro.IdsTipoColeccion.join() : '') + '|100' +
					'&parameter=IdsCategoria|varchar|' + (typeof (filtro.IdsCategoria) !== 'undefined' && (filtro.IdsCategoria !== null && filtro.IdsCategoria.length != self.TodosIdsCategoria.length) ? filtro.IdsCategoria.join() : '') + '|500' +
					'&parameter=IdsSubcategoria|varchar|' + (typeof (filtro.IdsSubcategoria) !== 'undefined' && (filtro.IdsSubcategoria !== null && filtro.IdsSubcategoria.length != self.TodosIdsSubcategoria.length) ? filtro.IdsSubcategoria.join() : '') + '|500' + 
					'&parameter=Visible|bit|' + (typeof (filtro.Visible) !== 'undefined' && filtro.Visible !== null ? filtro.Visible : '') +
					'&parameter=Imagen|nvarchar|' + (typeof (filtro.Imagen) !== 'undefined' && filtro.Imagen !== null ? filtro.Imagen : '') + '|50' +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|50' +
					'&parameter=IdsEstado|varchar|' + (typeof (filtro.IdsEstado) !== 'undefined' && (filtro.IdsEstado !== null && filtro.IdsEstado.length != self.TodosIdsEstado.length) ? filtro.IdsEstado.join() : '') + '|50' + 
					'&parameter=Anyo|varchar|' + (typeof (filtro.Anyo) !== 'undefined' && filtro.Anyo !== null ? filtro.Anyo : '') + '|50' +
					'&parameter=IdsEntidad|varchar|' + (typeof (filtro.IdsEntidad) !== 'undefined' && (filtro.IdsEntidad !== null && filtro.IdsEntidad.length != self.TodosIdsEntidad.length) ? filtro.IdsEntidad.join() : '') + '|2000' + 
					'&parameter=Serie|nvarchar|' + (typeof (filtro.Serie) !== 'undefined' && filtro.Serie !== null ? filtro.Serie : '') + '|50' +
					//'&parameter=NumeroRepetidosDesde|smallint|' + (typeof (filtro.NumeroRepetidosDesde) !== 'undefined' && filtro.NumeroRepetidosDesde !== null ? filtro.NumeroRepetidosDesde : '') +
					//'&parameter=NumeroRepetidosHasta|smallint|' + (typeof (filtro.NumeroRepetidosHasta) !== 'undefined' && filtro.NumeroRepetidosHasta !== null ? filtro.NumeroRepetidosHasta : '') +
					'&parameter=NumeroRepetidosDesde|smallint|' + (typeof (filtro.TieneRepetidos) !== 'undefined' && filtro.TieneRepetidos !== null ? 0 : '') +
					'&parameter=NumeroRepetidosHasta|smallint|' + (typeof (filtro.TieneRepetidos) !== 'undefined' && filtro.TieneRepetidos !== null ? 1000 : '') +
					'&parameter=NumeroSerie|nvarchar|' + (typeof (filtro.NumeroSerie) !== 'undefined' && filtro.NumeroSerie !== null ? filtro.NumeroSerie : '') + '|50' +
					'&parameter=IdsEntidadContratante|varchar|' + (typeof (filtro.IdsEntidadContratante) !== 'undefined' && (filtro.IdsEntidadContratante !== null && filtro.IdsEntidadContratante.length != self.TodosIdsEntidad.length) ? filtro.IdsEntidadContratante.join() : '') + '|2000' + 
					'&parameter=DL|nvarchar|' + (typeof (filtro.DL) !== 'undefined' && filtro.DL !== null ? filtro.DL : '') + '|50' +
					'&parameter=Variante|nvarchar|' + (typeof (filtro.Variante) !== 'undefined' && filtro.Variante !== null ? filtro.Variante : '') + '|50' +
					'&parameter=IdsFabricante|varchar|' + (typeof (filtro.IdsFabricante) !== 'undefined' && (filtro.IdsFabricante !== null && filtro.IdsFabricante.length != self.TodosIdsFabricante.length) ? filtro.IdsFabricante.join() : '') + '|2000' + 
					'&parameter=PaginaWeb|nvarchar|' + (typeof (filtro.PaginaWeb) !== 'undefined' && filtro.PaginaWeb !== null ? filtro.PaginaWeb : '') + '|100' +
					'&parameter=Codigo|varchar|' + (typeof (filtro.Codigo) !== 'undefined' && filtro.Codigo !== null ? filtro.Codigo : '') + '|50' +
					'&parameter=IdUsuario|int|' + (typeof (filtro.IdUsuario) !== 'undefined' && filtro.IdUsuario !== null ? filtro.IdUsuario : '') +
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
					PeticionFinalizada: function (observable) { baseViewModel.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); },
					RegistrosObtenidos: function (observable, registros) { return registros; },
					RegistrosCargados: function (observable, registros) { },
					TamanyoPagina: function () { }
				}
			}

			self.Get = function (viewModel) {
				GlobalControllers[self.Entidad + 'Controller'].GetQuery(self.Registros, GenerarOpcionesObtenerRegistrosListado(self, ko.toJS(self.Filtro)));
			}

			self.Buscar = function (viewModel) {
				GlobalControllers[self.Entidad + 'Controller'].GetQuery(self.Registros, GenerarOpcionesObtenerRegistrosListado(self, ko.toJS(self.Filtro)));
				return true;
			}

			self.RestablecerFiltroPorDefecto = function (viewModel) {
				self.Filtro(self.FiltroPorDefecto);
			}

			self.Url = function () {
				switch (self.settings.Cultura) {
					case 'es-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Colecciones/Calendarios/Detalle';
					case 'en-US': return self.settings.ApplicationPath + self.settings.Cultura + '/Collections/Calendars/Detail';
					case 'ca-ES': return self.settings.ApplicationPath + self.settings.Cultura + '/Colleccions/Calendaris/Detall';
				}
			}

			self.TiposColeccionCalendario = ko.lazyObservableArray(GlobalControllers['TipoColeccionCalendarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=TipoColeccionCalendario_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsTipoColeccion = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsTipoColeccion(self.TodosIdsTipoColeccion.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});


			self.CategoriasCalendario = ko.lazyObservableArray(GlobalControllers['CategoriaCalendarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=CategoriaCalendario_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsCategoria = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsCategoria(self.TodosIdsCategoria.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			self.SubcategoriasCalendario = ko.lazyObservableArray(GlobalControllers['SubcategoriaCalendarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=SubcategoriaCalendario_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsSubcategoria = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsSubcategoria(self.TodosIdsSubcategoria.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			self.EstadosCalendario = ko.lazyObservableArray(GlobalControllers['EstadoCalendarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=EstadoCalendario_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsEstado = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsEstado(self.TodosIdsEstado.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			self.Entidades = ko.lazyObservableArray(GlobalControllers['EntidadController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Entidad_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsEntidad = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsEntidad(self.TodosIdsEntidad.slice()); self.Filtro().IdsEntidadContratante(self.TodosIdsEntidad.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			self.Fabricantes = ko.lazyObservableArray(GlobalControllers['FabricanteController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Fabricante_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' +
				'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RegistrosObtenidos: function (observable, registros) { self.TodosIdsFabricante = registros.map(function (registro) { return registro.Id; }); self.Filtro().IdsFabricante(self.TodosIdsFabricante.slice()); return registros; },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			self.Usuarios = ko.lazyObservableArray(GlobalControllers['UsuarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Usuario_ObtenerComboPorIdMarca' +
				'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
