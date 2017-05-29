define(['Globales/BaseBaseViewModel', 'knockout', 'global/knockout/knockout.validation.min', 'Globales/ko.observableDictionary', 'Globales/Core.Utils', 'Globales/popup'], function (baseViewModel, ko, validation, observableDictionary, utils, popup) {
	try {
		return function GestorArchivosViewModel(settings) {
			var self = this;
			self.settings = $.extend({}, settings);
			self.settings.ModuloPrincipal = (typeof (self.settings.ModuloPrincipal) !== 'undefined' ? self.settings.ModuloPrincipal : false);
			self.settings.CargarArchivosAlArrastrar = (typeof (self.settings.CargarArchivosAlArrastrar) !== 'undefined' ? self.settings.CargarArchivosAlArrastrar : false);
			self.settings.PermitirBorrar = (typeof (self.settings.PermitirBorrar) !== 'undefined' ? self.settings.PermitirBorrar : true);
			self.settings.ApiCarga = (typeof (self.settings.ApiCarga) !== 'undefined' ? self.settings.ApiCarga : self.settings.UrlWebAPI + '/api/Global/actions/CargarArchivo');
			self.settings.ParametrosCarga = (typeof (self.settings.ParametrosCarga) !== 'undefined' ? self.settings.ParametrosCarga : {});
			self.settings.TiposArchivoPermitidos = (typeof (self.settings.TiposArchivoPermitidos) !== 'undefined' ? self.settings.TiposArchivoPermitidos : null);
			self.settings.PreviewTemplate = (typeof (self.settings.PreviewTemplate) !== 'undefined' ? self.settings.PreviewTemplate : document.getElementById('preview-template').innerHTML);
			self.settings.ArchivoAnyadido = (typeof (self.settings.ArchivoAnyadido) !== 'undefined' ? self.settings.ArchivoAnyadido : null);
			self.settings.GrupoArchivosAnyadido = (typeof (self.settings.GrupoArchivosAnyadido) !== 'undefined' ? self.settings.GrupoArchivosAnyadido : null);
			self.settings.CargaArchivosFinalizada = (typeof (self.settings.CargaArchivosFinalizada) !== 'undefined' ? self.settings.CargaArchivosFinalizada : null);
			self.settings.ErrorCargaArchivos = (typeof (self.settings.ErrorCargaArchivos) !== 'undefined' ? self.settings.ErrorCargaArchivos : null);

			self.FormatearFecha = utils.FormatearFecha;
			self.Inicializar = function (settings) { baseViewModel.Inicializar(self, settings); };
			self.Cargar = function (ruta) {
				if (typeof (self.ReferenciaAlObjetoDropzone) !== 'undefined' && self.ReferenciaAlObjetoDropzone != null && ko.isObservable(self.ReferenciaAlObjetoDropzone)) {
					var _dropzone = self.ReferenciaAlObjetoDropzone();
					var _numeroArchivosAProcesar = 0;
					$(_dropzone.files).each(function () { if (this.status == "queued") { _numeroArchivosAProcesar++; } });
					if (_numeroArchivosAProcesar > 0) {
						self.ReferenciaAlObjetoDropzone().processQueue();
					} else {
						// No hay archivos a cargar. LLamamos evento ArchivosCargados
						utils.MostrarMensaje('#' + self.settings.ErrorContainer, 'Se han cargado correctamente todos los archivos.', 'Info');
						if (typeof (self.MetodosRespuesta.ArchivosCargados) === 'function') { self.MetodosRespuesta.ArchivosCargados(self.settings.DatosPorDefecto.ListaArchivos()); }
					}
				} else {
					utils.MostrarMensaje('#' + self.settings.ErrorContainer, 'Ha surgido un error al subir los documentos. No se puede obtener acceso a la zona de carga.', 'Error');
				}
			};

			self.ReferenciaAlObjetoDropzone = ko.observable({});
			self.settings.OpcionesDropzone = {
				dictDefaultMessage: "Arrastre aquí los archivos a cargar",
				dictFallbackMessage: "Su explorador no soporta el arrastre de archivos.",
				dictFallbackText: "Por favor, utilice el siguiente formulario para cargar los archivos.",
				dictFileTooBig: "El archivo es demasiado grande: Tamaño del archivo ({{filesize}} MB). Tamaño máximo: {{maxFilesize}} MB.",
				dictInvalidFileType: "No puede cargar archivos de este tipo.",
				dictResponseError: "El servidor respondió con el código {{statusCode}}.",
				dictCancelUpload: "Carga de archivos cancelada.",
				dictCancelUploadConfirmation: "¿Está seguro de cancelar la carga de los archivos?",
				dictRemoveFile: '<em class="fa fa-trash"></em>',
				dictMaxFilesExceeded: "No se pueden cargar más archivos.",
				url: self.settings.ApiCarga,
				autoProcessQueue: self.settings.CargarArchivosAlArrastrar,
				addRemoveLinks: self.settings.PermitirBorrar,
				maxFiles: self.settings.NumeroMaximoArchivosACargar,
				//previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-image max\"><img data-dz-thumbnail /></div>\n  <div class=\"dz-details\">\n    <div class=\"dz-size\"><span data-dz-size></span></div>\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n  </div>\n  <div class=\"dz-progress\"><span class=\"dz-upload\" data-dz-uploadprogress></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n  <div class=\"dz-success-mark\">\n    <svg width=\"54px\" height=\"54px\" viewBox=\"0 0 54 54\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:sketch=\"http://www.bohemiancoding.com/sketch/ns\">\n      <title>Check</title>\n      <defs></defs>\n      <g id=\"Page-1\" stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\" sketch:type=\"MSPage\">\n        <path d=\"M23.5,31.8431458 L17.5852419,25.9283877 C16.0248253,24.3679711 13.4910294,24.366835 11.9289322,25.9289322 C10.3700136,27.4878508 10.3665912,30.0234455 11.9283877,31.5852419 L20.4147581,40.0716123 C20.5133999,40.1702541 20.6159315,40.2626649 20.7218615,40.3488435 C22.2835669,41.8725651 24.794234,41.8626202 26.3461564,40.3106978 L43.3106978,23.3461564 C44.8771021,21.7797521 44.8758057,19.2483887 43.3137085,17.6862915 C41.7547899,16.1273729 39.2176035,16.1255422 37.6538436,17.6893022 L23.5,31.8431458 Z M27,53 C41.3594035,53 53,41.3594035 53,27 C53,12.6405965 41.3594035,1 27,1 C12.6405965,1 1,12.6405965 1,27 C1,41.3594035 12.6405965,53 27,53 Z\" id=\"Oval-2\" stroke-opacity=\"0.198794158\" stroke=\"#747474\" fill-opacity=\"0.816519475\" fill=\"#FFFFFF\" sketch:type=\"MSShapeGroup\"></path>\n      </g>\n    </svg>\n  </div>\n  <div class=\"dz-error-mark\">\n    <svg width=\"54px\" height=\"54px\" viewBox=\"0 0 54 54\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:sketch=\"http://www.bohemiancoding.com/sketch/ns\">\n      <title>Error</title>\n      <defs></defs>\n      <g id=\"Page-1\" stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\" sketch:type=\"MSPage\">\n        <g id=\"Check-+-Oval-2\" sketch:type=\"MSLayerGroup\" stroke=\"#747474\" stroke-opacity=\"0.198794158\" fill=\"#FFFFFF\" fill-opacity=\"0.816519475\">\n          <path d=\"M32.6568542,29 L38.3106978,23.3461564 C39.8771021,21.7797521 39.8758057,19.2483887 38.3137085,17.6862915 C36.7547899,16.1273729 34.2176035,16.1255422 32.6538436,17.6893022 L27,23.3431458 L21.3461564,17.6893022 C19.7823965,16.1255422 17.2452101,16.1273729 15.6862915,17.6862915 C14.1241943,19.2483887 14.1228979,21.7797521 15.6893022,23.3461564 L21.3431458,29 L15.6893022,34.6538436 C14.1228979,36.2202479 14.1241943,38.7516113 15.6862915,40.3137085 C17.2452101,41.8726271 19.7823965,41.8744578 21.3461564,40.3106978 L27,34.6568542 L32.6538436,40.3106978 C34.2176035,41.8744578 36.7547899,41.8726271 38.3137085,40.3137085 C39.8758057,38.7516113 39.8771021,36.2202479 38.3106978,34.6538436 L32.6568542,29 Z M27,53 C41.3594035,53 53,41.3594035 53,27 C53,12.6405965 41.3594035,1 27,1 C12.6405965,1 1,12.6405965 1,27 C1,41.3594035 12.6405965,53 27,53 Z\" id=\"Oval-2\" sketch:type=\"MSShapeGroup\"></path>\n        </g>\n      </g>\n    </svg>\n  </div>\n</div>",
				previewTemplate: self.settings.PreviewTemplate,
				acceptedFiles: self.settings.TiposArchivoPermitidos
			}

			self.Mensajes = ko.observableArray([]);
			self.settings.EventosDropzone = [
				{
					Nombre: "success",
					Funcion: function (archivo, respuesta, e) {
						console.log('success externo');
						if (typeof (self.settings.CargaArchivosFinalizada) === 'function') { self.settings.CargaArchivosFinalizada(respuesta); }
						self.Mensajes(respuesta.Mensajes != null ? respuesta.Mensajes : []);
						utils.MostrarMensaje('#' + self.settings.ErrorContainer, 'Se ha cargado correctamente el archivo {0}.'.format(archivo.name), 'Info');
					}
				},
				{
					Nombre: "queuecomplete",
					Funcion: function () {
						utils.MostrarMensaje('#' + self.settings.ErrorContainer, 'Se han cargado correctamente todos los archivos.', 'Info');
						if (typeof (self.MetodosRespuesta.ArchivosCargados) === 'function') { self.MetodosRespuesta.ArchivosCargados(self.settings.DatosPorDefecto.ListaArchivos()); }
					}
				},
				{
					Nombre: "error",
					Funcion: function (arhivo, mensaje, xhr) {
						if (typeof (self.settings.CargaFinalizada) === 'function') { self.settings.ErrorCarga(archivo, mensaje, xhr); }
						utils.MostrarMensaje('#' + self.settings.ErrorContainer, 'Ha surgido un error cargando el archivo {0}: {1}'.format(arhivo.name, mensaje), 'Error');
					}
				}
			];

			self.Actualizar = function (parametros) {
				//console.log('Actualizando el gestor de archivos');
				//if (typeof (parametros.DatosPorDefecto.ListaArchivos) !== 'undefined') { self.ListaArchivos(parametros.DatosPorDefecto.ListaArchivos()); }
				//if (typeof (parametros.DatosPorDefecto.ListaArchivos) !== 'undefined') { self.ListaArchivos = parametros.DatosPorDefecto.ListaArchivos; }
			}

			self.MetodoGuardarEdicionImagen = function (idElementoImagen, nuevaUrl) {
				var _dropzone = self.ReferenciaAlObjetoDropzone()
				var xhr = new XMLHttpRequest();
				xhr.open('GET', nuevaUrl, true);
				xhr.responseType = 'blob';
				xhr.onload = function (e) {
					if (this.status == 200) {
						var _partes = document.getElementById(idElementoImagen).src.split('?')[0].split('/');
						var _extension = _partes[_partes.length - 1].split('.')[1];
						var _contentType = (_extension == 'jpg' ? 'image/jpeg' : 'image/' + _extension);
						var _archivoImagen = new File([this.response], _partes[_partes.length - 1], { type: _contentType, lastModified: Date.now() })
						var _indiceElemento = 0;
						$(_dropzone.files).each(function (indice) {
							var _partes2 = this.url.split('/');
							if (_partes[_partes.length - 1] == _partes2[_partes2.length - 1]) { _indiceElemento = indice; }
						});
						_dropzone.removeFile(_dropzone.files[_indiceElemento]);
						_dropzone.addFile(_archivoImagen);
						$('#' + idElementoImagen).removeAttr('id');
						self.settings.System.CSDKImageEditor.close();
					}
				};
				xhr.send();
			}

			self.ListaArchivos = (typeof (self.settings.DatosPorDefecto.ListaArchivos) !== 'undefined' ? self.settings.DatosPorDefecto.ListaArchivos : ko.observableArray([]));

			baseViewModel.InicializarViewModel(self, settings);
		};
	} catch (excepcion) {
		console.log(excepcion);
		return null;
	}
});
