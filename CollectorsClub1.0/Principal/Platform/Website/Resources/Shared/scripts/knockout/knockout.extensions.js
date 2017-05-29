// Array para almacenar los ViewModels que se van usando
var GlobalControllers = new Array();
var GlobalViewModels = new Array();
var ParsedModels = new Hashtable();

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
	for (var i = 2; i < arguments.length; i++) {
		args.push(arguments.callee.arguments[i]);
	}
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

		$(element).css('position', 'relative');
		var zoomIcom = $('<img src="' + settingsGlobales.ApplicationPath + 'Images/Extension/zoomin.png" class="ca_ampliar" />').click(function (event) {
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

ko.bindingHandlers.stopBinding = {
	init: function () {
		return { controlsDescendantBindings: true };
	}
};

ko.virtualElements.allowedBindings.stopBinding = true;

ko.bindingHandlers.partial = {
	init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
		return { controlsDescendantBindings: true };
	},
	update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
		if (typeof (GlobalViewModels) !== 'undefined' && typeof (GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel']) !== 'undefined' && GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel'] != null) {
			var _vm = ko.dataFor($(element).find('.contenedorNuevoFormatoListadoFormulario')[0].children[0]);
			if (typeof (_vm) === 'undefined' || _vm !== GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel']) {
				_vm = GlobalViewModels[allBindingsAccessor().IdModulo + 'ViewModel'];
				$(element).find('.validationMessage').remove();
				ko.applyBindingsToDescendants(_vm, $(element).find('.contenedorNuevoFormatoListadoFormulario')[0]);
			}
			var _parametros = ko.toJS(valueAccessor());
			var _filtroFijado = (typeof(_vm.FiltroFijado()) !== 'undefined' ? ko.toJS(_vm.FiltroFijado()) : {});
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
				_vm.Inicializar(_parametros);

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
