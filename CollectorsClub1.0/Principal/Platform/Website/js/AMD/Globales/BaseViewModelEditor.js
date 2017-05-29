define(['jquery', 'dojo/order!knockout', './Core.Utils', 'Globales/popup'], function ($, ko, utils, popup) {
	try {
		function BaseViewModel() {
			var self = this;

			self.InicializarViewModel = function (viewModel, settings, modelo) {
				viewModel.settings.PermitirCrear = (typeof (viewModel.settings.PermitirCrear) !== 'undefined' ? viewModel.settings.PermitirCrear : true);
				viewModel.settings.PermitirGuardar = (typeof (viewModel.settings.PermitirGuardar) !== 'undefined' ? viewModel.settings.PermitirGuardar : true);
				viewModel.settings.PermitirBorrar = (typeof (viewModel.settings.PermitirBorrar) !== 'undefined' ? viewModel.settings.PermitirBorrar : true);
				viewModel.settings.PermitirCopiar = (typeof (viewModel.settings.PermitirCopiar) !== 'undefined' ? viewModel.settings.PermitirCopiar : true);
				viewModel.settings.PermitirEdicionMultiple = (typeof (viewModel.settings.PermitirEdicionMultiple) !== 'undefined' ? viewModel.settings.PermitirEdicionMultiple : true);
				viewModel.settings.PermitirExportarAExcel = (typeof (viewModel.settings.PermitirExportarAExcel) !== 'undefined' ? viewModel.settings.PermitirExportarAExcel : true);
				viewModel.settings.PermitirExportarAPdf = (typeof (viewModel.settings.PermitirExportarAPdf) !== 'undefined' ? viewModel.settings.PermitirExportarAPdf : true);
				viewModel.settings.InteraccionExterna = (typeof (viewModel.settings.InteraccionExterna) !== 'undefined' ? viewModel.settings.InteraccionExterna : false);
				viewModel.settings.ModuloPrincipal = (typeof (viewModel.settings.ModuloPrincipal) !== 'undefined' ? viewModel.settings.ModuloPrincipal : false);
				viewModel.settings.Modo = (typeof (viewModel.settings.Modo) !== 'undefined' ? viewModel.settings.Modo : ModoInicioModulo.Listado);
				viewModel.settings.MostrarMensaje = (typeof (viewModel.settings.MostrarMensaje) !== 'undefined' ? viewModel.settings.MostrarMensaje : viewModel.settings.MostrarMensaje);
				viewModel.TraduccionCampos = ko.observableDictionary([]);
				viewModel.MetodosRespuesta = new Array();
				viewModel.PestanyaVisible = ko.observable('listado');
				viewModel.FiltroFijado = ko.observable();
				viewModel.Cargando = ko.observable(false);

				//if (viewModel.settings.Modo != ModoInicioModulo.Listado) {
				InicializarViewModelListado(viewModel, settings, modelo);
				//}

				InicializarViewModelEdicion(viewModel, settings, modelo);

				viewModel.Inicializar(settings);
				//viewModel.EntidadesRelacionadas.forEach(function (entidad) { RegistrarController(entidad + 'Controller', settings); });
			};

			var InicializarViewModelListado = function (viewModel, settings, modelo) {
				viewModel.settings.BusquedaAutomatica = (typeof (viewModel.settings.BusquedaAutomatica) !== 'undefined' ? viewModel.settings.BusquedaAutomatica : true);
				viewModel.settings.VolverAListadoAlInsertar = (typeof (viewModel.settings.VolverAListadoAlInsertar) !== 'undefined' ? viewModel.settings.VolverAListadoAlInsertar : true);
				viewModel.settings.VolverAListadoAlActualizar = (typeof (viewModel.settings.VolverAListadoAlActualizar) !== 'undefined' ? viewModel.settings.VolverAListadoAlActualizar : true);
				viewModel.settings.TamanyoPagina = (typeof (viewModel.settings.TamanyoPagina) !== 'undefined' ? viewModel.settings.TamanyoPagina : 0);
				viewModel.settings.ColumnaOrden = (typeof (viewModel.settings.ColumnaOrden) !== 'undefined' ? viewModel.settings.ColumnaOrden : '');
				viewModel.settings.TipoOrden = (typeof (viewModel.settings.TipoOrden) !== 'undefined' ? viewModel.settings.TipoOrden : 1);

				if (typeof (viewModel.settings.CamposHabilitadosFiltro) !== 'undefined') {
					for (var name in viewModel.settings.CamposHabilitadosFiltro) {
						if (viewModel.settings.CamposHabilitadosFiltro.hasOwnProperty(name) && viewModel.CamposHabilitadosFiltro.hasOwnProperty(name)) {
							viewModel.CamposHabilitadosFiltro[name] = viewModel.CamposHabilitadosFiltro[name] && viewModel.settings.CamposHabilitadosFiltro[name];
						}
					}
				}

				viewModel.HabilitarFiltro = ko.observable(viewModel.CamposHabilitadosFiltro);
				viewModel.OpcionesFiltrosBooleanos = ko.observableArray([{ Nombre: viewModel.TraduccionCampos.get('Todos_Text'), Valor: 'null' }, { Nombre: viewModel.TraduccionCampos.get('Si_Text'), Valor: 'true' }, { Nombre: viewModel.TraduccionCampos.get('No_Text'), Valor: 'false' }]);
				viewModel.OpcionesBooleanasMantenerValor = ko.observableArray([{ Nombre: viewModel.TraduccionCampos.get('MantenerValorCampo_Text'), Valor: 'null' }, { Nombre: viewModel.TraduccionCampos.get('Si_Text'), Valor: 'true' }, { Nombre: viewModel.TraduccionCampos.get('No_Text'), Valor: 'false' }]);
				viewModel.ListadoCargado = ko.observable(false);
				viewModel.SeleccionarTodos = ko.observable(false);
				viewModel.Columnas = ko.observableArray(viewModel.settings.System.ObtenerColumnasSeleccionadasDeRepositorio());
				viewModel.MostrarListado = ko.observable(true);
				viewModel.NumeroPaginasAMostrar = 1;
				viewModel.TamanyosPagina = [50, 100, 150, 200, 500];
				viewModel.TamanyoPagina = ko.observable(viewModel.settings.TamanyoPagina);
				viewModel.RegistroInicial = 1;
				viewModel.RegistroFinal = viewModel.settings.TamanyoPagina;
				viewModel.ColumnaOrden = ko.observable(viewModel.settings.ColumnaOrden);
				viewModel.TipoOrden = ko.observable(viewModel.settings.TipoOrden);
				viewModel.RegistrosCargados = ko.observable(0);
				viewModel.FiltroModificado = ko.observable(false);
				viewModel.ColumnasOcultasVisibles = ko.observable(false);
				viewModel.IdsRegistrosFijos = (viewModel.settings.ModuloPrincipal ? viewModel.settings.System.ObtenerRegistrosFijosDeRepositorio() : (typeof (settings.Filtro.IdsRegistrosFijos) !== 'undefined' ? settings.Filtro.IdsRegistrosFijos : []));
				viewModel.SoloRegistrosFijos = (!viewModel.settings.ModuloPrincipal && typeof (settings.Filtro.IdsRegistrosFijos) !== 'undefined');
				viewModel.TotalRegistros = ko.lazyObservable(viewModel.Count, viewModel); // OLL: Devuelve el total de registros de la tabla, no el de la búsqueda. Deberíamos obtener el total de la búsqueda. Mejor hacerlo en la misma consulta.
				if (viewModel.IdsRegistrosFijos.length > 0) {
					viewModel.RegistrosFijos = ko.lazyObservableArray(GlobalControllers[viewModel.Entidad + 'Controller'].GetQuery, viewModel, {
						Parameters: 'query=' + viewModel.Entidad + '_ObtenerLista' + (viewModel.TieneExtensionObtenerLista ? 'Extension' : '') +
						'&parameter=Lista|varchar|' + viewModel.IdsRegistrosFijos.join() + '|500',
						PrellamadaApi: function () { viewModel.Cargando(true); },
						PostllamadaApi: function () { viewModel.Cargando(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observable) { self.RegistrosObtenidos(viewModel, observable, 'Fijos'); },
						RegistrosObtenidos: self.IncluirCamposUI,
						RegistrosCargados: viewModel.TotalRegistros(),
						TamanyoPagina: viewModel.TamanyoPagina(),
						RegistrosComoObservables: false
					});
				} else {
					viewModel.RegistrosFijos = ko.observableArray();
				}

				if (viewModel.settings.ModuloPrincipal) {
					var _filtroRepositorio = viewModel.settings.System.ObtenerFiltroDeRepositorio();
					if (_filtroRepositorio != null) { self.AplicarFiltro(_filtroRepositorio, viewModel.Filtro()); }
				}

				if (typeof (viewModel.settings.Filtro) !== 'undefined' && viewModel.settings.Filtro != null) {
					viewModel.FiltroFijado(ko.toJS(viewModel.settings.Filtro));
					self.AplicarFiltro(ko.toJS(viewModel.settings.Filtro), viewModel.Filtro(), viewModel.CamposHabilitadosFiltro);
				}
				// OLL: Revisar esto. Lo hice rápidamente. Mirar si hay una mejor manera de mantener propiedades del filtro
				if (typeof (viewModel.RevisarFiltro) != 'undefined') { viewModel.RevisarFiltro(viewModel); }

				//viewModel.filtroAplicado = true;

				//if (viewModel.settings.BusquedaAutomatica) {
				//	viewModel.Registros = ko.lazyObservableArray(GlobalControllers[viewModel.Entidad + 'Controller'].GetQuery, viewModel, viewModel.GenerarOpcionesObtenerRegistrosListado(ko.toJS(viewModel.Filtro)));
				//} else {
				viewModel.Registros = ko.observableArray();
				//}

				viewModel.RegistrosSeleccionados = ko.computed(function () {
					return $.grep(this.Registros(), function (r) { return r.RegistroSeleccionado() == true; });
				}, viewModel);

				viewModel.RegistrosFijosSeleccionados = ko.computed(function () {
					return $.grep(this.RegistrosFijos(), function (r) { return r.RegistroSeleccionado() == true; });
				}, viewModel);

				viewModel.HayRegistrosSeleccionados = ko.computed(function () {
					return this.RegistrosSeleccionados().length > 0 || this.RegistrosFijosSeleccionados().length > 0;
				}, viewModel);

				viewModel.NumeroRegistrosABorrar = ko.observable(0);
				viewModel.NumeroRegistrosBorrados = ko.observable(0);
				viewModel.RegistroCopia = ko.observable(null);
				viewModel.NumeroRegistrosACopiar = ko.observable(0);
				viewModel.NumeroRegistrosCopiados = ko.observable(0);
				viewModel.MostrarFormularioCopia = ko.observable(false);
				viewModel.RegistroEdicionMultiple = ko.observable(null);
				viewModel.NumeroRegistrosAEditar = ko.observable(0);
				viewModel.NumeroRegistrosEditados = ko.observable(0);
				viewModel.MostrarFormularioEdicionMultiple = ko.observable(false);
			}

			var InicializarViewModelEdicion = function (viewModel, settings, modelo) {
				if (typeof (viewModel.settings.CamposVisiblesInsercion) !== 'undefined') {
					for (var name in viewModel.settings.CamposVisiblesInsercion) {
						if (viewModel.settings.CamposVisiblesInsercion.hasOwnProperty(name) && viewModel.CamposVisiblesInsercion.hasOwnProperty(name)) {
							viewModel.CamposVisiblesInsercion[name] = viewModel.CamposVisiblesInsercion[name] && viewModel.settings.CamposVisiblesInsercion[name];
						}
					}
				}
				if (typeof (viewModel.settings.CamposVisiblesEdicion) !== 'undefined') {
					for (var name in viewModel.settings.CamposVisiblesEdicion) {
						if (viewModel.settings.CamposVisiblesEdicion.hasOwnProperty(name) && viewModel.CamposVisiblesEdicion.hasOwnProperty(name)) {
							viewModel.CamposVisiblesEdicion[name] = viewModel.CamposVisiblesEdicion[name] && viewModel.settings.CamposVisiblesEdicion[name];
						}
					}
				}
				if (typeof (viewModel.settings.CamposHabilitadosInsercion) !== 'undefined') {
					for (var name in viewModel.settings.CamposHabilitadosInsercion) {
						if (viewModel.settings.CamposHabilitadosInsercion.hasOwnProperty(name) && viewModel.CamposHabilitadosInsercion.hasOwnProperty(name)) {
							viewModel.CamposHabilitadosInsercion[name] = viewModel.CamposHabilitadosInsercion[name] && viewModel.settings.CamposHabilitadosInsercion[name];
						}
					}
				}
				if (typeof (viewModel.settings.CamposHabilitadosEdicion) !== 'undefined') {
					for (var name in viewModel.settings.CamposHabilitadosEdicion) {
						if (viewModel.settings.CamposHabilitadosEdicion.hasOwnProperty(name) && viewModel.CamposHabilitadosEdicion.hasOwnProperty(name)) {
							viewModel.CamposHabilitadosEdicion[name] = viewModel.CamposHabilitadosEdicion[name] && viewModel.settings.CamposHabilitadosEdicion[name];
						}
					}
				}

				viewModel.MostrarElemento = ko.observable(viewModel.CamposVisiblesEdicion);
				viewModel.HabilitarElemento = ko.observable(viewModel.CamposHabilitadosEdicion);
				viewModel.CargandoPartial = false;
				viewModel.Registro = ko.validatedObservable(null);
				viewModel.CargandoFormulario = ko.observable(false);
				viewModel.MostrarFormulario = ko.observable(false);
				viewModel.MostrarAcciones = ko.observable(!viewModel.settings.InteraccionExterna);
				viewModel.ModoFormulario = ko.observable(null);
			}

			var GenerarOpcionesObtenerRegistrosListado = function (viewModel, filtro) {
				return {
					Todos: (viewModel.RegistroInicial <= 1),
					Parameters: 'query=' + viewModel.MetodoObtenerPorFiltros +
					'&parameter=RegistroInicial|int|' + viewModel.RegistroInicial +
					'&parameter=RegistroFinal|int|' + viewModel.RegistroFinal +
					'&parameter=ColumnaOrden|nvarchar|' + viewModel.ColumnaOrden() + '|50' +
					'&parameter=TipoOrden|smallint|' + viewModel.TipoOrden() + viewModel.ObtenerFiltros(filtro),
					PrellamadaApi: function () { viewModel.Cargando(true); },
					PostllamadaApi: function () { viewModel.Cargando(false); },
					MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (registros) { viewModel.TotalRegistros.refresh(); self.RegistrosObtenidos(viewModel, registros, 'Normales'); },
					PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); },
					RegistrosObtenidos: self.IncluirCamposUI,
					RegistrosCargados: viewModel.TotalRegistros(),
					TamanyoPagina: viewModel.TamanyoPagina()
				}
			}

			var GenerarOpcionesObtenerCantidadListado = function (viewModel, filtro) {
				return {
					Todos: (viewModel.RegistroInicial <= 1),
					Parameters: 'query=' + viewModel.MetodoObtenerCantidadPorFiltros + viewModel.ObtenerFiltros(filtro),
					PrellamadaApi: function () { viewModel.Cargando(true); },
					PostllamadaApi: function () { viewModel.Cargando(false); },
					MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (cantidad) { },
					PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); }
				}
			}

			self.CerrarPopup = function (viewModel) {
				viewModel.Registro(null);
				viewModel.MostrarFormulario(false);
			}

			self.CapaCargando = {
				Mostrar: utils.Cargando.Mostrar,
				Ocultar: utils.Cargando.Ocultar
			}

			self.AplicarFiltro = function (filtroExterno, filtroInterno, camposHabilitados) {
				var _filtroExterno = ko.toJS(filtroExterno);
				for (var _propiedad in _filtroExterno) {
					if (_filtroExterno.hasOwnProperty(_propiedad) && ((ko.isObservable(filtroInterno) && filtroInterno().hasOwnProperty(_propiedad)) || filtroInterno.hasOwnProperty(_propiedad)) && _propiedad != 'IdMarca') {
						if (ko.isObservable(filtroInterno[_propiedad])) { filtroInterno[_propiedad](_filtroExterno[_propiedad]); } else { filtroInterno[_propiedad] = _filtroExterno[_propiedad]; }
						if (typeof (camposHabilitados) !== 'undefined') { camposHabilitados[_propiedad] = false; }
					}
				}
			}

			// OLL: Mirar de unificar con AplicarFiltro. Ahora lo duplico para subir a producción. Lo ideal sería poder pasar por filtroInterno el modelo, pero creo que entonces fallaba knockout porque
			// algunas propiedades del modelo se rellenaban con valores no deseados
			self.AplicarFiltroEnInsercion = function (filtroExterno, filtroInterno, camposHabilitados, modelo) {
				var _filtroExterno = ko.toJS(filtroExterno);
				for (var _propiedad in _filtroExterno) {
					if (_filtroExterno.hasOwnProperty(_propiedad) && ((ko.isObservable(modelo) && modelo().hasOwnProperty(_propiedad)) || modelo.hasOwnProperty(_propiedad)) && _propiedad != 'IdMarca') {
						if (ko.isObservable(filtroInterno[_propiedad])) { filtroInterno[_propiedad](_filtroExterno[_propiedad]); } else { filtroInterno[_propiedad] = _filtroExterno[_propiedad]; }
						if (typeof (camposHabilitados) !== 'undefined') { camposHabilitados[_propiedad] = false; }
					}
				}
			}

			self.MostrarFiltroFijado = function (fijar, idModulo) {
				if (fijar) {
					$('#' + idModulo + 'contenidoFiltro').prependTo('#' + idModulo + 'dvFiltrosFijadosContenido');
					$('#' + idModulo + 'mostrarFiltro').hide();
					$('#' + idModulo + 'dvFiltrosFijados').show();
					$('#' + idModulo + 'tabs').tabs('option', 'active', 1);
				} else {
					$('#' + idModulo + 'contenidoFiltro').prependTo('#' + idModulo + 'filtro');
					$('#' + idModulo + 'mostrarFiltro').show();
					$('#' + idModulo + 'dvFiltrosFijados').hide();
					$('#' + idModulo + 'tabs').tabs('option', 'active', 0);
				}
			}

			self.ObtenerColumnasDeLosRegistros = function (viewModel, registros) {
				// TODO: OLL mirar de ordenar primero los dos arrays y luego compararlos
				var _columnasModificadas = false;
				var _columnas = viewModel.Columnas();
				if (registros.length > 0) {
					var _columnasFinales = [];
					var _registroJS = ko.toJS(registros[0]);
					$.each(_columnas, function (indice, columna) {
						if (typeof (_registroJS[columna.Nombre]) !== 'undefined') { _columnasFinales.push(columna); } else { _columnasModificadas = true; }
					});
					for (var _propiedad in _registroJS) {
						if (typeof (_propiedad) !== 'function' && _propiedad.substring(0, 1) != '$' && _propiedad.substring(0, 1) != '_' && registros[0].hasOwnProperty(_propiedad) && _propiedad != 'RegistroSeleccionado') {
							if ($.grep(_columnasFinales, function (columna) { return columna.Nombre == _propiedad }).length == 0) {
								var _visible = _propiedad != 'Marca' && _propiedad != 'IdMarca' && _propiedad != 'UsuarioAlta' && _propiedad != 'UsuarioUltimaModificacion' && _propiedad != 'FechaUltimaModificacion' && (_propiedad.substring(0, 2) != 'Id' || (_propiedad.substring(0, 2) == 'Id' && typeof (_registroJS[_propiedad.substring(2)]) === 'undefined'));
								_columnasFinales.push({ Nombre: _propiedad, Literal: viewModel.TraduccionCampos.get(_propiedad + '_Text')(), Visible: ko.observable(_visible) });
								_columnasModificadas = true;
							}
						}
					}
					_columnas = _columnasFinales;
					if (_columnasModificadas) { viewModel.settings.System.GuardarColumnasSeleccionadasEnRepositorio(_columnas); }
					//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas viewModel.settings.System.IncluirSelectorColumnas(viewModel);
				}
				viewModel.Columnas(_columnas);
			}

			self.Select = function (viewModel, registro) {
				if (typeof (viewModel.InicioSelect) !== 'undefined') { viewModel.InicioSelect(registro); }

				if (viewModel.settings.Modo != ModoInicioModulo.Buscador) {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
					viewModel.CargandoPartial = true;
					if (viewModel.settings.Modo == ModoInicioModulo.Listado) {
						popup.AbrirDialogo(viewModel.settings.IdModulo + 'PanelFormulario', 1000, 800, viewModel.TraduccionCampos.get('Edicion_Text')(), function () { self.CerrarPopup(viewModel); });
					} else {
						$(viewModel.settings.Contenedor + ' .panelformulario').css('display', 'block');
					}
					viewModel.ModoFormulario('Edicion')
					viewModel.MostrarFormulario(true);
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(viewModel.Registro, ko.unwrap(registro), {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observable) {
							viewModel.CargandoPartial = false;
							var _camposDeshabilitados = viewModel.CamposHabilitadosEdicion;
							if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltro(viewModel.FiltroFijado(), observable, _camposDeshabilitados); }
							viewModel.MostrarElemento(viewModel.CamposVisiblesEdicion);
							viewModel.HabilitarElemento(_camposDeshabilitados);
							viewModel.VolverAlListadoAlGuardar = viewModel.settings.VolverAListadoAlActualizar;
							if (typeof (viewModel.RegistroCargado) !== 'undefined') { viewModel.RegistroCargado(observable); }
						},
						PeticionFinalizada: function (observable) {
							self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
							//popup.RevisarTamanyo(viewModel.settings.IdModulo + 'PanelFormulario');
							if (typeof (viewModel.FinalizarSelect) === 'function') { viewModel.FinalizarSelect(); }
						},
						RegistrosComoObservables: true
					});
				} else {
					if (typeof (viewModel.MetodosRespuesta.Seleccionado) === 'function') {
						// OLL: Revisar para claves múltiples
						ko.ignoreDependencies(viewModel.MetodosRespuesta.Seleccionado, viewModel, [(ko.isObservable(registro.Id) ? registro.Id() : registro.Id), viewModel.Entidad]);
					} else {
						alert('No se puede seleccionar el registro. No se ha definido un método de selección. Por favor, póngase en contacto con soporte gestores para que revisen este punto.');
					}
				}
			};

			self.FijarRegistro = function (viewModel, registro, event) {
				var _clave = viewModel.SerializarClave(registro);
				if ($.inArray(_clave, viewModel.IdsRegistrosFijos) == -1) {
					viewModel.IdsRegistrosFijos.push(_clave);
					viewModel.RegistrosFijos.push(registro);
					viewModel.Registros.remove(registro);
					viewModel.settings.System.GuardarRegistrosFijosEnRepositorio(viewModel.IdsRegistrosFijos);
				}
			};

			self.LiberarRegistro = function (viewModel, registro, event) {
				viewModel.IdsRegistrosFijos.splice($.inArray(viewModel.SerializarClave(registro), viewModel.IdsRegistrosFijos));
				viewModel.RegistrosFijos.remove(registro);
				viewModel.Registros.push(registro);
				viewModel.settings.System.GuardarRegistrosFijosEnRepositorio(viewModel.IdsRegistrosFijos);
			};

			self.New = function (viewModel, modelo, datosPorDefecto) {
				if (typeof (viewModel.settings.Modelo) === 'undefined') { viewModel.settings.Modelo = modelo; }
				if (typeof (viewModel.settings.DatosPorDefecto) === 'undefined') { viewModel.settings.DatosPorDefecto = datosPorDefecto; }

				if (viewModel.settings.PermitirCrear) {
					if (typeof (viewModel.InicioNew) !== 'undefined') { viewModel.InicioNew(modelo, datosPorDefecto); }

					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
					viewModel.CargandoPartial = true;
					// OLL: Pensar si iría bien configurar un settings de dialogo o no... Así sería más versátil
					if (viewModel.settings.Modo == ModoInicioModulo.Listado || viewModel.settings.Modo == ModoInicioModulo.Buscador) {
						popup.AbrirDialogo(viewModel.settings.IdModulo + 'PanelFormulario', 1000, 800, viewModel.TraduccionCampos.get('Nuevo_Text')(), function () { self.CerrarPopup(viewModel); });
					} else {
						$(viewModel.settings.Contenedor + ' .panelformulario').css('display', 'block');
					}
					viewModel.MostrarFormulario(true);
					var _datosPorDefecto = { IdMarca: viewModel.settings.IdMarca };
					if (typeof (viewModel.settings.DatosPorDefecto) !== 'undefined') { $.extend(_datosPorDefecto, viewModel.settings.DatosPorDefecto) }
					var _camposDeshabilitados = viewModel.CamposHabilitadosInsercion;
					if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltroEnInsercion(viewModel.FiltroFijado(), _datosPorDefecto, _camposDeshabilitados, new viewModel.settings.Modelo({}, viewModel.TraduccionCampos)); }
					viewModel.MostrarElemento(viewModel.CamposVisiblesInsercion);
					viewModel.HabilitarElemento(_camposDeshabilitados);
					viewModel.Registro(new viewModel.settings.Modelo(_datosPorDefecto, viewModel.TraduccionCampos));
					viewModel.CargandoPartial = false;
					viewModel.VolverAlListadoAlGuardar = viewModel.settings.VolverAListadoAlInsertar;
					viewModel.ModoFormulario('Insercion');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			};

			self.Cancel = function (viewModel) {
				popup.CerrarDialogo(viewModel.settings.IdModulo + 'PanelFormulario', function () { self.CerrarPopup(viewModel); });
			};

			self.Count = function (viewModel) {
				var objToValidate = viewModel.Filtro;
				var _vm = ko.validatedObservable(objToValidate);

				if (_vm.isValid()) {
					GlobalControllers[viewModel.Entidad + 'Controller'].Count(viewModel.TotalRegistros, GenerarOpcionesObtenerCantidadListado(viewModel, ko.toJS(objToValidate)));
				}
			};

			self.Update = function (viewModel, registro) {
				if (viewModel.settings.PermitirGuardar) {
					var _nuevo = GlobalControllers[viewModel.Entidad + 'Controller'].EsRegistroNuevo(registro);
					if (_nuevo) {
						if (typeof (viewModel.MetodosRespuesta.AntesInsertar) === 'function') { viewModel.MetodosRespuesta.AntesInsertar(registro); }
					} else {
						if (typeof (viewModel.MetodosRespuesta.AntesActualizar) === 'function') { viewModel.MetodosRespuesta.AntesActualizar(registro); }
					}
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
					var _opciones = {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observable, registro) {
							if (viewModel.VolverAlListadoAlGuardar) {
								viewModel.Refrescar(viewModel);
								// OLL, esta condición me funciona ahora pero no es correcta, tenemos que buscar otra opción para indicar que una partial va por popup o no ¿self.settings.InteraccionExterna?
								if (viewModel.settings.Modo == ModoInicioModulo.Listado || viewModel.settings.Modo == ModoInicioModulo.Buscador) {
									popup.CerrarDialogo(viewModel.settings.IdModulo + 'PanelFormulario', function () { self.CerrarPopup(viewModel); });
								} else {
									// OLL ¿debo hacer algo aquí?
									//$(viewModel.settings.Contenedor + ' .panelformulario').css('display', 'block');
								}
							} else if (viewModel.settings.VolveraInsertarAlGuardar) {
								self.New(viewModel, viewModel.settings.Modelo, viewModel.settings.DatosPorDefecto);
							}
							if (_nuevo) {
								if (typeof (viewModel.MetodosRespuesta.Insertado) === 'function') { viewModel.MetodosRespuesta.Insertado(registro); }
							} else {
								if (typeof (viewModel.MetodosRespuesta.Actualizado) === 'function') { viewModel.MetodosRespuesta.Actualizado(registro); }
							}
						},
						PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario'); },
						Modo: viewModel.ModoFormulario()
					};
					if (typeof (viewModel.MetodoExtensionNew) !== 'undefined') { _opciones.ActionPost = viewModel.MetodoExtensionNew; }
					if (typeof (viewModel.MetodoExtensionUpdate) !== 'undefined') { _opciones.ActionPut = viewModel.MetodoExtensionUpdate; }
					GlobalControllers[viewModel.Entidad + 'Controller'].Update(viewModel.Registro, ko.unwrap(registro), _opciones);
				}
			}

			self.Delete = function (viewModel, registro, pedirConfirmacion) {
				if (viewModel.settings.PermitirBorrar) {
					var _observable = ko.observable({});
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observableRegistroObtenido) {
							var _opciones = {
								PrellamadaApi: function () { viewModel.Cargando(true); },
								PostllamadaApi: function () { viewModel.Cargando(false); },
								MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
								PeticionFinalizada: function (observableRegistroEliminado) {
									viewModel.NumeroRegistrosBorrados(viewModel.NumeroRegistrosBorrados() + 1);
									if (viewModel.NumeroRegistrosBorrados() >= viewModel.NumeroRegistrosABorrar()) {
										self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
										viewModel.Refrescar(viewModel);
										viewModel.SeleccionarTodos(false);
									}
								},
								PedirConfirmacion: pedirConfirmacion
							};
							if (typeof (viewModel.MetodoExtensionDelete) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionDelete; }
							GlobalControllers[viewModel.Entidad + 'Controller'].Delete(observableRegistroObtenido, observableRegistroObtenido(), _opciones);
						},
					});
				}
			}

			self.DeleteSelected = function (viewModel) {
				if (confirm(viewModel.settings.System.settings.MensajeEstaSeguroBorrarSeleccionados)) {
					viewModel.NumeroRegistrosCopiados(0);
					viewModel.NumeroRegistrosACopiar(viewModel.RegistrosSeleccionados().length + viewModel.RegistrosFijosSeleccionados().length);
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					$(viewModel.RegistrosSeleccionados()).each(function (indice, registro) { viewModel.Delete(registro, false); });
					$(viewModel.RegistrosFijosSeleccionados()).each(function (indice, registro) { viewModel.LiberarRegistro(registro); viewModel.Delete(registro, false); });

					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.SeleccionarTodos(false);
				}
			}

			self.CancelarCopiar = function (viewModel) {
				popup.CerrarDialogo(viewModel.settings.IdModulo + 'FormularioCopia', function () { viewModel.MostrarFormularioCopia(false); viewModel.RegistroCopia(null); });
			};

			self.MostrarDialogoCopia = function (viewModel, modelo) {
				if (viewModel.settings.PermitirCopiar) {
					var _registroCopia = new modelo({}, viewModel.TraduccionCampos);
					for (var propiedad in _registroCopia) {
						if (_registroCopia.hasOwnProperty(propiedad)) {
							if (ko.isObservable(_registroCopia[propiedad])) { _registroCopia[propiedad](null); } else { _registroCopia[propiedad] = null; }
						};
					}
					viewModel.RegistroCopia(_registroCopia);

					popup.AbrirDialogo(viewModel.settings.IdModulo + 'FormularioCopia', 1000, 800, viewModel.TraduccionCampos.get('Copiar_Text')(), function () { viewModel.MostrarFormularioCopia(false); viewModel.RegistroCopia(null); });
					viewModel.MostrarFormularioCopia(true);
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioCopia');
				} else {
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, 'No tiene permisos para copiar los registros.', 'Error');
				}
			}

			self.CopiarSeleccionados = function (viewModel, registroCopia) {
				if (confirm(viewModel.settings.System.settings.MensajeEstaSeguroCopiarSeleccionados)) {
					registroCopia = ko.toJS(registroCopia);
					for (var propiedad in registroCopia) {
						if (registroCopia.hasOwnProperty(propiedad) && (registroCopia[propiedad] == null || (Array.isArray(registroCopia[propiedad]) && registroCopia[propiedad].length == 0) || typeof (registroCopia[propiedad]) === 'function')) {
							delete registroCopia[propiedad];
						};
					}

					viewModel.NumeroRegistrosCopiados(0);
					viewModel.NumeroRegistrosACopiar(viewModel.RegistrosSeleccionados().length + viewModel.RegistrosFijosSeleccionados().length);
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioCopia');
					$(viewModel.RegistrosSeleccionados()).each(function (indice, registro) { viewModel.Copiar(registro, false, registroCopia); });
					$(viewModel.RegistrosFijosSeleccionados()).each(function (indice, registro) { viewModel.Copiar(registro, false, registroCopia); });
				}
			}

			self.Copiar = function (viewModel, registro, pedirConfirmacion, registroCopia) {
				if (viewModel.settings.PermitirCopiar) {
					var _observable = ko.observable({});
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observableRegistroObtenido) {
							var _registroInicial = $.extend(ko.toJS(observableRegistroObtenido()), ko.toJS(registroCopia));
							_registroInicial = viewModel.InicializarClave(_registroInicial);
							var _opciones = {
								Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
								PrellamadaApi: function () { viewModel.Cargando(true); },
								PostllamadaApi: function () { viewModel.Cargando(false); },
								MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
								RespuestaPeticionCorrecta: function (observableRegistroPrimerIdiomaGuardado, registroPrimerIdiomaGuardado) {
									if (viewModel.settings.Multiidioma) {
										_registroInicial = viewModel.AsignarClave(observableRegistroPrimerIdiomaGuardado(), _registroInicial);
										viewModel.settings.Culturas.filter(function (cultura) { return cultura != viewModel.settings.Cultura; }).forEach(function (cultura) {
											GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
												Parameters: { Cultura: cultura },
												PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
												PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
												MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
												RespuestaPeticionCorrecta: function (observableRegistroOtroIdiomaObtenido) {
													var _registroIdioma = $.extend(ko.toJS(observableRegistroOtroIdiomaObtenido()), ko.toJS(registroCopia));
													_registroIdioma = viewModel.AsignarClave(_registroInicial, _registroIdioma);
													var _opciones = {
														Parameters: { Cultura: cultura },
														PrellamadaApi: function () { viewModel.Cargando(true); },
														PostllamadaApi: function () { viewModel.Cargando(false); },
														MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
														PedirConfirmacion: pedirConfirmacion
													};
													if (typeof (viewModel.MetodoExtensionUpdate) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionUpdate; }
													GlobalControllers[viewModel.Entidad + 'Controller'].Update(_observable, _registroIdioma, _opciones);
												},
												Modo: 'Edicion'
											});
										});
									}
								},
								PeticionFinalizada: function (observable) {
									viewModel.NumeroRegistrosCopiados(viewModel.NumeroRegistrosCopiados() + 1);
									if (viewModel.NumeroRegistrosCopiados() >= viewModel.NumeroRegistrosACopiar()) {
										self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioCopia');
										viewModel.Refrescar(viewModel);
										viewModel.SeleccionarTodos(false);
										popup.CerrarDialogo(viewModel.settings.IdModulo + 'FormularioCopia');
									}
								},
								PedirConfirmacion: pedirConfirmacion
							};
							if (typeof (viewModel.MetodoExtensionNew) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionNew; }
							GlobalControllers[viewModel.Entidad + 'Controller'].Update(_observable, _registroInicial, _opciones);
						},
						Modo: 'Insercion'
					});
				}
			}

			self.CancelarEdicionMultiple = function (viewModel) {
				popup.CerrarDialogo(viewModel.settings.IdModulo + 'FormularioEdicionMultiple', function () { viewModel.MostrarFormularioEdicionMultiple(false); viewModel.RegistroEdicionMultiple(null); });
			};

			self.MostrarDialogoEdicionMultiple = function (viewModel, modelo) {
				if (viewModel.settings.PermitirEdicionMultiple) {
					var _registroEdicionMultiple = new modelo({}, viewModel.TraduccionCampos);
					for (var propiedad in _registroEdicionMultiple) {
						if (_registroEdicionMultiple.hasOwnProperty(propiedad)) {
							if (ko.isObservable(_registroEdicionMultiple[propiedad])) { _registroEdicionMultiple[propiedad](null) } else { _registroEdicionMultiple[propiedad] = null; }
						};
					}
					viewModel.RegistroEdicionMultiple(_registroEdicionMultiple);

					popup.AbrirDialogo(viewModel.settings.IdModulo + 'FormularioEdicionMultiple', 1000, 800, viewModel.TraduccionCampos.get('EdicionMultiple_Text')(), function () { viewModel.MostrarFormularioEdicionMultiple(false); viewModel.RegistroEdicionMultiple(null); });
					viewModel.MostrarFormularioEdicionMultiple(true);
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioEdicionMultiple');
				} else {
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, 'No tiene permisos para editar simultaneamente varios registros.', 'Error');
				}
			}

			self.EditarSeleccionados = function (viewModel, registroEdicionMultiple) {
				if (confirm(viewModel.settings.System.settings.MensajeEstaSeguroEditarSeleccionados)) {
					registroEdicionMultiple = ko.toJS(registroEdicionMultiple);
					for (var propiedad in registroEdicionMultiple) {
						if (registroEdicionMultiple.hasOwnProperty(propiedad) && (registroEdicionMultiple[propiedad] == null || (Array.isArray(registroEdicionMultiple[propiedad]) && registroEdicionMultiple[propiedad].length == 0) || typeof (registroEdicionMultiple[propiedad]) === 'function')) {
							delete registroEdicionMultiple[propiedad];
						};
					}

					viewModel.NumeroRegistrosEditados(0);
					viewModel.NumeroRegistrosAEditar(viewModel.RegistrosSeleccionados().length + viewModel.RegistrosFijosSeleccionados().length);
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioEdicionMultiple');
					$(viewModel.RegistrosSeleccionados()).each(function (indice, registro) { viewModel.Editar(registro, false, registroEdicionMultiple); });
					$(viewModel.RegistrosFijosSeleccionados()).each(function (indice, registro) { viewModel.Editar(registro, false, registroEdicionMultiple); });
				}
			}

			self.Editar = function (viewModel, registro, pedirConfirmacion, registroEdicionMultiple) {
				if (viewModel.settings.PermitirEdicionMultiple) {
					var _observable = ko.observable({});
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observableRegistroObtenido) {
							var _registroInicial = $.extend(ko.toJS(observableRegistroObtenido()), ko.toJS(registroEdicionMultiple));
							var _opciones = {
								Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
								PrellamadaApi: function () { viewModel.Cargando(true); },
								PostllamadaApi: function () { viewModel.Cargando(false); },
								MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
								RespuestaPeticionCorrecta: function (observableRegistroPrimerIdiomaGuardado, registroPrimerIdiomaGuardado) {
									if (viewModel.settings.Multiidioma) {
										_registroInicial = viewModel.AsignarClave(observableRegistroPrimerIdiomaGuardado(), _registroInicial);
										viewModel.settings.Culturas.filter(function (cultura) { return cultura != viewModel.settings.Cultura; }).forEach(function (cultura) {
											GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
												Parameters: { Cultura: cultura },
												PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
												PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
												MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
												RespuestaPeticionCorrecta: function (observableRegistroOtroIdiomaObtenido) {
													var _registroIdioma = $.extend(ko.toJS(observableRegistroOtroIdiomaObtenido()), ko.toJS(registroEdicionMultiple));
													_registroIdioma = viewModel.AsignarClave(_registroInicial, _registroIdioma);
													var _opciones = {
														Parameters: { Cultura: cultura },
														PrellamadaApi: function () { viewModel.Cargando(true); },
														PostllamadaApi: function () { viewModel.Cargando(false); },
														MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
														PedirConfirmacion: pedirConfirmacion
													};
													if (typeof (viewModel.MetodoExtensionUpdate) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionUpdate; }
													GlobalControllers[viewModel.Entidad + 'Controller'].Update(_observable, _registroIdioma, _opciones);
												},
												Modo: 'Edicion'
											});
										});
									}
								},
								PeticionFinalizada: function (observable) {
									viewModel.NumeroRegistrosEditados(viewModel.NumeroRegistrosEditados() + 1);
									if (viewModel.NumeroRegistrosEditados() >= viewModel.NumeroRegistrosAEditar()) {
										self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormularioEdicionMultiple');
										viewModel.Refrescar(viewModel);
										viewModel.SeleccionarTodos(false);
										popup.CerrarDialogo(viewModel.settings.IdModulo + 'FormularioEdicionMultiple');
									}
								},
								PedirConfirmacion: pedirConfirmacion
							};
							if (typeof (viewModel.MetodoExtensionUpdate) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionUpdate; }
							GlobalControllers[viewModel.Entidad + 'Controller'].Update(_observable, _registroInicial, _opciones);
						},
						Modo: 'Edicion'
					});
				}
			}

			self.IncluirCamposUI = function (observable, registros) {
				$(registros).each(function (indice, registro) { registro.RegistroSeleccionado = ko.observable(false); });
				return registros;
			};

			self.RegistrosObtenidos = function (viewModel, observable, tipo) {
				var _registros = observable();
				if (tipo != 'Fijos') { viewModel.RegistrosCargados(_registros.length); }
				self.ObtenerColumnasDeLosRegistros(viewModel, _registros);
				var _registrosFiltrados = null;
				if (tipo != 'Fijos') {
					_registrosFiltrados = ko.utils.arrayFilter(_registros, function (registro) { return $.inArray(viewModel.SerializarClave(registro), viewModel.IdsRegistrosFijos) == -1; })
					observable(_registrosFiltrados);
				}
				$(viewModel.settings.Contenedor + ' .tabs').tabs("option", "active", 1);
				viewModel.FiltroModificado(false);
				viewModel.ListadoCargado(true);

				// OLL: Obsoleto. Revisar donde se utiliza
				if (viewModel.SoloRegistrosFijos || (!viewModel.SoloRegistrosFijos && tipo != 'Fijos')) { viewModel.settings.CargaFinalizada(); }
				if (typeof (viewModel.MetodosRespuesta.RegistrosCargados) === 'function') {
					var _registrosObtenidos = viewModel.RegistrosFijos();
					if (_registrosFiltrados != null) { _registrosObtenidos.concat(_registrosFiltrados); }
					ko.ignoreDependencies(viewModel.MetodosRespuesta.RegistrosCargados, viewModel, [_registrosObtenidos]);
				}
				$(viewModel.settings.Container + " .contenedorListado").trigger('refrescarExpandToParent');
				$(viewModel.settings.Container + " .contenedorListado").trigger('refrescarDoubleScroll');
				$(viewModel.settings.Container + " table.scroll").trigger('refrescarFix');
			}

			self.RestablecerFiltroPorDefecto = function (viewModel, filtro) {
				var _filtroActual = viewModel.Filtro();
				var _filtroFijado = viewModel.FiltroFijado();
				for (var _propiedad in _filtroActual) {
					if (_filtroActual.hasOwnProperty(_propiedad) && (typeof (_filtroFijado) === 'undefined' || _filtroFijado == null || !_filtroFijado.hasOwnProperty(_propiedad))) {
						_filtroActual[_propiedad]((_propiedad == 'IdMarca' ? viewModel.settings.IdMarca : null));
					}
				}
				viewModel.Filtro(_filtroActual);
				if (viewModel.settings.ModuloPrincipal) { viewModel.settings.System.GuardarFiltroEnRepositorio(ko.toJS(_filtroActual)); }
			}

			self.Buscar = function (viewModel) {
				try {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.RegistrosCargados(0);
					//viewModel.Registros([]);
					viewModel.NumeroPaginasAMostrar = 1;
					viewModel.RegistroInicial = viewModel.RegistrosCargados() + 1;
					viewModel.RegistroFinal = (viewModel.NumeroPaginasAMostrar * viewModel.TamanyoPagina());
					viewModel.Get();
				} catch (excepcion) {
					console.log(excepcion);
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, excepcion.message, 'Error');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
				}
			}

			self.Refrescar = function (viewModel) {
				try {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.RegistrosCargados(0);
					//viewModel.Registros([]);
					viewModel.RegistroInicial = viewModel.RegistrosCargados() + 1;
					viewModel.RegistroFinal = (viewModel.NumeroPaginasAMostrar * viewModel.TamanyoPagina());
					viewModel.Get();
				} catch (excepcion) {
					console.log(excepcion);
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, excepcion.message, 'Error');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
				}
			}

			self.VerMas = function (viewModel) {
				try {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.RegistroInicial = viewModel.RegistrosCargados() + 1;
					viewModel.RegistroFinal = viewModel.RegistrosCargados() + viewModel.TamanyoPagina();
					viewModel.Get();
					viewModel.NumeroPaginasAMostrar++;
				} catch (excepcion) {
					console.log(excepcion);
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, excepcion.message, 'Error');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
				}
			}

			self.Get = function (viewModel) {
				var objToValidate = viewModel.Filtro;
				var _vm = ko.validatedObservable(objToValidate);

				if (_vm.isValid()) {
					viewModel.ListadoCargado(false);
					if (viewModel.settings.ModuloPrincipal) { viewModel.settings.System.GuardarFiltroEnRepositorio(ko.toJS(objToValidate)); }
					GlobalControllers[viewModel.Entidad + 'Controller'].GetQuery(viewModel.Registros, GenerarOpcionesObtenerRegistrosListado(viewModel, ko.toJS(objToValidate)));
				}
			}

			self.ColumnaVisible = function (viewModel, nombreColumna) {
				var _columna = $.grep(viewModel.Columnas(), function (e) { return e.Nombre == nombreColumna })[0];
				return (typeof (_columna) !== 'undefined' ? _columna.Visible() : false);
			}

			self.ColumnaOculta = function (viewModel, nombreColumna) {
				var _columna = $.grep(viewModel.Columnas(), function (e) { return e.Nombre == nombreColumna })[0];
				return (typeof (_columna) !== 'undefined' && typeof (_columna.Oculta) !== 'undefined' ? _columna.Oculta() : false);
			}

			//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas 
			//self.PosicionarSelector = function (viewModel, columna) {
			//	if ($.grep(viewModel.Columnas(), function (e) { return e.Visible() == true }).length > 0) {
			//		viewModel.settings.System.IncluirSelectorColumnas(viewModel);
			//		viewModel.settings.System.GuardarColumnasSeleccionadasEnRepositorio(ko.toJS(viewModel.Columnas()));
			//		$(viewModel.settings.Container + " .contenedorListado").trigger('refrescarExpandToParent');
			//		$(viewModel.settings.Container + " .contenedorListado").trigger('refrescarDoubleScroll');
			//		$(viewModel.settings.Container + " table.scroll").trigger('refrescarFix');
			//		return true;
			//	} else {
			//		columna.Visible(!columna.Visible());
			//		alert('No se pueden ocultar todas las columnas, debe mantener al menos una columna visible.');
			//		return false;
			//	}
			//}

			self.ActualizarSeleccion = function (viewModel) {
				$(viewModel.Registros()).each(function (indice, registro) { registro.RegistroSeleccionado(viewModel.SeleccionarTodos()); });
				return true;
			}

			self.Inicializar = function (viewModel, settings, modelo) {
				//if (!viewModel.filtroAplicado && typeof (settings.Filtro) !== 'undefined' && settings.Filtro != null) {
				//	viewModel.FiltroFijado(settings.Filtro);
				//	self.AplicarFiltro(settings.Filtro, viewModel.FiltroPorDefecto, viewModel.CamposHabilitadosFiltro);
				//	viewModel.Filtro(viewModel.FiltroPorDefecto);
				//}
				if (typeof (settings.MetodosRespuesta) !== 'undefined' && settings.MetodosRespuesta != null) {
					if (typeof (settings.MetodosRespuesta.AntesInsertar) === 'function') { viewModel.MetodosRespuesta.AntesInsertar = settings.MetodosRespuesta.AntesInsertar; }
					if (typeof (settings.MetodosRespuesta.Insertado) === 'function') { viewModel.MetodosRespuesta.Insertado = settings.MetodosRespuesta.Insertado; }
					if (typeof (settings.MetodosRespuesta.AntesActualizar) === 'function') { viewModel.MetodosRespuesta.AntesActualizar = settings.MetodosRespuesta.AntesActualizar; }
					if (typeof (settings.MetodosRespuesta.Actualizado) === 'function') { viewModel.MetodosRespuesta.Actualizado = settings.MetodosRespuesta.Actualizado; }
					if (typeof (settings.MetodosRespuesta.RegistrosCargados) === 'function') { viewModel.MetodosRespuesta.RegistrosCargados = settings.MetodosRespuesta.RegistrosCargados; }
					if (typeof (settings.MetodosRespuesta.Seleccionado) === 'function') { viewModel.MetodosRespuesta.Seleccionado = settings.MetodosRespuesta.Seleccionado; }
				}
				viewModel.settings.Modo = (typeof (settings.Modo) !== 'undefined' && settings.Modo != null ? settings.Modo : ModoInicioModulo.Listado);
				if (viewModel.settings.Modo == ModoInicioModulo.Listado || viewModel.settings.Modo == ModoInicioModulo.Buscador) {
					viewModel.MostrarListado(true);
					if (!viewModel.SoloRegistrosFijos && viewModel.settings.BusquedaAutomatica) { viewModel.Buscar(settings.Filtro); }
				} else if (viewModel.settings.Modo == ModoInicioModulo.Insercion) {
					viewModel.MostrarListado(false);
					viewModel.New(viewModel, modelo, datosPorDefecto);
				} else if (viewModel.settings.Modo == ModoInicioModulo.Edicion) {
					viewModel.MostrarListado(false);
					viewModel.Select(new modelo(settings.Filtro, viewModel.TraduccionCampos));
				}
			}

			self.ExportarAExcel = function (viewModel) {
				try {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					var objToValidate = viewModel.Filtro;
					var _vm = ko.validatedObservable(objToValidate);

					if (_vm.isValid()) {
						if (viewModel.settings.ModuloPrincipal) { viewModel.settings.System.GuardarFiltroEnRepositorio(ko.toJS(objToValidate)); }
						viewModel.RegistroInicial = 1;
						GlobalControllers[viewModel.Entidad + 'Controller'].GetExcel(GenerarOpcionesObtenerRegistrosListado(viewModel, ko.toJS(objToValidate)));
					}
				} catch (excepcion) {
					console.log(excepcion);
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, excepcion.message, 'Error');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
				}
			}

			self.ExportarAPdf = function (viewModel) {
				try {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					var _registros = viewModel.RegistrosSeleccionados();
					_registros = _registros.concat(viewModel.RegistrosFijosSeleccionados());
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPdf(_registros, {
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observable, registro) { },
						PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); }
					});
				} catch (excepcion) {
					console.log(excepcion);
					viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, excepcion.message, 'Error');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
				}

			}

			self.Ordenar = function (viewModel, columna) {
				var _columnaActual = viewModel.ColumnaOrden();
				viewModel.TipoOrden((_columnaActual == columna) ? viewModel.TipoOrden() * -1 : 1);
				viewModel.ColumnaOrden(columna)
				self.Refrescar(viewModel);
			}

			self.MostrarOcultarColumnas = function (viewModel) {
				var _columnas = viewModel.Columnas();
				$.each(_columnas, function (indice, columna) {
					if (typeof (columna.Oculta) === 'undefined') {
						columna.Oculta = ko.observable(!columna.Visible());
						columna.Visible(true);
					} else {
						columna.Visible(!columna.Oculta());
						delete (columna.Oculta);
					}
				});
				viewModel.Columnas(_columnas);
				viewModel.ColumnasOcultasVisibles(!viewModel.ColumnasOcultasVisibles());
			}

			self.MostrarOcultarColumna = function (viewModel, columna) {
				var _columna = $.grep(viewModel.Columnas(), function (e) { return e.Nombre == columna })[0];
				_columna.Oculta(!_columna.Oculta());

				var _columnas = ko.toJS(viewModel.Columnas());
				$.each(_columnas, function (indice, columna) { columna.Visible = !columna.Oculta; delete (columna.Oculta); });
				viewModel.settings.System.GuardarColumnasSeleccionadasEnRepositorio(_columnas);
			}

			self.MostrarBuscador = function (viewModel, entidad, observable) {
				popup.AbrirDialogo(viewModel.settings.IdPartial + entidad + 'BuscadorContenedorExterno', 1000, 800, 'Buscador de ' + entidad + '...');
				eval('viewModel.MostrarBuscador' + entidad + '(true)')
			}

			self.ActualizarSeleccionadoEnBuscador = function (viewModel, id, entidad, observable) {
				observable(id);
				popup.CerrarDialogo(viewModel.settings.IdPartial + entidad + 'BuscadorContenedorExterno');
				// OLL ¿Es necesario?
				eval('viewModel.MostrarBuscador' + entidad + '(false)');
			}

			self.ActivarBloque = function (viewModel, id) {
				viewModel.PestanyaVisible(id);
				var observable = eval('viewModel.ActivarPestanya' + id);
				if (typeof observable !== 'undefined') {
					if (ko.isObservable(observable)) { observable(true); }
				}
			}

			self.ActualizarCampoBooleano = function (viewModel, registro, propiedad, indice, tipo) {
				var _deshacerCambio = function (viewModel, indice, tipo) {
					var _observable = (tipo == 'Fijos' ? viewModel.RegistrosFijos : viewModel.Registros);
					var _registros = _observable().slice(0);
					var _registro = _registros[indice];
					eval('_registro.' + propiedad + ' = !_registro.' + propiedad);
					_observable([]);
					_observable(_registros);
				}

				if (viewModel.settings.PermitirGuardar) {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					if (typeof (viewModel.MetodosRespuesta.AntesActualizar) === 'function') { viewModel.MetodosRespuesta.AntesActualizar(registro); }
					var _observable = ko.observable({});
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(_observable, ko.unwrap(registro), {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observableRegistroObtenido) {
							var _registro = observableRegistroObtenido();
							eval('_registro.' + propiedad + ' = !_registro.' + propiedad);

							var _opciones = {
								Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
								PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
								PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
								MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
								RespuestaPeticionCorrecta: function (observableRegistoActualizado, registroActualizado) {
									if (typeof (viewModel.MetodosRespuesta.Actualizado) === 'function') { viewModel.MetodosRespuesta.Actualizado(registroActualizado); }
								},
								RespuestaPeticionConErrores: function (xhr, status) { _deshacerCambio(viewModel); },
								PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); },
								Modo: 'Edicion'
							};
							if (typeof (viewModel.MetodoExtensionUpdate) !== 'undefined') { _opciones.ActionPut = viewModel.MetodoExtensionUpdate; }
							GlobalControllers[viewModel.Entidad + 'Controller'].Update(observableRegistroObtenido, _registro, _opciones);
						},
						RespuestaPeticionConErrores: function (xhr, status) {
							_deshacerCambio(viewModel);
							self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
						}
					});
				}
				return true;
			}

			function RegistrarController(controller, settings) {
				if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[controller]) == 'undefined') { eval('GlobalControllers[controller] = new ' + controller + '(settings)'); }
			}
		}
		return new BaseViewModel();
	} catch (excepcion) {
		console.log(excepcion);
	}
});