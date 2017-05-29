if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes de cargar dependencias'); }
define(['dojo/order!WebAPI/jquery.extensions', 'dojo/order!jquery', 'knockout', './Core.Utils'], function (jqueryExtensions, $, ko, utils) {
	try {
		function BaseSystem() {
			if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Inicio clase'); }
			var self = this;

			self.init = function ($, ko, system, element) {
				if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Ejecutando init ' + system.settings.IdModulo); }
				system.settings.MostrarMensaje = (typeof (system.settings.MostrarMensaje) !== 'undefined' ? system.settings.MostrarMensaje : utils.MostrarMensaje);
				var containerElement = system.settings.Container = element;

				if ($(system.settings.Contenedor + ' .contenedorListado').length > 0) {
					$(system.settings.Contenedor + ' .contenedorListado').css('display', 'block');
					$(system.settings.Contenedor + ' .contenedorListado').expandToParent();
					$(system.settings.Contenedor + ' .contenedorListado').doubleScroll();
				}

				require(['moment/moment-with-locales.min'], function (moment) {
					try {
						moment.locale(system.settings.Cultura);
					} catch (excepcion) {
						console.log(excepcion);
					}
				});

				if ($(system.settings.Contenedor + ' .tabs').length > 0) {
					$(system.settings.Contenedor + ' .tabs').tabs({
						beforeActivate: function (event, ui) {
							// OLL: Solo tiene sentido para cuando hago refresh. Valorarlo, porque si estamos al final y queremos seguir trabajando al final, nos lleva al principio
							//if ($(window).scrollTop() > 0) { $('html, body').animate({ scrollTop: 0 }, 1500); }

							if (typeof (ui.newPanel.attr('id')) === 'undefined') { event.preventDefault(); }
							// OLL: Elimino este punto de aqui y lo pongo en el ActivarBloque. Tiene más sentido aunque no recuerdo si habría alguna razón para ponerlo en el beforeActivate
							//else if (typeof (system.ViewModel) !== 'undefined') {
							//	system.ViewModel.PestanyaVisible(ui.newPanel.attr('id'));
							//} else {
							//	console.log('ERROR!! No hay viewmodel');
							//}
						},
						activate: function (event, ui) {
							if (ui.newPanel.attr('id') !== 'undefined') { system.ViewModel.ActivarBloque(ui.newPanel.attr('id')); }
						},
						active: (system.settings.BusquedaAutomatica ? 1 : 0),
					}).addClass("ui-tabs-vertical ui-helper-clearfix");
				}

				if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Esperando viewmodel ' + system.settings.IdModulo); }
				require(['partials/' + system.settings.IdModulo + 'ViewModel'], function (viewModel) {
					//try {
					if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - viewmodel cargado ' + system.settings.IdModulo); }
					system.ViewModel = new viewModel(system.settings);
					GlobalViewModels[system.settings.IdPartial + 'ViewModel'] = system.ViewModel;

					// Cargamos los recursos
					self.ObtenerRecursos(system);

					//if (typeof (GlobalViewModels) != 'undefined' && (typeof (GlobalViewModels[system.settings.IdModulo + 'ViewModel']) == 'undefined' || GlobalViewModels[system.settings.IdModulo + 'ViewModel'] == null)) { GlobalViewModels[system.settings.IdModulo + 'ViewModel'] = system.ViewModel; }
					$(containerElement).css('visibility', 'hidden');
					$(containerElement).css('display', 'block');
					// OLL: Para eliminar los bindings antes de aplicarlos. Guardo la instrucción por si algún día la necesito.
					//if (ko.dataFor($(system.settings.Contenedor)[0].children[0]).__proto__ == system.ViewModel.__proto__) { ko.cleanNode($(system.settings.Contenedor)[0].children[0]); }
					if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes de applybindings ' + system.settings.IdModulo); }
					ko.applyBindingsToDescendants(system.ViewModel, $(system.settings.Contenedor)[0]);
					if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Después de applybindings ' + system.settings.IdModulo); }

					if ($(system.settings.Contenedor + ' .contenedorListado').length > 0) {
						//if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes incluir selector columnas ' + system.settings.IdModulo); }
						//system.IncluirSelectorColumnas(system.ViewModel);
						//if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Despues incluir selector columnas ' + system.settings.IdModulo); }

						// OLL: Optimizar para que no se llame tantas veces
						//$(containerElement).scrollPagination({
						//	'scrollTarget': $(window),
						//	'heightOffset': 10,
						//	'callback': function () {
						//		if (system.ViewModel.PestanyaVisible() == 'listado') { system.ViewModel.Get(); }
						//	}
						//});

						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes cargar Core.FixedScroll ' + system.settings.IdModulo); }
						require(['Globales/Core.FixedScroll'], function () {
							try {
								if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem:  Después cargar Core.FixedScroll - Fijando header' + system.settings.IdModulo); }
								$(system.settings.Contenedor + ' table.scroll').fix({
									System: system,
									CalcularPosicionSuperior: system.settings.ObtenerMargenSuperiorScroll,
									CrearElementoFijo: function (elementoBase) {
										// inluyo el scroll en el header y hago que sea del mismo tamaño que la grid
										// OLL: traspaso el Scroll a DespuestCrearElementoFijo, ya que el ko.cleanNode(elementoFijo[0]) lo elimina. Borrar si no afecta a nada más.
										//var _contenedorListado = elementoBase.parent('.contenedorListado');
										//var _divConBarraScroll = elementoBase.clone(true, true).wrap('<div class="barraScroll" style="overflow-x: auto; border: 0px"></div>').parent().css('width', _contenedorListado.css('width'));
										//_contenedorListado.scroll(function () { _divConBarraScroll.scrollLeft(_contenedorListado.scrollLeft()); });
										//_divConBarraScroll.scroll(function () { _contenedorListado.scrollLeft(_divConBarraScroll.scrollLeft()); });
										return elementoBase.clone(true, true).wrap('<div class="barraScroll" style="overflow-x: auto; border: 0px"></div>').parent().css('width', elementoBase.parent('.contenedorListado').css('width'));
									},
									DespuesCrearElementoFijo: function (elementoBase, elementoFijo) {
										// tengo que eliminar el scroll de la table interior
										elementoFijo.find("tbody").remove().end().find("tfoot").remove().end().children().removeClass('scroll').css('border', '0px');
										//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas elementoFijo.find('.sc_container').remove();
										ko.cleanNode(elementoFijo[0]);
										ko.applyBindings(system.ViewModel, elementoFijo[0]);
										//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas system.IncluirSelectorColumnas(system.ViewModel, elementoFijo);
										//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas elementoFijo.find('.sc_menu').css('display', elementoBase.find('.sc_menu').css('display'));
										elementoBase.trigger('refrescarFix');
										// OLL: En DNN5 no necesito realizar este punto.
										//elementoFijo.find('.dnnCheckbox').remove();
										//elementoFijo.find('input[type="checkbox"]').data("checkBoxWrapped", false).dnnCheckbox();
										var _contenedorListado = elementoBase.parent('.contenedorListado');
										_contenedorListado.scroll(function () { elementoFijo.scrollLeft(_contenedorListado.scrollLeft()); });
										elementoFijo.scroll(function () { _contenedorListado.scrollLeft(elementoFijo.scrollLeft()); });
										elementoFijo.show();
										elementoFijo.scrollLeft(_contenedorListado.scrollLeft());
									},
									CambiarTamanyoElementoFijo: function (elementoBase, elementoFijo) {
										var _table = elementoFijo.find("table")
										_table.css('width', (parseInt(elementoBase.width()) || 0) + (parseInt(elementoBase.css('padding-left')) || 0) + (parseInt(elementoBase.css('padding-right')) || 0) + (parseInt(elementoBase.css('border-left')) || 0) + (parseInt(elementoBase.css('border-right')) || 0) + 'px');
										elementoFijo.find("th").each(function (index) {
											// OLL: En DNN5 he tenido que revisar el cálculo.
											//$(this).css("width", elementoBase.find("th").eq(index).width() + "px");
											$(this).css("width", (parseInt(elementoBase.find("th").eq(index).width()) || 0) + parseInt((elementoBase.find("th").eq(index).css('padding-left') || 0)) + parseInt((elementoBase.find("th").eq(index).css('padding-right') || 0)) + parseInt((elementoBase.find("th").eq(index).css('border-left') || 0)) + parseInt((elementoBase.find("th").eq(index).css('border-right') || 0)) + 'px');
										});
									}
								});
							} catch (excepcion) {
								console.log(excepcion);
							}
						});
					}

					if ($(system.settings.Contenedor + ' .tabs').length > 0) {
						if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Antes cargar Core.FixedScroll 2 ' + system.settings.IdModulo); }
						require(['Globales/Core.FixedScroll'], function () {
							try {
								if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem:  Despuçes cargar Core.FixedScroll - Fijando tabs' + system.settings.IdModulo); }
								$(system.settings.Contenedor + ' .ui-tabs-nav').fix({
									System: system,
									CalcularPosicionSuperior: system.settings.ObtenerMargenSuperiorScroll,
									ObtenerElementoAScrollar: function (elementoBase) {
										return elementoBase.parents(system.settings.Contenedor + ' .tabs').find('.ui-tabs-panel:visible');
									},
									AntesEliminarElementoFijo: function (elementoBase, elementoFijo) {
										elementoBase.parents(system.settings.Contenedor + ' .tabs').find('.ui-tabs-panel').css('margin-left', '');
										elementoBase.parents(system.settings.Contenedor + ' .tabs').find('.ui-tabs-panel').css('z-index', '');
										elementoBase.css('visibility', 'visible');
									},
									DespuesCrearElementoFijo: function (elementoBase, elementoFijo) {
										elementoFijo.css('z-index', '0');
										// OLL: Comnentado en DNN5. 
										//elementoBase.parents(system.settings.Contenedor + ' .tabs').find('.ui-tabs-panel:visible').css('z-index', '1').css('margin-left', '31px');
										ko.cleanNode(elementoFijo[0]);
										ko.applyBindings(system.ViewModel, elementoFijo[0]);
										elementoBase.css('visibility', 'hidden');
									}
								});
							} catch (excepcion) {
								console.log(excepcion);
							}
						});
					}
					$(containerElement).css('visibility', 'visible');

					if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Fin. Módulo visible.' + system.settings.IdModulo); }
					//} catch (excepcion) {
					//	console.log(excepcion);
					//}
				});
				return true;
			};

			//OLL: Eliminado por el nuevo sistema de MostrarOcultarColumnas
			//self.IncluirSelectorColumnas = function ($, ko, system, viewModel, containerElement) {
			//	var _selectorIncluido = false;
			//	var _grids = (typeof (containerElement) !== 'undefined' ? $(containerElement) : $('#contenedorListado' + system.settings.IdModulo + ' .dnnGrid'));
			//	_grids.each(function () {
			//		var _grid = $(this);
			//		$($(this).find('th').get().reverse()).each(function () {
			//			if ($(this).css('display') != 'none') {
			//				if (!_selectorIncluido) {
			//					if (!$(this).hasClass('selectorColumnas')) { $(this).addClass('selectorColumnas'); }
			//					var _container = $(this).parents('.dnnGrid').find('.sc_container');
			//					if (_container.length == 0) {
			//						// OLL: en versión DNN5 tenemos que poner la clase normalCheckBox porque no se visualiza la imagen que pone DNN
			//						var _ui = $('<div class="sc_container"><img class="sc_selector" src="' + system.settings.ApplicationPath + 'Images/Extension/Down.png" /><div class="sc_menu" style="display: none" data-bind="foreach: Columnas"><div><input type="checkbox" data-bind="checked: Visible, click: $parent.PosicionarSelector" class="normalCheckBox"><span data-bind="html: Literal"></span</div></div></div>');
			//						$(this).append(_ui);
			//						$(this).find('.sc_selector').click(function () { $(this).next('.sc_menu').toggle(); });
			//						ko.applyBindings(viewModel, _ui[0])
			//					} else {
			//						_container.appendTo($(this));
			//					}
			//					_selectorIncluido = true;
			//				}
			//			} else { $(this).removeClass('selectorColumnas'); }
			//		});
			//	});
			//}

			self.GuardarContextoEnRepositorio = function (system, contexto) {
				localStorage[system.settings.Usuario + '_' + system.settings.Contenedor] = ko.toJSON(contexto);
			}

			self.ObtenerContextoDeRepositorio = function (system) {
				return ko.utils.parseJson(localStorage[system.settings.Usuario + '_' + system.settings.Contenedor]) || {};
			}

			// OLL: Estas clases deberían estar en otro js
			self.GuardarColumnasSeleccionadasEnRepositorio = function (system, columnas) {
				system.Repositorio.Columnas = columnas;
				self.GuardarContextoEnRepositorio(system, system.Repositorio);
			}

			self.ObtenerColumnasSeleccionadasDeRepositorio = function (system) {
				system.Repositorio = self.ObtenerContextoDeRepositorio(system);
				_columnas = [];
				// Mirar undefined
				if (system.Repositorio != null && system.Repositorio.Columnas != null) {
					system.Repositorio.Columnas.forEach(function (columna) {
						_columnas.push({ Nombre: columna.Nombre, Literal: columna.Literal, Visible: ko.observable(columna.Visible) })
					});
				}

				return (_columnas.length > 0 ? _columnas : null);
			}

			self.GuardarRegistrosFijosEnRepositorio = function (system, registros) {
				system.Repositorio.RegistrosFijos = registros;
				self.GuardarContextoEnRepositorio(system, system.Repositorio);
			}

			self.ObtenerRegistrosFijosDeRepositorio = function (system) {
				system.Repositorio = self.ObtenerContextoDeRepositorio(system);
				return (typeof (system.Repositorio.RegistrosFijos) !== 'undefined' && system.Repositorio.RegistrosFijos.length > 0 ? system.Repositorio.RegistrosFijos : []);
			}

			self.GuardarFiltroEnRepositorio = function (system, filtro) {
				system.Repositorio.Filtro = filtro;
				self.GuardarContextoEnRepositorio(system, system.Repositorio);
			}

			self.ObtenerFiltroDeRepositorio = function (system) {
				system.Repositorio = self.ObtenerContextoDeRepositorio(system);
				return (typeof (system.Repositorio.Filtro) !== 'undefined' ? system.Repositorio.Filtro : null);
			}

			self.ObtenerRecursos = function (system) {
				require(['dojo/text!' + utils.RevisarUrl(system.RutaRecursos + '&Cultura=' + system.settings.Cultura)], function (recursos) {
					try {
						var _Recursos;
						eval('_Recursos = ' + recursos);
						system.settings.Recursos = _Recursos;
						system.settings.MensajeCargandoRegistros = _Recursos['CargandoRegistros_Text'];
						system.settings.MensajeCargandoRegistro = _Recursos['CargandoRegistro_Text'];
						system.settings.MensajeRegistroGuardado = _Recursos['RegistroGuardado_Text'];
						system.settings.MensajeRegistroEliminado = _Recursos['RegistroEliminado_Text'];
						system.settings.MensajeError = _Recursos['MensajeError_Text'];
						system.settings.MensajeEstaSeguroBorrar = _Recursos['MensajeEstaSeguroBorrar_Text'];
						system.settings.MensajeEstaSeguroBorrarSeleccionados = _Recursos['MensajeEstaSeguroBorrarSeleccionados_Text'];
						system.settings.MensajeEstaSeguroCopiarSeleccionados = _Recursos['MensajeEstaSeguroCopiarSeleccionados_Text'];
						system.settings.MensajeEstaSeguroEditarSeleccionados = _Recursos['MensajeEstaSeguroEditarSeleccionados_Text'];
						system.settings.MensajeRespuestaServicioVacia = _Recursos['MensajeRespuestaServicioVacia_Text'];
						system.settings.MensajeErrorValidacion = _Recursos['MensajeErrorValidacion_Text'];
						system.ViewModel.TraduccionCampos.pushAll(_Recursos);
					} catch (excepcion) {
						console.log(excepcion);
					}
				});
			}
		}
		if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - BaseSystem: Fin clase '); }
		return new BaseSystem();
	} catch (excepcion) {
		console.log(excepcion);
	}
});