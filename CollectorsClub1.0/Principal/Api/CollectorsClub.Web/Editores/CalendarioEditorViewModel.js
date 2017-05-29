define(['Globales/BaseViewModelEditor', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'WebAPI/Controllers/CalendarioController', 'WebAPI/Models/CalendarioModel', 'WebAPI/Controllers/TipoColeccionCalendarioController', 'WebAPI/Models/TipoColeccionCalendarioModel', 'WebAPI/Controllers/CategoriaCalendarioController', 'WebAPI/Models/CategoriaCalendarioModel', 'WebAPI/Controllers/SubcategoriaCalendarioController', 'WebAPI/Models/SubcategoriaCalendarioModel', 'WebAPI/Controllers/EstadoCalendarioController', 'WebAPI/Models/EstadoCalendarioModel', 'WebAPI/Controllers/EntidadController', 'WebAPI/Models/EntidadModel', 'WebAPI/Controllers/FabricanteController', 'WebAPI/Models/FabricanteModel', 'WebAPI/Controllers/UsuarioController', 'WebAPI/Models/UsuarioModel', 'WebAPI/Controllers/MarcaController', 'WebAPI/Models/MarcaModel', 'WebAPI/Models/DocumentoUsuariosModel', 'Globales/Core.Utils', 'Globales/popup', 'moment/moment-with-locales.min'], function (baseViewModel, ko, validation, observableDictionary, CalendarioController, CalendarioModel, TipoColeccionCalendarioController, TipoColeccionCalendarioModel, CategoriaCalendarioController, CategoriaCalendarioModel, SubcategoriaCalendarioController, SubcategoriaCalendarioModel, EstadoCalendarioController, EstadoCalendarioModel, EntidadController, EntidadModel, FabricanteController, FabricanteModel, UsuarioController, UsuarioModel, MarcaController, MarcaModel, DocumentoUsuariosModel, utils, popup, moment) {
	try {
		return function CalendarioEditorViewModel(settings) {
			var self = this;
			self.settings = $.extend({ Multiidioma: true }, settings);
			// #region Propiedades y métodos que difieren por entidad
			self.Entidad = 'Calendario';
			self.CamposVisiblesInsercion = { Id: true, IdTipoColeccion: true, Visible: true, IdCategoria: true, IdSubcategoria: true, Imagen: true, Nombre: true, IdEstado: true, Anyo: true, IdEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdEntidadContratante: true, DL: true, Variante: true, IdFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true };
			self.CamposVisiblesEdicion = { Id: true, IdTipoColeccion: true, Visible: true, IdCategoria: true, IdSubcategoria: true, Imagen: true, Nombre: true, IdEstado: true, Anyo: true, IdEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdEntidadContratante: true, DL: true, Variante: true, IdFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true };
			self.CamposHabilitadosInsercion = { Id: false, IdTipoColeccion: true, Visible: true, IdCategoria: true, IdSubcategoria: true, Imagen: true, Nombre: true, IdEstado: true, Anyo: true, IdEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdEntidadContratante: true, DL: true, Variante: true, IdFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true };
			self.CamposHabilitadosEdicion = { Id: false, IdTipoColeccion: true, Visible: true, IdCategoria: true, IdSubcategoria: true, Imagen: true, Nombre: true, IdEstado: true, Anyo: true, IdEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdEntidadContratante: true, DL: true, Variante: true, IdFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true };
			self.CamposHabilitadosFiltro = { Id: true, IdTipoColeccion: true, Visible: true, IdCategoria: true, IdSubcategoria: true, Imagen: true, Nombre: true, IdEstado: true, Anyo: true, IdEntidad: true, Serie: true, NumeroRepetidos: true, NumeroSerie: true, IdEntidadContratante: true, DL: true, Variante: true, IdFabricante: true, PaginaWeb: true, Codigo: true, IdUsuario: true, Cultura: false, IdMarca: true };
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
			self.EntidadesRelacionadas = ['TipoColeccionCalendario', 'CategoriaCalendario', 'SubcategoriaCalendario', 'EstadoCalendario', 'Entidad', 'Fabricante', 'Usuario', 'Marca'];
			self.FiltroPorDefecto = {
				IdDesde: ko.observable(),
				IdHasta: ko.observable(),
				IdTipoColeccion: ko.observable(),
				Visible: ko.observable(null),
				IdCategoria: ko.observable(),
				IdSubcategoria: ko.observable(),
				Imagen: ko.observable(),
				Nombre: ko.observable(),
				IdEstado: ko.observable(),
				Anyo: ko.observable(),
				IdEntidad: ko.observable(),
				Serie: ko.observable(),
				NumeroRepetidosDesde: ko.observable(),
				NumeroRepetidosHasta: ko.observable(),
				NumeroSerie: ko.observable(),
				IdEntidadContratante: ko.observable(),
				DL: ko.observable(),
				Variante: ko.observable(),
				IdFabricante: ko.observable(),
				PaginaWeb: ko.observable(),
				Codigo: ko.observable(),
				IdUsuario: ko.observable(),
				Cultura: ko.observable(self.settings.Cultura),
				IdMarca: ko.observable(self.settings.IdMarca),
			};
			self.Filtro = ko.observable(self.FiltroPorDefecto);
			self.TieneExtensionObtenerLista = false;
			self.MetodoObtenerPorFiltros = 'Calendario_ObtenerPorFiltros';
			self.MetodoObtenerCantidadPorFiltros = 'Calendario_ObtenerCantidadPorFiltros';

			self.ObtenerFiltros = function (filtro) {
				return '&parameter=IdDesde|int|' + (typeof (filtro.IdDesde) !== 'undefined' && filtro.IdDesde !== null ? filtro.IdDesde : '') +
					'&parameter=IdHasta|int|' + (typeof (filtro.IdHasta) !== 'undefined' && filtro.IdHasta !== null ? filtro.IdHasta : '') +
					'&parameter=IdTipoColeccion|smallint|' + (typeof (filtro.IdTipoColeccion) !== 'undefined' && filtro.IdTipoColeccion !== null ? filtro.IdTipoColeccion : '') +
					'&parameter=Visible|bit|' + (typeof (filtro.Visible) !== 'undefined' && filtro.Visible !== null ? filtro.Visible : '') +
					'&parameter=IdCategoria|smallint|' + (typeof (filtro.IdCategoria) !== 'undefined' && filtro.IdCategoria !== null ? filtro.IdCategoria : '') +
					'&parameter=IdSubcategoria|smallint|' + (typeof (filtro.IdSubcategoria) !== 'undefined' && filtro.IdSubcategoria !== null ? filtro.IdSubcategoria : '') +
					'&parameter=Imagen|nvarchar|' + (typeof (filtro.Imagen) !== 'undefined' && filtro.Imagen !== null ? filtro.Imagen : '') + '|250' +
					'&parameter=Nombre|nvarchar|' + (typeof (filtro.Nombre) !== 'undefined' && filtro.Nombre !== null ? filtro.Nombre : '') + '|50' +
					'&parameter=IdEstado|smallint|' + (typeof (filtro.IdEstado) !== 'undefined' && filtro.IdEstado !== null ? filtro.IdEstado : '') +
					'&parameter=Anyo|varchar|' + (typeof (filtro.Anyo) !== 'undefined' && filtro.Anyo !== null ? filtro.Anyo : '') + '|50' +
					'&parameter=IdEntidad|int|' + (typeof (filtro.IdEntidad) !== 'undefined' && filtro.IdEntidad !== null ? filtro.IdEntidad : '') +
					'&parameter=Serie|nvarchar|' + (typeof (filtro.Serie) !== 'undefined' && filtro.Serie !== null ? filtro.Serie : '') + '|50' +
					'&parameter=NumeroRepetidosDesde|smallint|' + (typeof (filtro.NumeroRepetidosDesde) !== 'undefined' && filtro.NumeroRepetidosDesde !== null ? filtro.NumeroRepetidosDesde : '') +
					'&parameter=NumeroRepetidosHasta|smallint|' + (typeof (filtro.NumeroRepetidosHasta) !== 'undefined' && filtro.NumeroRepetidosHasta !== null ? filtro.NumeroRepetidosHasta : '') +
					'&parameter=NumeroSerie|nvarchar|' + (typeof (filtro.NumeroSerie) !== 'undefined' && filtro.NumeroSerie !== null ? filtro.NumeroSerie : '') + '|50' +
					'&parameter=IdEntidadContratante|int|' + (typeof (filtro.IdEntidadContratante) !== 'undefined' && filtro.IdEntidadContratante !== null ? filtro.IdEntidadContratante : '') +
					'&parameter=DL|nvarchar|' + (typeof (filtro.DL) !== 'undefined' && filtro.DL !== null ? filtro.DL : '') + '|50' +
					'&parameter=Variante|nvarchar|' + (typeof (filtro.Variante) !== 'undefined' && filtro.Variante !== null ? filtro.Variante : '') + '|50' +
					'&parameter=IdFabricante|int|' + (typeof (filtro.IdFabricante) !== 'undefined' && filtro.IdFabricante !== null ? filtro.IdFabricante : '') +
					'&parameter=PaginaWeb|nvarchar|' + (typeof (filtro.PaginaWeb) !== 'undefined' && filtro.PaginaWeb !== null ? filtro.PaginaWeb : '') + '|100' +
					'&parameter=Codigo|varchar|' + (typeof (filtro.Codigo) !== 'undefined' && filtro.Codigo !== null ? filtro.Codigo : '') + '|50' +
					'&parameter=IdUsuario|int|' + (typeof (filtro.IdUsuario) !== 'undefined' && filtro.IdUsuario !== null ? filtro.IdUsuario : '') +
					'&parameter=Cultura|varchar|' + (typeof (filtro.Cultura) !== 'undefined' && filtro.Cultura !== null ? filtro.Cultura : '') + '|5' +
					'&parameter=IdMarca|char|' + (typeof (filtro.IdMarca) !== 'undefined' && filtro.IdMarca !== null ? filtro.IdMarca : '');
			}
			// #endregion Propiedades y métodos que difieren por entidad

			// #region Métodos comúnes a todas las entidades
			self.FormatearFecha = utils.FormatearFecha;
			self.MostrarFiltroFijado = function (fijar) { baseViewModel.MostrarFiltroFijado(fijar, self.settings.IdModulo); };
			self.Select = function (registro) { baseViewModel.Select(self, registro); };
			self.New = function () { baseViewModel.New(self, CalendarioModel); };
			self.Cancel = function () { baseViewModel.Cancel(self); };
			self.Count = function () { baseViewModel.Count(self); };
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
			self.Inicializar = function (settings) { baseViewModel.Inicializar(self, settings, CalendarioModel); };
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
			self.MostrarDialogoCopia = function (viewModel) { baseViewModel.MostrarDialogoCopia(viewModel, CalendarioModel); };
			self.CopiarSeleccionados = function (registroCopia) { baseViewModel.CopiarSeleccionados(self, registroCopia); };
			self.CancelarEdicionMultiple = function () { baseViewModel.CancelarEdicionMultiple(self); };
			self.Editar = function (registro, pedirConfirmacion, registroEdicionMultiple) { baseViewModel.Editar(self, registro, pedirConfirmacion, registroEdicionMultiple); };
			self.MostrarDialogoEdicionMultiple = function (viewModel) { baseViewModel.MostrarDialogoEdicionMultiple(viewModel, CalendarioModel); };
			self.EditarSeleccionados = function (registroEdicionMultiple) { baseViewModel.EditarSeleccionados(self, registroEdicionMultiple); };
			self.ActualizarCampoBooleano = function (propiedad, indice, tipo, registro, evento) { return baseViewModel.ActualizarCampoBooleano(self, registro, propiedad, indice, tipo); };
			// #endregion Métodos comúnes a todas las entidades

			// #region Definición relaciones
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['CalendarioController']) == 'undefined') { GlobalControllers['CalendarioController'] = new CalendarioController(settings); }
			// OLL: Este código no debería estar aquí, pero por ahora no funcionan bien los DescargarScripts
			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			self.TiposColeccionCalendario = ko.lazyObservableArray(GlobalControllers['TipoColeccionCalendarioController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=TipoColeccionCalendario_ObtenerComboPorIdMarca' +
										'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' + 
										'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
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

			self.Marcas = ko.lazyObservableArray(GlobalControllers['MarcaController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=Marca_ObtenerCombo', 
				PrellamadaApi: function () { self.Cargando(true); },
				PostllamadaApi: function () { self.Cargando(false); },
				MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				RespuestaPeticionCorrecta: function (observable) { },
			});

			// #endregion Definición relaciones

			// #region Propiedades de gestión de archivos
			var _numeroPropiedadesACargar = 1;
			var _numeroPropiedadesCargadas = 0;
			self.BorradoLogicoDeArchivosImagen = (typeof (self.settings.BorradoLogicoDeArchivos) !== 'undefined' ? self.settings.BorradoLogicoDeArchivos : false);
			self.NumeroMaximoArchivosACargarImagen = 1;
			
			self.CargaFinalizadaImagen = function (archivos) {
				// TODO: Utilizar la propiedad de self Registro en lugar de un observable aparte.
				self.Registro().Imagen((self.DocumentosUsuarioImagen().length > 0 ? ko.unwrap(self.DocumentosUsuarioImagen()[0].RutaArchivo) : null));
				_numeroPropiedadesCargadas++;
				if (_numeroPropiedadesCargadas == _numeroPropiedadesACargar) { baseViewModel.Update(self, self.Registro); }
			}

			self.DocumentosUsuarioImagen = ko.observableArray([]);
			self.SincronizandoImagen = false;
			self.ArchivosImagen = ko.observableArray([]);
			self.DocumentosUsuarioImagen.subscribe(function (documentos) {
				if (!self.SincronizandoImagen) {
					self.SincronizandoImagen = true;
					self.ArchivosImagen(documentos.map(function (documento) { return { Ruta: self.UrlArchivosImagen() + '/' + ko.unwrap(documento.RutaArchivo), Doctype: ko.unwrap(documento.Doctype) }; }));
					self.SincronizandoImagen = false;
				}
			}, self);

			self.ArchivosImagen.subscribe(function (archivos) {
				if (!self.SincronizandoImagen) {
					self.SincronizandoImagen = true;
					var _documentosActuales = self.DocumentosUsuarioImagen();
					var _documentosABorrar = new Array();

					$.each(_documentosActuales, function (indice, documento) {
						if (archivos.filter(function (archivo) { return self.UrlArchivosImagen() + '/' + ko.unwrap(documento.RutaArchivo) == archivo.Ruta; }).length == 0) {
							if (self.BorradoLogicoDeArchivosImagen) {
								var _fechaEliminacion = (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00'));
								if (ko.isObservable(documento.FechaEliminacion)) { documento.FechaEliminacion(_fechaEliminacion); } else { documento.FechaEliminacion = _fechaEliminacion; }
							} else {
								_documentosABorrar.push(indice);
							}
						}
					});
					$.each(archivos, function (indice, archivo) {
						// TODO: OLL: Mirar si es necesario comparar más propiedades para que siempre funcione. Lo ideal sería que archivo tuviese también el Id de documento, así podríamos por Id reconocer mejor si el elemento estaba en 
						// DocumentosUsuario o no
						if (_documentosActuales.filter(function (documento) { return self.UrlArchivosImagen() + '/' + ko.unwrap(documento.RutaArchivo) == archivo.Ruta; }).length == 0) {
							//TODO: OLL: Falta pedir y añadir el tipo correctamente.
							var _partesRuta = archivo.Ruta.split('/');
							_documentosActuales.push(new DocumentoUsuariosModel({ Id: --self.IdDocumentoUsuarioModelNuevo, Nombre: _partesRuta[_partesRuta.length - 1], RutaArchivo: archivo.Ruta.replace(self.UrlArchivosImagen() + '/', ''), Doctype: archivo.Doctype, IdMarca: self.settings.IdMarca, IdTipo: 1, UsuarioAlta: (typeof (settings.Usuario) !== 'undefined' ? settings.Usuario : 'usuario_anonimo') }));
						}
					});
					for (var i = 0; i < _documentosABorrar.length; i++) {
						_documentosActuales = _documentosActuales.filter(function (registro) { return registro.Id !== _documentosActuales[_documentosABorrar[i]].Id; });
					}
					self.DocumentosUsuarioImagen(_documentosActuales);
					self.SincronizandoImagen = false;
				}
			}, self);

			// TODO: OLL: Mirar de obtener antes del update los archivos e incluirlos en el registro para que así se envíen directamente.
			self.Update = function (registro) {
				//utils.Cargando.Mostrar(settings.IdPartial + 'ContenedorCargandoFormulario');
				_numeroPropiedadesCargadas = 0;
				var _vmDocumentosImagen = ko.dataFor($('#' + self.settings.IdPartial + 'GestorArchivosImagenContenedorInterno')[0].children[0]);
				// TODO: OLL: Path en trozos
				var _vm = ko.validatedObservable(registro);
				if (_vm.isValid() || (!_vm.isValid() && _vm.errors().length == 1 && _vm.errors()[0].indexOf('Imagen') >= 0)) {
					_vmDocumentosImagen.Cargar(self.UrlArchivosImagen());
				} else {
					utils.MostrarMensaje('#' + self.settings.ErrorContainer, settings.System.settings.MensajeErrorValidacion + "<br/>" + _vm.errors(), 'Error');
					//utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			};

			var LimpiarArchivos = function() {
				self.DocumentosUsuarioImagen([]);
			}

			self.InicioSelect = function (registro) { LimpiarArchivos(); }
			self.InicioNew = function (modelo, datosPorDefecto) { LimpiarArchivos(); }
			self.IdDocumentoUsuarioModelNuevo = 0

			self.RegistroCargado = function (observable) {
				// OLL: Crear método en utils que a partir de la extension devuelva el Doctype. Revisar IdTipo.
				var _documentos = [];
				if (observable().Imagen() != null && observable().Imagen() != '') {
					_documentos = [{ Id: --self.IdDocumentoUsuarioModelNuevo, Nombre: observable().Imagen(), RutaArchivo: observable().Imagen(), Doctype: 'image/jpeg', IdMARCA: self.settings.IdMarca, IdTipo: 1, UsuarioAlta: (typeof (settings.Usuario) !== 'undefined' ? self.settings.Usuario : 'usuario_anonimo') }];
				}
				self.DocumentosUsuarioImagen(_documentos);
				//GlobalControllers['DocumentoUsuariosController'].GetQuery(self.DocumentosUsuario, {
				//	Todos: true,
				//	Parameters: 'query=DocumentoUsuarios_ObtenerPorIdUsuario' +
				//	'&parameter=IdUsuario|int|' + observable().Id(),
				//	PrellamadaApi: function () { self.Cargando(true); },
				//	PostllamadaApi: function () { self.Cargando(false); },
				//	MostrarMensaje: function (error, tipo) { utils.MostrarMensaje('#' + self.settings.ErrorContainer, error, tipo); },
				//	RespuestaPeticionCorrecta: function (observable) { },
				//	GenerarModeloEntidad: true
				//});
			}
			// #endregion Propiedades de gestión de archivos

			// #region Métodos sobreescritos o añadidos
			// OLL: Revisar esto. Lo hice rápidamente. Mirar si hay una mejor manera de mantener propiedades del filtro
			self.RevisarFiltro = function (viewModel) {
				viewModel.Filtro().Cultura(viewModel.settings.Cultura);
			}
			// #endregion Métodos sobreescritos o añadidos
			
			baseViewModel.InicializarViewModel(self, settings, CalendarioModel);

			// #region Propiedades de gestión de archivos
			self.UrlArchivosImagen = ko.computed(function () {
				return (self.Registro() != null ? self.settings.ApplicationPath + 'Portals/0/_extension/' + ko.unwrap(self.Registro().IdEdicion) + '/Imagenes/Calendarios' : '');
			});

			self.UrlArchivosNuevosImagen = ko.computed(function () {
				return self.UrlArchivosImagen();
			});
			// #endregion Propiedades de gestión de archivos
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
