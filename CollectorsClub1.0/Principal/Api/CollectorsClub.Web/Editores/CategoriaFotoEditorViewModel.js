define(['Globales/BaseViewModelEditor', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'WebAPI/Controllers/CategoriaFotoController', 'WebAPI/Models/CategoriaFotoModel', 'WebAPI/Controllers/MarcaController', 'WebAPI/Models/MarcaModel', 'Globales/Core.Utils', 'Globales/popup', 'moment/moment-with-locales.min'], function (baseViewModel, ko, validation, observableDictionary, CategoriaFotoController, CategoriaFotoModel, MarcaController, MarcaModel, utils, popup, moment) {
	try {
		return function CategoriaFotoEditorViewModel(settings) {
			var self = this;
			self.settings = $.extend({ Multiidioma: true }, settings);
			// #region Propiedades y métodos que difieren por entidad
			self.Entidad = 'CategoriaFoto';
			self.CamposVisiblesInsercion = { Id: true, Orden: true, Activa: true, Nombre: true, FechaAlta: true, FechaUltimaModificacion: true };
			self.CamposVisiblesEdicion = { Id: true, Orden: true, Activa: true, Nombre: true, FechaAlta: true, FechaUltimaModificacion: true };
			self.CamposHabilitadosInsercion = { Id: false, Orden: true, Activa: true, Nombre: true, FechaAlta: false, FechaUltimaModificacion: false };
			self.CamposHabilitadosEdicion = { Id: false, Orden: true, Activa: true, Nombre: true, FechaAlta: false, FechaUltimaModificacion: false };
			self.CamposHabilitadosFiltro = { Id: true, Orden: true, Activa: true, Nombre: true, FechaAlta: true, FechaUltimaModificacion: true, Cultura: true, IdMarca: true };
			self.VolverAlListadoAlGuardar = false;
			self.SerializarClave = function (registro) { return registro.Id; }
			self.InicializarClave = function (registro) { 
				if (ko.isObservable(registro.Id)) { registro.Id(0); } else { registro.Id = 0; } 
				return registro; 
			}
			self.AsignarClave = function (registroOrigen, registroDestino) {
				if (ko.isObservable(registroDestino.Id)) { registroDestino.Id(ko.unwrap(registroOrigen.Id)); } else { registroDestino.Id = ko.unwrap(registroOrigen.Id); }
				return registroDestino;
			}
			self.EntidadesRelacionadas = ['Marca'];
			self.FiltroPorDefecto = {
				IdDesde: ko.observable(),
				IdHasta: ko.observable(),
				OrdenDesde: ko.observable(),
				OrdenHasta: ko.observable(),
				Activa: ko.observable(null),
				Nombre: ko.observable(),
				FechaAltaDesde: ko.observable(),
				FechaAltaHasta: ko.observable(),
				FechaUltimaModificacionDesde: ko.observable(),
				FechaUltimaModificacionHasta: ko.observable(),
				Cultura: ko.observable(self.settings.Cultura),
				IdMarca: ko.observable(self.settings.IdMarca),
			};
			self.Filtro = ko.observable(self.FiltroPorDefecto);
			self.TieneExtensionObtenerLista = false;
			self.MetodoObtenerPorFiltros = 'CategoriaFoto_ObtenerPorFiltrosExtension';
			self.MetodoObtenerCantidadPorFiltros = 'CategoriaFoto_ObtenerCantidadPorFiltros';
			self.MetodoExtensionUpdate = 'PutExtension';
			self.MetodoExtensionDelete = 'DeleteExtension';

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=OrdenDesde|smallint|' + (typeof (filtro.OrdenDesde) !== 'undefined' && filtro.OrdenDesde !== null ? filtro.OrdenDesde : '') +
					'&parameter=OrdenHasta|smallint|' + (typeof (filtro.OrdenHasta) !== 'undefined' && filtro.OrdenHasta !== null ? filtro.OrdenHasta : '') +
					'&parameter=Activa|bit|' + (typeof (filtro.Activa) !== 'undefined' && filtro.Activa !== null ? filtro.Activa : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|150' +
					'&parameter=FechaAltaDesde|datetime|' + (typeof (filtro.FechaAltaDesde) !== 'undefined' && filtro.FechaAltaDesde !== null ? filtro.FechaAltaDesde : '') +
					'&parameter=FechaAltaHasta|datetime|' + (typeof (filtro.FechaAltaHasta) !== 'undefined' && filtro.FechaAltaHasta !== null ? filtro.FechaAltaHasta : '') +
					'&parameter=FechaUltimaModificacionDesde|datetime|' + (typeof (filtro.FechaUltimaModificacionDesde) !== 'undefined' && filtro.FechaUltimaModificacionDesde !== null ? filtro.FechaUltimaModificacionDesde : '') +
					'&parameter=FechaUltimaModificacionHasta|datetime|' + (typeof (filtro.FechaUltimaModificacionHasta) !== 'undefined' && filtro.FechaUltimaModificacionHasta !== null ? filtro.FechaUltimaModificacionHasta : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '');
			}
			// #endregion Propiedades y métodos que difieren por entidad

			// #region Métodos comúnes a todas las entidades
			self.FormatearFecha = utils.FormatearFecha;
			self.MostrarFiltroFijado = function (fijar) { baseViewModel.MostrarFiltroFijado(fijar, self.settings.IdModulo); };
			self.Select = function (registro) { baseViewModel.Select(self, registro); };
			self.New = function () { baseViewModel.New(self, CategoriaFotoModel); };
			self.Cancel = function () { baseViewModel.Cancel(self); };
			self.Count = function () { baseViewModel.Count(self); };
			self.Update = function (registro) { baseViewModel.Update(self, registro); };
			self.Delete = function (registro, pedirConfirmacion) { baseViewModel.Delete(self, registro, pedirConfirmacion); };
			self.DeleteSelected = function (viewModel) { baseViewModel.DeleteSelected(viewModel); };
			self.FijarRegistro = function (registro, event) { baseViewModel.FijarRegistro(self, registro, event); };
			self.LiberarRegistro = function (registro, event) { baseViewModel.LiberarRegistro(self, registro, event); };
			self.RegistrosObtenidos = function (registros, tipo) { baseViewModel.RegistrosObtenidos(self, registros, tipo); };
			self.Buscar = function (filtro) { baseViewModel.Buscar(self, filtro); };
			self.Refrescar = function (viewModel) { baseViewModel.Refrescar(viewModel); };
			self.VerMas = function (viewModel) { baseViewModel.VerMas(viewModel); };
			self.Get = function (viewModel) { baseViewModel.Get((typeof (viewModel) !== 'undefined' ? viewModel : self)); };
			self.ColumnaVisible = function (nombreColumna) { return baseViewModel.ColumnaVisible(self, nombreColumna); };
			self.ColumnaOculta = function (nombreColumna) { return baseViewModel.ColumnaOculta(self, nombreColumna); };
			//self.PosicionarSelector = function (columna) { return baseViewModel.PosicionarSelector(self, columna); };
			self.ActualizarSeleccion = function (viewModel) { return baseViewModel.ActualizarSeleccion(viewModel); };
			self.Inicializar = function (settings) { baseViewModel.Inicializar(self, settings, CategoriaFotoModel); };
			self.ExportarAExcel = function () { baseViewModel.ExportarAExcel(self); };
			self.RestablecerFiltroPorDefecto = function (filtro) { baseViewModel.RestablecerFiltroPorDefecto(self, filtro); };
			self.Ordenar = function (columna) { baseViewModel.Ordenar(self, columna); };
			self.MostrarOcultarColumnas = function (columna) { baseViewModel.MostrarOcultarColumnas(self); };
			self.MostrarOcultarColumna = function (columna) { baseViewModel.MostrarOcultarColumna(self, columna); };
			self.MostrarBuscador = function (entidad, observable) { baseViewModel.MostrarBuscador(self, entidad, observable); };
			self.ActualizarSeleccionadoEnBuscador = function (id, entidad, observable) { baseViewModel.ActualizarSeleccionadoEnBuscador(self, id, entidad, observable); };
			self.ActivarBloque = function (id) { baseViewModel.ActivarBloque(self, id); };
			self.CancelarCopiar = function () { baseViewModel.CancelarCopiar(self); };
			self.Copiar = function (registro, pedirConfirmacion, registroCopia) { baseViewModel.Copiar(self, registro, pedirConfirmacion, registroCopia); };
			self.MostrarDialogoCopia = function (viewModel) { baseViewModel.MostrarDialogoCopia(viewModel, CategoriaFotoModel); };
			self.CopiarSeleccionados = function (registroCopia) { baseViewModel.CopiarSeleccionados(self, registroCopia); };
			self.CancelarEdicionMultiple = function () { baseViewModel.CancelarEdicionMultiple(self); };
			self.Editar = function (registro, pedirConfirmacion, registroEdicionMultiple) { baseViewModel.Editar(self, registro, pedirConfirmacion, registroEdicionMultiple); };
			self.MostrarDialogoEdicionMultiple = function (viewModel) { baseViewModel.MostrarDialogoEdicionMultiple(viewModel, CategoriaFotoModel); };
			self.EditarSeleccionados = function (registroEdicionMultiple) { baseViewModel.EditarSeleccionados(self, registroEdicionMultiple); };
			self.ActualizarCampoBooleano = function (propiedad, indice, tipo, registro, evento) { return baseViewModel.ActualizarCampoBooleano(self, registro, propiedad, indice, tipo); };
			// #endregion Métodos comúnes a todas las entidades

			// #region Definición relaciones
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['CategoriaFotoController']) == 'undefined') { GlobalControllers['CategoriaFotoController'] = new CategoriaFotoController(settings); }
			// OLL: Este código no debería estar aquí, pero por ahora no funcionan bien los DescargarScripts
			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			self.Marcas = ko.lazyObservableArray(GlobalControllers['MarcaController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Marca_ObtenerCombo', 
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			// #endregion Definición relaciones

			// #region Métodos sobreescritos o añadidos
			// OLL: Revisar esto. Lo hice rápidamente. Mirar si hay una mejor manera de mantener propiedades del filtro
			self.RevisarFiltro = function (viewModel) {
				viewModel.Filtro().Cultura(viewModel.settings.Cultura);
			}
			// #endregion Métodos sobreescritos o añadidos
			
			baseViewModel.InicializarViewModel(self, settings, CategoriaFotoModel);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
