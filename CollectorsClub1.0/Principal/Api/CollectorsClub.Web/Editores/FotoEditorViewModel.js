define(['Globales/BaseViewModelEditor', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'WebAPI/Controllers/FotoController', 'WebAPI/Models/FotoModel', 'WebAPI/Controllers/CategoriaFotoController', 'WebAPI/Models/CategoriaFotoModel', 'WebAPI/Controllers/MarcaController', 'WebAPI/Models/MarcaModel', 'WebAPI/Models/DocumentoUsuariosModel', 'Globales/Core.Utils', 'Globales/popup', 'moment/moment-with-locales.min'], function (baseViewModel, ko, validation, observableDictionary, FotoController, FotoModel, CategoriaFotoController, CategoriaFotoModel, MarcaController, MarcaModel, DocumentoUsuariosModel, utils, popup, moment) {
	try {
		return function FotoEditorViewModel(settings) {
			var self = this;
			self.settings = $.extend({ Multiidioma: true }, settings);
			// #region Propiedades y métodos que difieren por entidad
			self.Entidad = 'Foto';
			self.CamposVisiblesInsercion = { Id: true, Orden: true, IdCategoria: true, Activa: true, Nombre: true, Descripcion: true, NombreArchivoImagen: true, FechaAlta: true, FechaUltimaModificacion: true };
			self.CamposVisiblesEdicion = { Id: true, Orden: true, IdCategoria: true, Activa: true, Nombre: true, Descripcion: true, NombreArchivoImagen: true, FechaAlta: true, FechaUltimaModificacion: true };
			self.CamposHabilitadosInsercion = { Id: false, Orden: true, IdCategoria: true, Activa: true, Nombre: true, Descripcion: true, NombreArchivoImagen: true, FechaAlta: false, FechaUltimaModificacion: false };
			self.CamposHabilitadosEdicion = { Id: false, Orden: true, IdCategoria: true, Activa: true, Nombre: true, Descripcion: true, NombreArchivoImagen: true, FechaAlta: false, FechaUltimaModificacion: false };
			self.CamposHabilitadosFiltro = { Id: true, Orden: true, IdCategoria: true, Activa: true, Nombre: true, Descripcion: true, NombreArchivoImagen: true, FechaAlta: true, FechaUltimaModificacion: true, Cultura: true, IdMarca: true };
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
			self.EntidadesRelacionadas = ['CategoriaFoto', 'Marca'];
			self.FiltroPorDefecto = {
				IdDesde: ko.observable(),
				IdHasta: ko.observable(),
				OrdenDesde: ko.observable(),
				OrdenHasta: ko.observable(),
				IdCategoria: ko.observable(),
				Activa: ko.observable(null),
				Nombre: ko.observable(),
				Descripcion: ko.observable(),
				NombreArchivoImagen: ko.observable(),
				FechaAltaDesde: ko.observable(),
				FechaAltaHasta: ko.observable(),
				FechaUltimaModificacionDesde: ko.observable(),
				FechaUltimaModificacionHasta: ko.observable(),
				Cultura: ko.observable(self.settings.Cultura),
				IdMarca: ko.observable(self.settings.IdMarca),
			};
			self.Filtro = ko.observable(self.FiltroPorDefecto);
			self.TieneExtensionObtenerLista = false;
			self.MetodoObtenerPorFiltros = 'Foto_ObtenerPorFiltrosExtension';
			self.MetodoObtenerCantidadPorFiltros = 'Foto_ObtenerCantidadPorFiltros';
			self.MetodoExtensionNew = 'PostExtension';
			self.MetodoExtensionUpdate = 'PutExtension';
			self.MetodoExtensionDelete = 'DeleteExtension';

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
			// #endregion Propiedades y métodos que difieren por entidad

			// #region Métodos comúnes a todas las entidades
			self.FormatearFecha = utils.FormatearFecha;
			self.MostrarFiltroFijado = function (fijar) { baseViewModel.MostrarFiltroFijado(fijar, self.settings.IdModulo); };
			self.Select = function (registro) { baseViewModel.Select(self, registro); };
			self.New = function () { baseViewModel.New(self, FotoModel); };
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
			self.Inicializar = function (settings) { baseViewModel.Inicializar(self, settings, FotoModel); };
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
			self.MostrarDialogoCopia = function (viewModel) { baseViewModel.MostrarDialogoCopia(viewModel, FotoModel); };
			self.CopiarSeleccionados = function (registroCopia) { baseViewModel.CopiarSeleccionados(self, registroCopia); };
			self.CancelarEdicionMultiple = function () { baseViewModel.CancelarEdicionMultiple(self); };
			self.Editar = function (registro, pedirConfirmacion, registroEdicionMultiple) { baseViewModel.Editar(self, registro, pedirConfirmacion, registroEdicionMultiple); };
			self.MostrarDialogoEdicionMultiple = function (viewModel) { baseViewModel.MostrarDialogoEdicionMultiple(viewModel, FotoModel); };
			self.EditarSeleccionados = function (registroEdicionMultiple) { baseViewModel.EditarSeleccionados(self, registroEdicionMultiple); };
			self.ActualizarCampoBooleano = function (propiedad, indice, tipo, registro, evento) { return baseViewModel.ActualizarCampoBooleano(self, registro, propiedad, indice, tipo); };
			// #endregion Métodos comúnes a todas las entidades

			// #region Definición relaciones
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers['FotoController']) == 'undefined') { GlobalControllers['FotoController'] = new FotoController(settings); }
			// OLL: Este código no debería estar aquí, pero por ahora no funcionan bien los DescargarScripts
			$.each(self.EntidadesRelacionadas, function (indice, entidad) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') { eval('GlobalControllers[entidad + \'Controller\'] = new ' + entidad + 'Controller(settings);'); }
			});

			self.CategoriasFotos = ko.lazyObservableArray(GlobalControllers['CategoriaFotoController'].GetQuery, self, {
				Todos: true,
				Parameters: 'query=CategoriaFoto_ObtenerComboPorIdMarcaExtension' +
										'&parameter=IdMarca|char|' + self.settings.IdMarca + '|3' + 
										'&parameter=Cultura|varchar|' + self.settings.Cultura + '|5',
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
			self.BorradoLogicoDeArchivosNombreArchivoImagen = (typeof (self.settings.BorradoLogicoDeArchivos) !== 'undefined' ? self.settings.BorradoLogicoDeArchivos : false);
			self.NumeroMaximoArchivosACargarNombreArchivoImagen = 1;
			
			self.CargaFinalizadaNombreArchivoImagen = function (archivos) {
				// TODO: Utilizar la propiedad de self Registro en lugar de un observable aparte.
				self.Registro().NombreArchivoImagen((self.DocumentosUsuarioNombreArchivoImagen().length > 0 ? ko.unwrap(self.DocumentosUsuarioNombreArchivoImagen()[0].RutaArchivo) : null));
				_numeroPropiedadesCargadas++;
				if (_numeroPropiedadesCargadas == _numeroPropiedadesACargar) { baseViewModel.Update(self, self.Registro); }
			}

			self.DocumentosUsuarioNombreArchivoImagen = ko.observableArray([]);
			self.SincronizandoNombreArchivoImagen = false;
			self.ArchivosNombreArchivoImagen = ko.observableArray([]);
			self.DocumentosUsuarioNombreArchivoImagen.subscribe(function (documentos) {
				if (!self.SincronizandoNombreArchivoImagen) {
					self.SincronizandoNombreArchivoImagen = true;
					self.ArchivosNombreArchivoImagen(documentos.map(function (documento) { return { Ruta: self.UrlArchivosNombreArchivoImagen() + '/' + ko.unwrap(documento.RutaArchivo), Doctype: ko.unwrap(documento.Doctype) }; }));
					self.SincronizandoNombreArchivoImagen = false;
				}
			}, self);

			self.ArchivosNombreArchivoImagen.subscribe(function (archivos) {
				if (!self.SincronizandoNombreArchivoImagen) {
					self.SincronizandoNombreArchivoImagen = true;
					var _documentosActuales = self.DocumentosUsuarioNombreArchivoImagen();
					var _documentosABorrar = new Array();

					$.each(_documentosActuales, function (indice, documento) {
						if (archivos.filter(function (archivo) { return self.UrlArchivosNombreArchivoImagen() + '/' + ko.unwrap(documento.RutaArchivo) == archivo.Ruta; }).length == 0) {
							if (self.BorradoLogicoDeArchivosNombreArchivoImagen) {
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
						if (_documentosActuales.filter(function (documento) { return self.UrlArchivosNombreArchivoImagen() + '/' + ko.unwrap(documento.RutaArchivo) == archivo.Ruta; }).length == 0) {
							//TODO: OLL: Falta pedir y añadir el tipo correctamente.
							var _partesRuta = archivo.Ruta.split('/');
							_documentosActuales.push(new DocumentoUsuariosModel({ Id: --self.IdDocumentoUsuarioModelNuevo, Nombre: _partesRuta[_partesRuta.length - 1], RutaArchivo: archivo.Ruta.replace(self.UrlArchivosNombreArchivoImagen() + '/', ''), Doctype: archivo.Doctype, IdMarca: self.settings.IdMarca, IdTipo: 1, UsuarioAlta: (typeof (settings.Usuario) !== 'undefined' ? settings.Usuario : 'usuario_anonimo') }));
						}
					});
					for (var i = 0; i < _documentosABorrar.length; i++) {
						_documentosActuales = _documentosActuales.filter(function (registro) { return registro.Id !== _documentosActuales[_documentosABorrar[i]].Id; });
					}
					self.DocumentosUsuarioNombreArchivoImagen(_documentosActuales);
					self.SincronizandoNombreArchivoImagen = false;
				}
			}, self);

			// TODO: OLL: Mirar de obtener antes del update los archivos e incluirlos en el registro para que así se envíen directamente.
			self.Update = function (registro) {
				//utils.Cargando.Mostrar(settings.IdPartial + 'ContenedorCargandoFormulario');
				_numeroPropiedadesCargadas = 0;
				var _vmDocumentosNombreArchivoImagen = ko.dataFor($('#' + self.settings.IdPartial + 'GestorArchivosNombreArchivoImagenContenedorInterno')[0].children[0]);
				// TODO: OLL: Path en trozos
				var _vm = ko.validatedObservable(registro);
				if (_vm.isValid() || (!_vm.isValid() && _vm.errors().length == 1 && _vm.errors()[0].indexOf('Imagen') >= 0)) {
					_vmDocumentosNombreArchivoImagen.Cargar(self.UrlArchivosNombreArchivoImagen());
				} else {
					utils.MostrarMensaje('#' + self.settings.ErrorContainer, settings.System.settings.MensajeErrorValidacion + "<br/>" + _vm.errors(), 'Error');
					//utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			};

			var LimpiarArchivos = function() {
				self.DocumentosUsuarioNombreArchivoImagen([]);
			}

			self.InicioSelect = function (registro) { LimpiarArchivos(); }
			self.InicioNew = function (modelo, datosPorDefecto) { LimpiarArchivos(); }
			self.IdDocumentoUsuarioModelNuevo = 0

			self.RegistroCargado = function (observable) {
				// OLL: Crear método en utils que a partir de la extension devuelva el Doctype. Revisar IdTipo.
				var _documentos = [];
				if (observable().NombreArchivoImagen() != null && observable().NombreArchivoImagen() != '') {
					_documentos = [{ Id: --self.IdDocumentoUsuarioModelNuevo, Nombre: observable().NombreArchivoImagen(), RutaArchivo: observable().NombreArchivoImagen(), Doctype: 'image/jpeg', IdMARCA: self.settings.IdMarca, IdTipo: 1, UsuarioAlta: (typeof (settings.Usuario) !== 'undefined' ? self.settings.Usuario : 'usuario_anonimo') }];
				}
				self.DocumentosUsuarioNombreArchivoImagen(_documentos);
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
			
			baseViewModel.InicializarViewModel(self, settings, FotoModel);

			// #region Propiedades de gestión de archivos
			self.UrlArchivosNombreArchivoImagen = ko.computed(function () {
				return (self.Registro() != null ? self.settings.ApplicationPath + 'Portals/0/_extension/' + ko.unwrap(self.Registro().IdEdicion) + '/Imagenes/Fotos' : '');
			});

			self.UrlArchivosNuevosNombreArchivoImagen = ko.computed(function () {
				return self.UrlArchivosNombreArchivoImagen();
			});
			// #endregion Propiedades de gestión de archivos
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
