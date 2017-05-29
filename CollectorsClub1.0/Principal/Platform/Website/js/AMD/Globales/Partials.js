// TODO: OLL: Mover a cada uno de los baseviewmodel, pues pueden ser diferentes
var ModoInicioModulo = {
	Defecto: 'Defecto',
	PopuUp: 'PopUp',
	Listado: 'Listado',
	Buscador: 'Buscador',
	Insercion: 'Insercion',
	Edicion: 'Edicion',
}

var GlobalStylesheets = [];

define(['knockout', 'Globales/Core.Utils'], function (ko, utils) {
	function Partials()  {
		var self = this;
		self.loadOrderedStylesheets = function (files) {
			// OLL Ahora la carga la hace secuencial, es muy lento. Tenemos que llegar a cargar los archivos por orden de prioridad.
			if (typeof (files) !== 'undefined') {
				ko.utils.arrayForEach(files, function (file) {
					if (GlobalStylesheets.indexOf(file) == -1) {
						GlobalStylesheets.push(file);
						//console.log('Cargando stylesheet \'' + _file + '\'.');
						$('<link/>', { rel: 'stylesheet', type: 'text/css', href: file }).appendTo('head');
					}
				});
			}
		};

		self.IniciarPartial = function (nombreSystem, parametros, scripts, _stylesheets) {
			// Verificamos si se ha cargado correctamente jQuery
			if (typeof (jQuery) !== 'undefined') {
				// No agregar el ErrorContainer si ya existe
				if (!$('#' + parametros.ErrorContainer).length) { $("body").append('<div id="' + parametros.ErrorContainer + '" class="errorLabel"' + (parametros.MostrarErrores ? '' : ' style="visibility: hidden"') + ' />'); }
				if (!$('#' + parametros.CapaBloqueoCargando).length) { $('#' + parametros.ModuleId).before('<div id="' + parametros.CapaBloqueoCargando + '" class="dnnLoading" />'); }
				dojoConfig = { baseUrl: parametros.UrlBaseDojo };
				window.CKEDITOR_BASEPATH = parametros.UrlBaseCKEditor;
				//this.loadOrderedStylesheets(_stylesheets);
				require(['partials/' + nombreSystem], function (system) {
					try {
						parametros.CargaFinalizada = function () { utils.Cargando.Ocultar(parametros.CapaBloqueoCargando); };
						new system($, ko, parametros);
					} catch (excepcion) {
						console.log(excepcion);
					}
				});
			} else {
				alert(parametros.MensajeErrorCarga);
			}
		};

		self.InicializarGlobalScripts = function () {
			$('script').each(function () {
				var _script = $(this).attr('src');
				if (typeof (_script) !== 'undefined' && GlobalScripts.indexOf(_script) == -1) {
					GlobalScripts.push(_script);
				}
			});
		};

		//////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////// NUEVO SISTEMA /////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////
		self.DescargarEIniciarPartial = function (opciones) {
			require(['dojo/text!' + opciones.Url], function (contenidoHtml) {
				try {
					$('#' + opciones.IdPartial + 'ContenedorExterno').html(contenidoHtml.replace(/~\//g, opciones.ParametrosGlobales.ApplicationPath).replace(/__id__partial/g, opciones.IdPartial));
					eval(opciones.IdPartial + '.Iniciar(opciones.Parametros, self)');
				} catch (excepcion) {
					console.log(excepcion);
				}
			});
		};

		self.ActualizarPartial = function (contenedorExterno, opciones) {
			try {
				ko.dataFor($(contenedorExterno).find('#' + opciones.IdPartial + 'ContenedorInterno')[0].children[0]).Inicializar(opciones);
			} catch (excepcion) {
				console.log(excepcion);
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////// NUEVO SISTEMA INICIANDO BINDING CORRECTAMENTE /////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		self.DescargarEIniciarPartialIniciarBinding = function (opciones) {
			console.log('Descargando partial' + opciones.IdPartial);
			require(['dojo/text!' + opciones.Url], function (contenidoHtml) {
				try {
					$('#' + opciones.IdPartial + 'ContenedorExterno').html(contenidoHtml.replace(/~\//g, opciones.ParametrosGlobales.ApplicationPath).replace(/__id__partial/g, opciones.IdPartial));
					eval(opciones.IdPartial + '.Iniciar(opciones.Parametros, self)');
					eval(opciones.IdPartial + '.Actualizar(opciones.Parametros, self)');
				} catch (excepcion) {
					console.log(excepcion);
				}
			});
		};

		self.ActualizarPartialIniciarBinding = function (opciones) {
			console.log('Actualizando partial' + opciones.IdPartial);
			require(['dojo/text!' + opciones.Url], function (contenidoHtml) {
				try {
					//OLL: Sustituido por la siguiente línea ko.dataFor($('#' + opciones.IdPartial + 'ContenedorExterno').find('#' + opciones.IdPartial + 'ContenedorInterno')[0].children[0]).Recargar(opciones);
					eval(opciones.IdPartial + '.Actualizar(opciones.Parametros, self)');
				} catch (excepcion) {
					console.log(excepcion);
				}
			});
		}
	}

	return new Partials();
});