// Array para almacenar los ViewModels que se van usando
var GlobalControllers = new Array();
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
		if (typeof (CKEDITOR.instances[txtBoxID]) !== 'undefined') {
			CKEDITOR.instances[txtBoxID].focusManager.blur = function () {
				var observable = valueAccessor();
				observable($(element).val());
			};
		}
	},
	update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
		var val = ko.utils.unwrapObservable(valueAccessor());
		$(element).val(val);
	}
}

ko.bindingHandlers.celdaAmpliable = {
	elemento: null,
	init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
		ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
			console.log('OLL: Dispose de celdaAmpliable ejecutado. ¿Tengo que hacer algo aquí?');
		});

		elemento = ($(element).is('td') ? $(element) : $(element).parents("td").first());
		elemento.css('position', 'relative');
		var zoomIcom = $('<img src="/EAE/Integrador2_0/Images/Extension/zoomin.png" class="ca_ampliar" />').click(function (event) {
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
		var _contenido = $('<div class="ca_contenido" />');
		elemento.append(zoomIcom).append(_contenido);
	},
	update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
		var val = ko.utils.unwrapObservable(valueAccessor());
		elemento.children(':last-child').html(val);
	}
}

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