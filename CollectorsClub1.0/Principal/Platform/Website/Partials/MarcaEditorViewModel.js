define(['Globales/BaseViewModelEditor', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'WebAPI/Controllers/MarcaController', 'WebAPI/Models/MarcaModel', 'Globales/Core.Utils', 'Globales/popup', 'moment/moment-with-locales.min'], function (baseViewModel, ko, validation, observableDictionary, MarcaController, MarcaModel, utils, popup, moment) {
	try {
		return function MarcaEditorViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			// #region Propiedades y métodos que difieren por entidad
			self.Entidad = 'Marca';
			self.CamposVisiblesInsercion = { Id: true, Nombre: true };
			self.CamposVisiblesEdicion = { Id: true, Nombre: true };
			self.CamposHabilitadosInsercion = { Id: false, Nombre: true };
			self.CamposHabilitadosEdicion = { Id: false, Nombre: true };
			self.CamposHabilitadosFiltro = { Id: true, Nombre: true };
			self.VolverAlListadoAlGuardar = false;
			self.SerializarClave = function (registro) { return registro.Id; }
			self.InicializarClave = function (registro) { 
				if (ko.isObservable(registro.Id)) { registro.Id(''); } else { registro.Id = ''; } 
				return registro; 
			}
			self.AsignarClave = function (registroOrigen, registroDestino) {
				if (ko.isObservable(registroDestino.Id)) { registroDestino.Id(ko.unwrap(registroOrigen.Id)); } else { registroDestino.Id = ko.unwrap(registroOrigen.Id); }
				return registroDestino;
			}
			self.EntidadesRelacionadas = [];
			self.FiltroPorDefecto = {
				Id: ko.observable(),
				Nombre: ko.observable(),
			};
			self.Filtro = ko.observable(self.FiltroPorDefecto);
			self.TieneExtensionObtenerLista = false;
			self.MetodoObtenerPorFiltros = 'Marca_ObtenerPorFiltros';
			self.MetodoObtenerCantidadPorFiltros = 'Marca_ObtenerCantidadPorFiltros';

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=Id|char|' + (typeof (filtro.Id) !== 'undefined' && filtro.Id !== null ? filtro.Id : '') +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|50';
			}
			// #endregion Propiedades y métodos que difieren por entidad

			// #region Métodos comúnes a todas las entidades
			self.FormatearFecha = utils.FormatearFecha;
			self.MostrarFiltroFijado = function (fijar) { baseViewModel.MostrarFiltroFijado(fijar, self.settings.IdModulo); };
			self.Select = function (registro) { baseViewModel.Select(self, registro); };
			self.New = function () { baseViewModel.New(self, MarcaModel); };
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
			self.Inicializar = function (settings) { baseViewModel.Inicializar(self, settings, MarcaModel); };
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
			self.MostrarDialogoCopia = function (viewModel) { baseViewModel.MostrarDialogoCopia(viewModel, MarcaModel); };
			self.CopiarSeleccionados = function (registroCopia) { baseViewModel.CopiarSeleccionados(self, registroCopia); };
			self.CancelarEdicionMultiple = function () { baseViewModel.CancelarEdicionMultiple(self); };
			self.Editar = function (registro, pedirConfirmacion, registroEdicionMultiple) { baseViewModel.Editar(self, registro, pedirConfirmacion, registroEdicionMultiple); };
			self.MostrarDialogoEdicionMultiple = function (viewModel) { baseViewModel.MostrarDialogoEdicionMultiple(viewModel, MarcaModel); };
			self.EditarSeleccionados = function (registroEdicionMultiple) { baseViewModel.EditarSeleccionados(self, registroEdicionMultiple); };
			// #endregion Métodos comúnes a todas las entidades

			// #region Definición relaciones
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['MarcaController']) == 'undefined') { GlobalControllers['MarcaController'] = new MarcaController(settings); }
			// OLL: Este código no debería estar aquí, pero por ahora no funcionan bien los DescargarScripts
			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			// #endregion Definición relaciones

			// #region Métodos sobreescritos o añadidos
			// #endregion Métodos sobreescritos o añadidos
			
			baseViewModel.InicializarViewModel(self, settings, MarcaModel);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
