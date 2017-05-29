(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'knockout', 'Plugins/DropZone/dropzone-amd-module'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('knockout'), require('Plugins/DropZone/dropzone-amd-module'));
	} else {
		factory(jQuery, ko, Dropzone);
	}
}(function ($, ko, Dropzone) {
	ko.bindingHandlers.dropzone = {
		init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var _parametros = valueAccessor();
			var options = {
				maxFilesize: 1256,
				createImageThumbnails: false,
			};

			$.extend(options, _parametros.Opciones);
			options.init = function () {
				var _dropzone = this;
				var _valor = ko.utils.unwrapObservable(_parametros.value);
				var _autoProcessQueueInicial = _parametros.Opciones.autoProcessQueue;
				var _cancelarCargaArchivos = false;
				_dropzone.on('success', function (archivo, respuesta, e) {
					var _archivo = {
						Ruta: ko.unwrap(_parametros.UrlArchivos) + '/' + respuesta.Ruta.replace(ko.unwrap(_parametros.UrlArchivos) + '/', ''),
						Doctype: archivo.type
					};

					if (Array.isArray(_valor)) {
						if (ko.isObservableArray(_parametros.value)) {
							_parametros.value.push(_archivo);
						} else if (ko.isObservable(_parametros.value)) {
							var _archivos = _parametros.value();
							_archivos.push(_archivo);
							_parametros.value(_archivos)
						} else {
							_parametros.value.push(_archivo);
						}
					} else {
						if (ko.isObervable(_parametros.value)) { _parametros.value(_archivo); } else { _parametros.value = _archivo; }
					}
				});

				_dropzone.on('error', function (arhivo, mensaje, xhr) {
					console.error('dropzone@err:', mensaje);
				});

				_dropzone.on("processing", function (archivo) {
					$(archivo.previewElement).find('.dz-progress').css('display', 'block');
					this.options.autoProcessQueue = true;
				});

				_dropzone.on("queuecomplete", function () {
					this.options.autoProcessQueue = _autoProcessQueueInicial;
				});

				_dropzone.on('addedfile', function (archivo) {
					var _continuar = true;
					if (typeof (_parametros.ArchivoAnyadido) === 'function') { _continuar = _parametros.ArchivoAnyadido(); }
					if (!_continuar || _cancelarCargaArchivos) { this.removeFile(archivo); }
					$(archivo.previewElement).find('.dz-edit').click(function (evento) {
						$(this).parents('.dz-preview').find('.dz-image img').attr('id', 'imagenEnEditor');
						_parametros.Editor.launch({
							image: $(this).parents('.dz-preview').find('.dz-image img')[0].id,
							url: $(this).parents('.dz-preview').find('.dz-image img')[0].src
						});
					});
				});

				_dropzone.on('addedfiles', function (archivos) {
					_cancelarCargaArchivos = false;
					var _continuar = true;
					if (typeof (_parametros.GrupoArchivosAnyadido) === 'function') { _continuar = _parametros.GrupoArchivosAnyadido(); }
					_cancelarCargaArchivos = !_continuar;
				});

				_dropzone.on('removedfile', function (archivo) {
					if (Array.isArray(_valor)) {
						if (ko.isObservableArray(_parametros.value)) {
							_parametros.value.remove(function (archivoArray) {
								//return archivoArray.Ruta == _parametros.UrlArchivos + _parametros.UrlArchivosNuevos() + '/' + archivo.name;
								return archivoArray.Ruta == archivo.name;
							});
						} else if (ko.isObservable(_parametros.value)) {
							var _archivos = _parametros.value();
							_archivos = _archivos.filter(function (archivoArray) {
								//return archivoArray.Ruta !== _parametros.UrlArchivos + _parametros.UrlArchivosNuevos() + '/' + archivo.name;
								return archivoArray.Ruta == archivo.name;
							});
							_parametros.value(_archivos);
						} else {
							var _archivos = _parametros.value;
							_archivos = _archivos.filter(function (archivoArray) {
								//return archivoArray.Ruta !== _parametros.UrlArchivos + _parametros.UrlArchivosNuevos() + '/' + archivo.name;
								return archivoArray.Ruta == archivo.name;
							});
							_parametros.value = _archivos;
						}
					} else {
						if (ko.isObervable(_parametros.value)) { _parametros.value(null); } else { _parametros.value = null; }
					}
				});

				_dropzone.on('sending', function (archivo, xhr, formData) {
					// OLL: Pasarlo como parámetro de carga
					formData.append('Ruta', ko.unwrap(_parametros.UrlArchivosNuevos));
					for (var _clave in _parametros.ParametrosCarga) {
						if (_parametros.ParametrosCarga.hasOwnProperty(_clave)) { formData.append(_clave, ko.unwrap(_parametros.ParametrosCarga[_clave])); };
					}
				});
			};

			$(element).addClass('dropzone');
			var _dropZone = new Dropzone(element, options); // jshint ignore:line
			$.each(_parametros.Eventos, function (indice, evento) { _dropZone.on(evento.Nombre, evento.Funcion); });
			_parametros.ReferenciaAlObjetoDropzone(_dropZone);
		},
		update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
			var _parametros = valueAccessor();
			var _valor = ko.utils.unwrapObservable(_parametros.value);
			var _listaArchivos = [];
			if (!Array.isArray(_valor)) { _listaArchivos.push(_valor); }
			else { _listaArchivos = _listaArchivos.concat(_valor) }
			for (var i = 0; i < _listaArchivos.length; i++) {
				if ($.grep(element.dropzone.files, function (archivo) { return (archivo.name.indexOf('/') < 0 ? _listaArchivos[i].Ruta.endsWith(archivo.name) : archivo.name == _listaArchivos[i].Ruta); }).length == 0) {
					var _nuevoArchivo = {
						accepted: true,	// Este valor hace que cuente el archivo a la hora de conocer el número de archivos subidos
						name: _listaArchivos[i].Ruta,
						size: 12,
						type: _listaArchivos[i].Doctype,
						status: Dropzone.ADDED,
						url: _listaArchivos[i].Ruta
					};

					// Call the default addedfile event handler
					element.dropzone.emit("addedfile", _nuevoArchivo);

					// And optionally show the thumbnail of the file:
					element.dropzone.emit("thumbnail", _nuevoArchivo, _listaArchivos[i].Ruta + '?' + new Date().getTime());

					element.dropzone.files.push(_nuevoArchivo);
				}
			}
		}
	};
}));