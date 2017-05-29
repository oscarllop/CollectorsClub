define(['jquery', 'dojo/order!knockout', './Core.Utils', 'Globales/popup'], function ($, ko, utils, popup) {
	try {
		function BaseViewModel() {
			var self = this;

			self.InicializarViewModel = function (viewModel, settings, modelo) {
				viewModel.settings.PermitirCrear = (typeof (viewModel.settings.PermitirCrear) !== 'undefined' ? viewModel.settings.PermitirCrear : true);
				viewModel.settings.PermitirGuardar = (typeof (viewModel.settings.PermitirGuardar) !== 'undefined' ? viewModel.settings.PermitirGuardar : true);
				viewModel.settings.PermitirBorrar = (typeof (viewModel.settings.PermitirBorrar) !== 'undefined' ? viewModel.settings.PermitirBorrar : true);
				viewModel.settings.InteraccionExterna = (typeof (viewModel.settings.InteraccionExterna) !== 'undefined' ? viewModel.settings.InteraccionExterna : false);
				viewModel.settings.ModuloPrincipal = (typeof (viewModel.settings.ModuloPrincipal) !== 'undefined' ? viewModel.settings.ModuloPrincipal : false);
				viewModel.settings.Modo = (typeof (viewModel.settings.Modo) !== 'undefined' ? viewModel.settings.Modo : ModoInicioModulo.Defecto);
				viewModel.settings.MostrarMensaje = (typeof (viewModel.settings.MostrarMensaje) !== 'undefined' ? viewModel.settings.MostrarMensaje : viewModel.settings.MostrarMensaje);
				viewModel.TraduccionCampos = ko.observableDictionary([]);
				viewModel.MetodosRespuesta = new Array();
				viewModel.Cargando = ko.observable(false);

				InicializarViewModelEdicion(viewModel, settings, modelo);

				viewModel.Inicializar(settings);
			};

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

				viewModel.MostrarElemento = ko.observable(viewModel.CamposVisiblesInsercion);
				viewModel.HabilitarElemento = ko.observable(viewModel.CamposHabilitadosInsercion);
				viewModel.CargandoPartial = false;
				viewModel.Registro = ko.validatedObservable(null);
				viewModel.CargandoFormulario = ko.observable(false);
				viewModel.MostrarFormulario = ko.observable(false);
				viewModel.MostrarAcciones = ko.observable(!viewModel.settings.InteraccionExterna);
				viewModel.ModoFormulario = ko.observable(null);
			}

			self.CapaCargando = {
				Mostrar: utils.Cargando.Mostrar,
				Ocultar: utils.Cargando.Ocultar
			}

			self.Select = function (viewModel, registro) {
				if (typeof (viewModel.InicioSelect) !== 'undefined') { viewModel.InicioSelect(registro); }

				self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
				viewModel.CargandoPartial = true;
				if (viewModel.settings.Modo == ModoInicioModulo.PopUp) {
					popup.AbrirDialogo(viewModel.settings.IdModulo + 'PanelFormulario', 1000, 600, 'Editar...', function () { self.CerrarPopup(viewModel) });
				} else {
					$(viewModel.settings.Contenedor + ' .panelformulario').css('display', 'block');
				}
				viewModel.ModoFormulario('Edicion')
				viewModel.MostrarFormulario(true);
				GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(viewModel.Registro, registro, {
					Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
					PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
					PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
					MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
					RespuestaPeticionCorrecta: function (observable) {
						viewModel.CargandoPartial = false;
						var _camposDeshabilitados = viewModel.CamposHabilitadosEdicion;
						// OLL: Es correcto pasar el observable o debo pasarle el viewModel.Filtro()?
						// TODO: Hacer que sea posible ponerle datos por defecto que se passan por parámetro
						//if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltro(viewModel.FiltroFijado(), observable, _camposDeshabilitados); }
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
			};

			self.New = function (viewModel, modelo, datosPorDefecto) {
				if (typeof (viewModel.settings.Modelo) === 'undefined') { viewModel.settings.Modelo = modelo; }
				if (typeof (viewModel.settings.DatosPorDefecto) === 'undefined') { viewModel.settings.DatosPorDefecto = datosPorDefecto; }

				if (viewModel.settings.PermitirCrear) {
					if (typeof (viewModel.InicioNew) !== 'undefined') { viewModel.InicioNew(modelo, datosPorDefecto); }

					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.CargandoPartial = true;
					// OLL: Pensar si iría bien configurar un settings de dialogo o no... Así sería más versátil
					if (viewModel.settings.Modo == ModoInicioModulo.PopUp) {
						popup.AbrirDialogo(viewModel.settings.IdModulo + 'PanelFormulario', 1000, 600, 'Nueva...', function () { self.CerrarPopup(viewModel) });
					} else {
						$(viewModel.settings.Contenedor + ' .panelformulario').css('display', 'block');
					}
					viewModel.MostrarFormulario(true);
					var _datosPorDefecto = { IdMarca: viewModel.settings.IdMarca };
					if (typeof (viewModel.settings.DatosPorDefecto) !== 'undefined') { $.extend(_datosPorDefecto, viewModel.settings.DatosPorDefecto) }
					var _camposDeshabilitados = viewModel.CamposHabilitadosInsercion;
					// TODO: Hacer que sea posible ponerle datos por defecto que se passan por parámetro
					//if (typeof (viewModel.FiltroFijado() !== 'undefined')) { self.AplicarFiltro(viewModel.FiltroFijado(), _datosPorDefecto, _camposDeshabilitados); }
					viewModel.MostrarElemento(viewModel.CamposVisiblesInsercion);
					viewModel.HabilitarElemento(_camposDeshabilitados);
					viewModel.Registro(new viewModel.settings.Modelo(_datosPorDefecto, viewModel.TraduccionCampos));
					viewModel.CargandoPartial = false;
					viewModel.VolverAlListadoAlGuardar = viewModel.settings.VolverAListadoAlInsertar;
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando');
					viewModel.ModoFormulario('Insercion');
					self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			};

			self.Cancel = function (viewModel) {
				popup.CerrarDialogo(viewModel.settings.IdModulo + 'PanelFormulario', function () { self.CerrarPopup(viewModel) });
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
								if (viewModel.settings.Modo == ModoInicioModulo.PopUp || viewModel.settings.Modo == ModoInicioModulo.Buscador) {
									popup.CerrarDialogo(viewModel.settings.IdModulo + 'PanelFormulario', function () { self.CerrarPopup(viewModel) });
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
					GlobalControllers[viewModel.Entidad + 'Controller'].Update(viewModel.Registro, registro, _opciones);
				}
			}

			self.Delete = function (viewModel, registro, pedirConfirmacion) {
				if (viewModel.settings.PermitirBorrar) {
					self.CapaCargando.Mostrar(viewModel.settings.IdPartial + 'ContenedorCargando');
					var _opciones = {
						Parameters: (viewModel.settings.Multiidioma ? { Cultura: viewModel.settings.Cultura } : {}),
						PrellamadaApi: function () { viewModel.CargandoFormulario(true); },
						PostllamadaApi: function () { viewModel.CargandoFormulario(false); },
						MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
						RespuestaPeticionCorrecta: function (observable) {
							GlobalControllers[viewModel.Entidad + 'Controller'].Delete(observable, observable(), {
								PrellamadaApi: function () { viewModel.Cargando(true); },
								PostllamadaApi: function () { viewModel.Cargando(false); },
								MostrarMensaje: function (error, tipo) { viewModel.settings.MostrarMensaje('#' + viewModel.settings.ErrorContainer, error, tipo); },
								RespuestaPeticionCorrecta: function (observable, registro) { viewModel.Refrescar(viewModel); },
								PedirConfirmacion: pedirConfirmacion
							});
						},
						PeticionFinalizada: function (observable) { self.CapaCargando.Ocultar(viewModel.settings.IdPartial + 'ContenedorCargando'); }
					};
					if (typeof (viewModel.MetodoExtensionDelete) !== 'undefined') { _opciones.Action = viewModel.MetodoExtensionDelete; }
					GlobalControllers[viewModel.Entidad + 'Controller'].GetPorId(viewModel.Registro, registro, _opciones);
				}
			}

			self.Inicializar = function (viewModel, settings, modelo, datosPorDefecto) {
				if (typeof (settings.MetodosRespuesta) !== 'undefined' && settings.MetodosRespuesta != null) {
					if (typeof (settings.MetodosRespuesta.AntesInsertar) === 'function') { viewModel.MetodosRespuesta.AntesInsertar = settings.MetodosRespuesta.AntesInsertar; }
					if (typeof (settings.MetodosRespuesta.Insertado) === 'function') { viewModel.MetodosRespuesta.Insertado = settings.MetodosRespuesta.Insertado; }
					if (typeof (settings.MetodosRespuesta.AntesActualizar) === 'function') { viewModel.MetodosRespuesta.AntesActualizar = settings.MetodosRespuesta.AntesActualizar; }
					if (typeof (settings.MetodosRespuesta.Actualizado) === 'function') { viewModel.MetodosRespuesta.Actualizado = settings.MetodosRespuesta.Actualizado; }
					if (typeof (settings.MetodosRespuesta.RegistrosCargados) === 'function') { viewModel.MetodosRespuesta.RegistrosCargados = settings.MetodosRespuesta.RegistrosCargados; }
					if (typeof (settings.MetodosRespuesta.Seleccionado) === 'function') { viewModel.MetodosRespuesta.Seleccionado = settings.MetodosRespuesta.Seleccionado; }
				}
				viewModel.settings.Modo = (typeof (settings.Modo) !== 'undefined' && settings.Modo != null ? settings.Modo : ModoInicioModulo.Defecto);
				// TODO: popup debería ser un parámetro del settings que se le pase a la partial de formulario, no un modo
				if (viewModel.settings.Modo == ModoInicioModulo.Defecto || viewModel.settings.Modo == ModoInicioModulo.PopUp) {
					viewModel.New(viewModel, modelo, datosPorDefecto);
				} else if (viewModel.settings.Modo == ModoInicioModulo.Edicion) {
					viewModel.Select(new modelo(settings.Filtro, viewModel.TraduccionCampos));
				}
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