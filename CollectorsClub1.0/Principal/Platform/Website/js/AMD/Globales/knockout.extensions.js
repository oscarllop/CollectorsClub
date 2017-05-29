// Array para almacenar los ViewModels que se van usando
var GlobalControllers = new Array();
var GlobalViewModels = new Array();

define(['ParametrosGlobales', 'knockout', 'Globales/jshashtable-2.1', 'Globales/partials'], function (parametrosGlobales, ko, hastable, partials) {
	window.ParsedModels = new Hashtable();

	ko.isObservableArray = function (object) {
		return (ko.isObservable(object) && object.remove);
	}

	ko.lazyObservable = function (callback, context) {
		var value = ko.observable();
		var args = [];
		for (var i = 2; i < arguments.length; i++) {
			args.push(arguments.callee.arguments[i]);
		}
		return lazyComputed(callback, value, context, args);
	};

	ko.lazyObservableArray = function (callback, context) {
		var value = ko.observableArray();

		var args = [];
		for (var i = 2; i < arguments.length; i++) { args.push(arguments.callee.arguments[i]); }
		var result = lazyComputed(callback, value, context, args);

		//add underlying array methods onto computed observable
		ko.utils.arrayForEach(["remove", "removeAll", "destroy", "destroyAll", "indexOf", "replace", "pop", "push", "reverse", "shift", "sort", "splice", "unshift", "slice"], function (methodName) {
			result[methodName] = function () {
				value[methodName].apply(value, arguments);
			};
		});

		return result;
	};

	function lazyComputed(callback, value, context, args) {
		var result;
		result = ko.computed({
			read: function () {
				//if it has not been loaded, execute the supplied function
				if (!result.loaded()) {
					args.unshift(result);
					callback.apply(context, args);
				}
				//always return the current value
				return value();
			},
			write: function (newValue) {
				//indicate that the value is now loaded and set it
				result.loaded(true);
				value(newValue);
			},
			deferEvaluation: true  //do not evaluate immediately when created
		});

		//expose the current state, which can be bound against
		result.loaded = ko.observable();

		//load it again
		result.refresh = function () {
			result.loaded(false);
		};

		return result;
	}

	/*
	ko.bindingHandlers.customoptions = {
		//init: function (element, valueAccessor, allBindingsAccessor, context) {
		//	var options = valueAccessor();
		//	var newValueAccessor = function () {
		//		return function () {
		//			options.action.apply(context, options.params);
		//		};
		//	};
		//	ko.bindingHandlers.click.init(element, newValueAccessor, allBindingsAccessor, context);
		//}
		update: function(element, valueAccessor, allBindingsAccessor, viewModel) {
			ko.bindingHandlers.options.update(element, valueAccessor, allBindingsAccessor, viewModel);
		}
	};
	*/

	ko.bindingHandlers.ckEditor = {
		init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
			var txtBoxID = $(element).attr("id");
			var options = allBindingsAccessor().richTextOptions || {};
			ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
				if (CKEDITOR.instances[txtBoxID]) { CKEDITOR.remove(CKEDITOR.instances[txtBoxID]); }
			});

			$(element).ckeditor(options);

			// wire up the blur event to ensure our observable is properly updated
			CKEDITOR.instances[txtBoxID].focusManager.blur = function () {
				var observable = valueAccessor();
				observable($(element).val());
			};
		},
		update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
			var val = ko.utils.unwrapObservable(valueAccessor());
			$(element).val(val);
		}
	}

	ko.bindingHandlers.celdaAmpliable = {
		init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
			ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
				//console.log('OLL: Dispose de celdaAmpliable ejecutado. ¿Tengo que hacer algo aquí?');
			});

			$(element).addClass('contenedorCeldaAmpliable');
			var zoomIcom = $('<img src="' + parametrosGlobales.ApplicationPath + 'Images/Extension/zoomin.png" class="ca_ampliar" />').click(function (event) {
				var src = $(this).attr('src');
				if (src.indexOf('zoomin') > 0) {
					$(this).next().addClass('ca_ampliado');
					src = src.replace('zoomin', 'zoomout');
				} else {
					$(this).next().removeClass('ca_ampliado');
					src = src.replace('zoomout', 'zoomin');
				}
				$(this).attr('src', src);
				return false;
			});
			$(element).append(zoomIcom).append('<div class="ca_contenido" />');
		},
		update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
			var val = ko.utils.unwrapObservable(valueAccessor());
			$(element).children(':last-child').html(val);
		}
	}

	/*
	ko.bindingHandlers.stopBinding = {
		init: function () {
			return { controlsDescendantBindings: true };
		}
	};

	ko.virtualElements.allowedBindings.stopBinding = true;
	*/

	/*
	ko.bindingHandlers.partial = {
		init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
			return { controlsDescendantBindings: true };
		},
		update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
			if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Iniciando el update ' + allBindingsAccessor().IdModulo); }
			if (typeof (GlobalViewModels) !== 'undefined' && typeof (GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel']) !== 'undefined' && GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel'] != null) {
				try {
					typeof ($(element).find('.contenedorNuevoFormatoListadoFormulario')[0].children[0]);
				} catch (excepcion) {
				}
				if (typeof ($(element).find('.contenedorNuevoFormatoListadoFormulario')[0].children[0]) !== 'undefined') {
					var _vm = ko.dataFor($(element).find('.contenedorNuevoFormatoListadoFormulario')[0].children[0]);
					if (typeof (_vm) === 'undefined' || _vm !== GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel']) {
						_vm = GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel'];
						$(element).find('.validationMessage').remove();
						if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Antes applybindings ' + allBindingsAccessor().IdModulo); }
						ko.applyBindingsToDescendants(_vm, $(element).find('.contenedorNuevoFormatoListadoFormulario')[0]);
						if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Después applybindings ' + allBindingsAccessor().IdModulo); }
					}
					var _parametros = ko.toJS(valueAccessor());
					var _filtroFijado = (typeof (_vm.FiltroFijado()) !== 'undefined' ? ko.toJS(_vm.FiltroFijado()) : {});
					var _esNulo = true, _nuevoFiltro = false;
					for (var _propiedad in _parametros.Filtro) {
						if (_parametros.Filtro.hasOwnProperty(_propiedad)) {
							if (_parametros.Filtro[_propiedad] != 0 && _parametros.Filtro[_propiedad] != '') {
								_esNulo = false;
							}
							if (_parametros.Filtro[_propiedad] != _filtroFijado[_propiedad]) {
								_nuevoFiltro = true;
							}
						}
					}
					if (!_esNulo && (bindingContext.$parentContext.$data.CargandoPartial || _nuevoFiltro)) {
						if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Antes applybindings ' + allBindingsAccessor().IdModulo); }
						_vm.Inicializar(_parametros);
						if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Después applybindings ' + allBindingsAccessor().IdModulo); }

						$('#' + allBindingsAccessor().IdModulo + 'tabs').tabs({
							beforeActivate: function (event, ui) {
								if ($(window).scrollTop() > 0) { $('html, body').animate({ scrollTop: 0 }, 1500); }

								if (typeof (ui.newPanel.attr('id')) === 'undefined') { event.preventDefault(); }
								else { _vm.PestanyaVisible(ui.newPanel.attr('id')); }
							},
							active: 1
						}).addClass("ui-tabs-vertical ui-helper-clearfix");
						//$(element).find("table.scroll").trigger('refrescarFix');
						//$(element).find(".ui-tabs-nav").trigger('refrescarFix');
						//$(element).find('.contenedorListado').css('display', 'block');
						$(element).find('.contenedorListado').expandToParent();
						$(element).find('.contenedorListado').doubleScroll();
					}
				}
			}
			if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Partials: Fin del update ' + allBindingsAccessor().IdModulo); }
		}
	}
	*/

	ko.bindingHandlers.partial = {
		init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
			return { controlsDescendantBindings: true };
		},
		update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
			//try {
			var _parametros = valueAccessor();

			// OLL: Para que funcione el nuevo, traspaso los null a 0
			for (var _propiedad in _parametros.Filtro) {
				if (_parametros.Filtro.hasOwnProperty(_propiedad) && ko.isObservable(_parametros.Filtro[_propiedad])) {
					// Utilizamos la siguiente línea para que knockout cree una dependencia con el parámetro, y así cuando el parámetro cambie, se regenere la partial.
					ko.utils.unwrapObservable(_parametros.Filtro[_propiedad]);
				}
			};

			if ($(element).parent().is(':visible') && !$(element).is(':visible')) { $(element).css('display', 'block'); }
			if ($(element).is(':visible')) {
				//console.log(element.id + ': Actualizando partial...');
				var _parametros = ko.toJS(_parametros);
				for (var _propiedad in _parametros.Filtro) {
					if (_parametros.Filtro.hasOwnProperty(_propiedad)) {
						//console.log(element.id + ': Propiedad ' + _propiedad + ': ' + _parametros.Filtro[_propiedad]);
						if (_parametros.Filtro[_propiedad] == null) { _parametros.Filtro[_propiedad] = 0; }
					}
				};
				_parametros = $.extend(ko.toJS(_parametros), parametrosGlobales);

				//if (eval('typeof(' + _parametros.IdPartial + ')') === 'undefined') {

				ko.ignoreDependencies(partials.DescargarEIniciarPartial, viewModel, [{ Url: parametrosGlobales.RutaPartials + '/' + _parametros.IdModulo + 'View.html', IdPartial: _parametros.IdPartial, Parametros: _parametros, ParametrosGlobales: parametrosGlobales }]);
				//partials.DescargarEIniciarPartial({ Url: parametrosGlobales.RutaPartials + '/' + _parametros.IdModulo + 'View.html', IdPartial: _parametros.IdPartial, Parametros: _parametros, ParametrosGlobales: parametrosGlobales });
				//} else {
				//	partials.ActualizarPartial(element, { IdPartial: _parametros.IdPartial, Parametros: _parametros, ParametrosGlobales: parametrosGlobales });
				//}
			} else {
				//console.log(element.id + ': Actualizando partial. La partial no se actualizará porque no está visible.');
			}
			//} catch (exception) {
			//	console.log(exception);
			//}
		}
	}

	function RevisarParametros(parametros) {
		// TODO:
		for (var _propiedad in parametros.Filtro) {
			if (parametros.Filtro.hasOwnProperty(_propiedad) && ko.isObservable(parametros.Filtro[_propiedad])) {
				// Utilizamos la siguiente línea para que knockout cree una dependencia con el parámetro, y así cuando el parámetro cambie, se regenere la partial.
				ko.utils.unwrapObservable(parametros.Filtro[_propiedad]);
			}
		};

		for (var _propiedad in parametros.DatosPorDefecto) {
			if (parametros.DatosPorDefecto.hasOwnProperty(_propiedad) && ko.isObservable(parametros.DatosPorDefecto[_propiedad])) {
				// Utilizamos la siguiente línea para que knockout cree una dependencia con el parámetro, y así cuando el parámetro cambie, se regenere la partial.
				ko.utils.unwrapObservable(parametros.DatosPorDefecto[_propiedad]);
			}
		};

		// TODO: OLL: Eliminar esta línea para que funcione con Observables
		//var parametros = ko.toJS(parametros);
		// OLL: Para que funcione el nuevo, traspaso los null a 0
		for (var _propiedad in parametros.Filtro) {
			if (parametros.Filtro.hasOwnProperty(_propiedad)) {
				//console.log(element.id + ': Propiedad ' + _propiedad + ': ' + _parametros.Filtro[_propiedad]);
				// TODO: OLL: No deberíamos cambiar este dato. Tendría que llegar correctamente. Mientras esté el ko.toJS no habrá observables.
				if (ko.isObservable(parametros.Filtro[_propiedad])) {
					if (parametros.Filtro[_propiedad]() == null) { parametros.Filtro[_propiedad](0); }
				} else {
					if (parametros.Filtro[_propiedad] == null) { parametros.Filtro[_propiedad] = 0; }
				}
			}
		};
		parametros = $.extend(parametros, parametrosGlobales);

		return parametros
	}

	ko.bindingHandlers.partialbieniniciada = {
		init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var _parametros = RevisarParametros(valueAccessor());

			if ($(element).parent().is(':visible') && !$(element).is(':visible')) { $(element).css('display', 'block'); }
			if ($(element).is(':visible')) {
				//console.log(element.id + ': Actualizando partial...');

				ko.ignoreDependencies(partials.DescargarEIniciarPartialIniciarBinding, bindingContext.$data, [{ Url: parametrosGlobales.RutaPartials + '/' + _parametros.IdModulo + 'View.html', IdPartial: _parametros.IdPartial, Parametros: _parametros, ParametrosGlobales: parametrosGlobales }]);
			} else {
				//console.log(element.id + ': Actualizando partial. La partial no se actualizará porque no está visible.');
			}

			return { controlsDescendantBindings: true };
		},
		update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var _parametros = RevisarParametros(valueAccessor());
			if ($(element).is(':visible')) {
				ko.ignoreDependencies(partials.ActualizarPartialIniciarBinding, bindingContext.$data, [{ Url: parametrosGlobales.RutaPartials + '/' + _parametros.IdModulo + 'View.html', IdPartial: _parametros.IdPartial, Parametros: _parametros, ParametrosGlobales: parametrosGlobales }]);
			}
		}
	}

	ko.bindingHandlers.nullableBooleanValue = {
		init: function (element, valueAccessor, allBindingsAccessor) {
			var observable = valueAccessor(),
					interceptor = ko.computed({
						read: function () {
							var result = null;
							if (observable() === true) {
								result = "true";
							} else if (observable() === false) {
								result = "false";
							} else { // Default is null, which represents no user selection
								result = "null";
							}
							return result;
						},
						write: function (newValue) {
							var result = null;
							if (newValue === "true") {
								result = true;
							} else if (newValue === "false") {
								result = false;
							} else { // Default is null, which represents no user selection
								result = null;
							}
							observable(result);
						}
					});

			ko.applyBindingsToNode(element, { value: interceptor });
		}
	};

	//ko.onDemandObservable = function(callback, target) {
	//  var _value = ko.observable();  //private observable

	//  var result = ko.dependentObservable({
	//    read: function() {
	//      //if it has not been loaded, execute the supplied function
	//      if (!result.loaded()) {
	//          callback.call(target);
	//      }
	//      //always return the current value
	//      return _value();
	//    },
	//    write: function(newValue) {
	//      //indicate that the value is now loaded and set it
	//      result.loaded(true);
	//      _value(newValue);
	//    },
	//    deferEvaluation: true  //do not evaluate immediately when created
	//  });

	//  //expose the current state, which can be bound against
	//  result.loaded = ko.observable();  
	//  //load it again
	//  result.refresh = function() {
	//    result.loaded(false);
	//  };

	//  return result;
	//};

	ko.bindingHandlers.inputmask = {
		init: function (element, valueAccessor, allBindingsAccessor) {
			var mask = valueAccessor();
			var observable = mask.value;
			if (ko.isObservable(observable)) {
				$(element).on('focusout change', function () {
					if ($(element).inputmask('isComplete')) {
						observable($(element).val());
					} else {
						observable(null);
					}
				});
			}
			if (mask && mask.mask == 'Regex') {
				$(element).inputmask('Regex', { regex: $(element).attr('pattern') });
			} else if (mask && mask.mask == 'phone') {
				$(element).inputmask("phone", {
					url: window.ParametrosGlobales.ApplicationPath + "js/AMD/Plugins/inputmask/phone-codes/phone-codes.json" + (typeof (versionScripts) !== 'undefined' ? '?cdv=' + versionScripts : ''),
					onKeyValidation: function () {
						$(this).parent().find('.input-group-addon:last').html($(this).inputmask("getmetadata")["cd"])
						$(this).attr('pattern', $(this).inputmask("getmetadata")["mask"].replace(/#/g, '\\d'));
					},
					oncleared: function () {
						$(this).parent().find('.input-group-addon:last').html('');
					}
				});
			} else {
				$(element).inputmask(mask);
			}
		},
		update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var mask = valueAccessor();
			var observable = mask.value;
			if (ko.isObservable(observable)) {
				var valuetoWrite = observable();
				$(element).val(valuetoWrite);
			}
		}
	};

	//ko.bindingHandlers.enterKey = {
	//	init: function (element, valueAccessor, allBindingsAccessor, data, context) {
	//		var wrappedHandler, newValueAccessor;

	//		//wrap the handler with a check for the enter key
	//		wrappedHandler = function (data, event) {
	//			if (event.keyCode === 13) {
	//				valueAccessor().call(this, data, event);
	//			}
	//		};

	//		//create a valueAccessor with the options that we would want to pass to the event binding
	//		newValueAccessor = function () {
	//			return { keyup: wrappedHandler };
	//		};

	//		//call the real event binding's init function
	//		ko.bindingHandlers.event.init(element, newValueAccessor, allBindingsAccessor, data, context);
	//	}
	//};

	ko.bindingHandlers['validationMessageWithTemplate'] = { // individual error message, if modified or post binding
		update: function (element, valueAccessor) {
			var obsv = valueAccessor(),
				config = ko.validation.utils.getConfigOptions(element),
				val = ko.utils.unwrapObservable(obsv),
				msg = null,
				isModified = false,
				isValid = false;

			if (obsv === null || typeof obsv === 'undefined') {
				throw new Error('Cannot bind validationMessage to undefined value. data-bind expression: ' +
					element.getAttribute('data-bind'));
			}
			// OLL: evito que falle. Descubrir porque entra en este template cuando no hay validator. Entiendo que es porque en el html está el template.
			if (ko.isObservable(obsv) && typeof obsv.isModified !== 'undefined' && typeof obsv.isValid !== 'undefined') {
				if (config.messageTemplate) {
					ko.renderTemplate(config.messageTemplate, { field: obsv }, null, element, 'replaceNode');
				} else {
					isModified = obsv.isModified && obsv.isModified();
					isValid = obsv.isValid && obsv.isValid();

					var error = null;
					if (!config.messagesOnModified || isModified) {
						error = isValid ? null : obsv.error;
					}

					var isVisible = !config.messagesOnModified || isModified ? !isValid : false;
					var isCurrentlyVisible = element.style.display !== "none";

					if (config.allowHtmlMessages) {
						koUtils.setHtml(element, error);
					} else {
						ko.bindingHandlers.text.update(element, function () { return error; });
					}

					if (isCurrentlyVisible && !isVisible) {
						element.style.display = 'none';
					} else if (!isCurrentlyVisible && isVisible) {
						element.style.display = '';
					}
				}
			}
		}
	};

	ko.bindingHandlers.afterHtmlRender = {
		update: function (element, valueAccessor, allBindings) {
			// check if element has 'html' binding
			if (!allBindings().html) return;
			// get bound callback (don't care about context, it's ready-to-use ref to function)
			var callback = valueAccessor();
			// fire callback with new value of an observable bound via 'html' binding
			callback(element, allBindings().html);
		}
	}

	ko.bindingHandlers.listaOpciones = {
		init: function (element, valueAccessor, allBindings, viewModel, bindingContext) { },
		update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var _parametros = ko.unwrap(valueAccessor());
			var _listaValores = ko.unwrap(_parametros.ListaValores);
			var _listaSeleccionados = ko.unwrap(_parametros.ListaSeleccionados);
			//if (_listaValores.length > 0 && _listaSeleccionados.length > 0) { debugger; }
			$(_listaValores).each(function (indice, registro) {
				if ($.grep($(element).find('.list-group-item'), function (elementoLista) { return registro.Id == $(elementoLista).data('registro').Id; }).length == 0) {
					var _elementoLista = $('<li>' + registro.Nombre + '</li>');
					if ($.grep(_listaSeleccionados, function (valor) { return registro.Id == valor; }).length > 0) {
						_elementoLista.attr('data-checked', 'true');
					}
					$(_elementoLista).data('registro', registro);
					$(element).append(_elementoLista);
				}
			});
			$(element).find('li:not(.list-group-item)').each(function () {
				// Settings
				var $widget = $(this),
					$checkbox = $('<input type="checkbox" class="hidden" />'),
					color = ($widget.data('color') ? $widget.data('color') : "primary"),
					style = ($widget.data('style') == "button" ? "btn-" : "list-group-item-"),
					settings = {
						on: {
							icon: 'glyphicon glyphicon-check'
						},
						off: {
							icon: 'glyphicon glyphicon-unchecked'
						}
					};

				$widget.addClass('list-group-item');
				$widget.css('cursor', 'pointer')
				$widget.append($checkbox);

				// Event Handlers
				$widget.on('click', function () {
					$checkbox.prop('checked', !$checkbox.is(':checked'));
					var _registro = $(this).data('registro');
					var _valor = ko.unwrap(_registro.Id); // Pasar parámetro para indicar capos de nombre y de valor
					var _indice = ko.utils.arrayIndexOf(_listaSeleccionados, _valor);
					if (($checkbox.is(':checked')) && (_indice < 0)) {
						_listaSeleccionados.push(_valor);
					} else if ((!$checkbox.is(':checked')) && (_indice >= 0)) {
						_listaSeleccionados.splice(_indice, 1);
					}
					
					_parametros.ListaSeleccionados(_listaSeleccionados);
					_parametros.click();
					$checkbox.triggerHandler('change');
					updateDisplay();
				});
				$checkbox.on('change', function () {
					updateDisplay();
				});


				// Actions
				function updateDisplay() {
					var isChecked = $checkbox.is(':checked');

					// Set the button's state
					$widget.data('state', (isChecked) ? "on" : "off");

					// Set the button's icon
					$widget.find('.state-icon')
						.removeClass()
						.addClass('state-icon ' + settings[$widget.data('state')].icon);

					// Update the button's color
					if (isChecked) {
						$widget.addClass(style + color + ' active');
					} else {
						$widget.removeClass(style + color + ' active');
					}
				}

				// Initialization
				function init() {

					if ($widget.data('checked') == true) {
						$checkbox.prop('checked', !$checkbox.is(':checked'));
					}

					updateDisplay();

					// Inject the icon if applicable
					if ($widget.find('.state-icon').length == 0) {
						$widget.prepend('<span class="state-icon ' + settings[$widget.data('state')].icon + '"></span>');
					}
				}
				init();
			});
		}
	};
});