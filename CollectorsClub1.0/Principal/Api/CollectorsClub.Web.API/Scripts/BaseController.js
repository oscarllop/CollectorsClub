(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'Globales/Core.Utils'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('Globales/Core.Utils'));
	} else {
		// Browser globals
		window.GlobalBaseController = factory(jQuery, (typeof (window.Utils) !== 'undefined' ? window.Utils : {
			Error: logError,
			Ajax: llamadaAjax,
			RevisarUrl: function (url) { return url.replace(/\/\//g, '/'); },
			MostrarMensaje: displayMessage
		}));
	}
}(function ($, moment, utils) {
	function BaseController() {
		var self = this;

		self.GetQuery = function (observable, options, settings) {
			if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetQuery ' + settings.ApiUrl); }
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : 'GetQuery');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});
				options.Todos = (typeof (options.Todos) !== 'undefined' ? options.Todos : false);
				options.EliminarReferenciasCirculares = (typeof (options.EliminarReferenciasCirculares) !== 'undefined' ? options.EliminarReferenciasCirculares : true);

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				if (settings.debug) {
					// OLL: en lugar de settings deberíamos pasar el controller por parámetro
					var _registros = $.map(controller.registrosPrueba, function (registro) { return ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos); });
					observable(_registros);
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
				} else {
					var _urlParameters = (options.Action != '' ? '/actions/' + options.Action : '');
					_urlParameters += '?' + options.Parameters;
					//for (var name in options.Parameters) {
					//	if (options.Parameters.hasOwnProperty(name)) {
					//		var _valores = options.Parameters[name]
					//		if (!$.isArray(options.Parameters[name])) { _valores = [options.Parameters[name]]; }
					//		_valores.forEach(function (valor) {
					//			if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
					//			_urlParameters += 'parameter=' + name + '|' +  + '|' + (typeof (options.Parameters[name]) !== 'undefined' ? valor : 'null');
					//		});
					//	}
					//}
					var numeroRegistrosCargados = (typeof (observable()) !== 'undefined' ? (typeof (observable().length) !== 'undefined' ? observable().length : 0) : 0);
					//if (!options.Todos && numeroRegistrosCargados < options.RegistrosCargados && options.RegistrosCargados > options.TamanyoPagina * 3) {
					//	if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
					//	_urlParameters += '$skip=' + numeroRegistrosCargados + '&$top=' + options.TamanyoPagina();
					//}

					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetQuery ' + settings.ApiUrl + ': Antes llamada ajax'); }
					if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
					utils.Ajax({
						type: "GET",
						url: settings.ApiUrl + _urlParameters,
						cache: UsarCache(settings)
					}).done(function (registros) {
						ActualizarCache(settings, settings.EntitySet);
						if (typeof (registros) !== "undefined" && registros != null && registros != []) {
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetQuery ' + settings.ApiUrl + ': Se han obtenido ' + registros.length + ' : ' + settings.EntityName); }
							options.MostrarMensaje(settings.System.settings.MensajeCargandoRegistros + ' de {0}'.format(settings.EntityName));
							var _registros = RevisarJSON(registros);
							if (options.EliminarReferenciasCirculares) { _registros = CrearObjetoSinReferencias(_registros); }
							if (typeof (options.RegistrosComoObservables) !== 'undefined' && options.RegistrosComoObservables == true) {
								// OLL: Revisar. si el dojo crea referencias, el ko.mapping entra en bucle infinito. Por eso lo hacemos directamente de registros. Ver en un futuro si va bien eliminar los parent y pasarle _registros
								_registros = $.map(registros, function (registro) { return ko.mapping.fromJS(registro); });
							} else if (typeof (options.GenerarModeloEntidad) !== 'undefined' && options.GenerarModeloEntidad == true) {
								_registros = $.map(registros, function (registro) { return ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos); });
							}
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetQuery ' + settings.ApiUrl + ': Datos mapeados ' + registros.length + ' : ' + settings.EntityName); }
							if (typeof (options.RegistrosObtenidos) === 'function') { _registros = options.RegistrosObtenidos(observable, _registros); }
							if (!options.Todos && numeroRegistrosCargados > 0) {
								ko.utils.arrayPushAll(observable, _registros);
							} else {
								observable(_registros);
							}
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetQuery ' + settings.ApiUrl + ': Datos y cargados : ' + settings.EntityName); }
						} else {
							if (options.Todos) { observable([]); }
							options.MostrarMensaje(settings.System.settings.MensajeRespuestaServicioVacia);
						}
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					}).fail(function (xhr, status) {
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
						if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		}

		self.GetExcel = function (options, settings) {
			if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetExcel ' + settings.ApiUrl); }
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : 'GetQuery');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});
				options.Todos = (typeof (options.Todos) !== 'undefined' ? options.Todos : false);

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				if (settings.debug) {
					// OLL: en lugar de settings deberíamos pasar el controller por parámetro
					// Devolver excel de ejemplo
				} else {
					var _urlParameters = (options.Action != '' ? '/actions/' + options.Action : '');
					_urlParameters += '?' + options.Parameters + (typeof (options.Parameters) !== {} ? '&' : '?') + 'TipoRetorno=Excel';
					//for (var name in options.Parameters) {
					//	if (options.Parameters.hasOwnProperty(name)) {
					//		var _valores = options.Parameters[name]
					//		if (!$.isArray(options.Parameters[name])) { _valores = [options.Parameters[name]]; }
					//		_valores.forEach(function (valor) {
					//			if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
					//			_urlParameters += 'parameter=' + name + '|' +  + '|' + (typeof (options.Parameters[name]) !== 'undefined' ? valor : 'null');
					//		});
					//	}
					//}

					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetExcel ' + settings.ApiUrl + ': Antes llamada ajax'); }
					if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
					utils.Ajax({
						type: "GET",
						url: settings.ApiUrl + _urlParameters,
						cache: UsarCache(settings)
					}).done(function (ruta) {
						if (typeof (ruta) !== "undefined" && ruta != null) {
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetExcel ' + settings.ApiUrl + ': Se ha generado el archivo "' + ruta + '": ' + settings.EntityName); }
							options.MostrarMensaje(settings.System.settings.MensajeCargandoRegistros + ' de {0}'.format(settings.EntityName));
							if (typeof (options.RegistrosObtenidos) === 'function') { _ruta = options.RegistrosObtenidos(ruta); }
							location.href = settings.UrlWebAPI + '/api/Global/Actions/getExcel?rutaArchivo=' + ruta + '&nombre=Listado_' + settings.EntityName;
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetExcel ' + settings.ApiUrl + ': Se ha descargado el archivo "' + ruta + '": ' + settings.EntityName); }
						} else {
							options.MostrarMensaje(settings.System.settings.MensajeRespuestaServicioVacia);
						}
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(ruta); }
					}).fail(function (xhr, status) {
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		}

		self.GetPdf = function (registros, options, settings) {
			if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetPdf ' + settings.ApiUrl); }
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.PrellamadaApi();

				if (settings.debug) {
					// OLL: en lugar de settings deberíamos pasar el controller por parámetro
					// Devolver pdf de ejemplo
				} else {
					var _ids = '';
					// OLL: Falta que las claves se generen de forma genérica
					//$(registros).each(function (indice, registro) { _ids = 'Id=' + ConcatenarPropiedadesClave(registro, settings.KeyProperties); });
					$(registros).each(function (indice, registro) { _ids += (_ids != '' ? '&' : '') + 'Id=' + registro[settings.KeyProperties[0]]; });

					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetPdf ' + settings.ApiUrl + ': Antes llamada ajax'); }
					if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetPdf ' + settings.ApiUrl + ': Solicitando la descarga del archivo pdf de ": ' + settings.EntityName); }
					options.MostrarMensaje('Descargando pdf de {0}'.format(settings.EntityName));
					location.href = settings.ApplicationPath + '/_extension/PlantillasPdf/{0}.aspx?{1}&GenerarPdf=true'.format(settings.EntityName, _ids);
					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - GetPdf ' + settings.ApiUrl + ': Se ha descargado el archivo pdf de ": ' + settings.EntityName); }
					options.MostrarMensaje('Pdfs de {0} descargados'.format(settings.EntityName));
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(); }
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		}

		self.Get = function (observable, options, settings) {
			if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Get ' + settings.ApiUrl); }
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : '');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});
				options.Todos = (typeof (options.Todos) !== 'undefined' ? options.Todos : false);
				options.Profundidad = (typeof (options.Profundidad) !== 'undefined' ? options.Profundidad : 1);
				options.Include = (typeof (options.Include) !== 'undefined' ? options.Include : []);
				options.Filter = (typeof (options.Filter) !== 'undefined' ? options.Filter : '');
				options.EliminarReferenciasCirculares = (typeof (options.EliminarReferenciasCirculares) !== 'undefined' ? options.EliminarReferenciasCirculares : true);

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				if (settings.debug) {
					// OLL: en lugar de settings deberíamos pasar el controller por parámetro
					var _registros = $.map(controller.registrosPrueba, function (registro) { return ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos); });
					observable(_registros);
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
				} else {
					ActualizarCache(settings, settings.EntitySet);
					var _urlParameters = (options.Action != '' ? '/actions/' + options.Action : '');
					//var _esQuery = options.Parameters.hasOwnProperty('Query');
					for (var name in options.Parameters) {
						if (options.Parameters.hasOwnProperty(name)) {
							var _valores = options.Parameters[name]
							if (!$.isArray(options.Parameters[name])) { _valores = [options.Parameters[name]]; }
							_valores.forEach(function (valor) {
								if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
								//if (!_esQuery || (_esQuery && name == 'Query')) {
								_urlParameters += name + '=' + (typeof (options.Parameters[name]) !== 'undefined' ? valor : '');
								//} else {
								//	_urlParameters += 'parameter=' + name + '|' + self.ObtenerTipo(typeof (options.Parameters[name])) + '|' + (typeof (options.Parameters[name]) !== 'undefined' ? valor : 'null');
								//}
							});
						}
					}
					var numeroRegistrosCargados = (typeof (observable()) !== 'undefined' ? (typeof (observable().length) !== 'undefined' ? observable().length : 0) : 0);
					//if (!options.Todos && numeroRegistrosCargados < options.RegistrosCargados && options.RegistrosCargados > options.TamanyoPagina * 3) {
					//	if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
					//	_urlParameters += '$skip=' + numeroRegistrosCargados + '&$top=' + options.TamanyoPagina();
					//}
					if (options.Profundidad > 1) {
						if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
						_urlParameters += 'profundidad=' + options.Profundidad;
					}
					if (options.Filter != '') {
						if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
						_urlParameters += '$filter=' + options.Filter;
					}
					if (options.Include.length > 0) {
						options.Include.forEach(function (include) {
							if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
							_urlParameters += 'include=' + include;
						});
					}

					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Get ' + settings.ApiUrl + ': Antes llamada ajax'); }
					if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
					utils.Ajax({
						type: "GET",
						url: settings.ApiUrl + _urlParameters,
						cache: UsarCache(settings)
					}).done(function (registros) {
						if (typeof (registros) !== "undefined" && registros != null) {
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Get ' + settings.ApiUrl + ': Se han obtenido ' + registros.length + ' : ' + settings.EntityName); }
							options.MostrarMensaje(settings.System.settings.MensajeCargandoRegistros + ' de {0}'.format(settings.EntityName));
							var _registros = RevisarJSON(registros);
							if (options.EliminarReferenciasCirculares) { _registros = CrearObjetoSinReferencias(_registros); }
							if (typeof (options.RegistrosComoObservables) !== 'undefined' && options.RegistrosComoObservables == true) {
								// OLL: Revisar. si el dojo crea referencias, el ko.mapping entra en bucle infinito. Por eso lo hacemos directamente de registros. Ver en un futuro si va bien eliminar los parent y pasarle _registros
								_registros = $.map(registros, function (registro) { return ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos); });
							}
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Get ' + settings.ApiUrl + ': Datos mapeados ' + registros.length + ' : ' + settings.EntityName); }
							if (typeof (options.RegistrosObtenidos) === 'function') { _registros = options.RegistrosObtenidos(observable, _registros); }
							if (!options.Todos && numeroRegistrosCargados > 0) {
								ko.utils.arrayPushAll(observable, _registros);
							} else {
								observable(_registros);
							}
							if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Get ' + settings.ApiUrl + ': Datos y cargados : ' + settings.EntityName); }
						} else {
							if (options.Todos) { observable([]); }
							options.MostrarMensaje(settings.System.settings.MensajeRespuestaServicioVacia);
						}
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					}).fail(function (xhr, status) {
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
						if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		};

		self.Count = function (observable, options, settings) {
			if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Count ' + settings.ApiUrl); }
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				// OLL: Actualmente simulo el count con un método GetQuery que obtiene los mismos filtros que la función principal
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : 'GetQuery');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				if (settings.debug) {
					observable(controller.registrosPrueba.length);
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
				} else {
					observable(0);

					var _urlParameters = (options.Action != '' ? '/actions/' + options.Action : '');
					_urlParameters += '?' + options.Parameters;
					if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Count ' + settings.ApiUrl + ': Antes llamada ajax'); }
					if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
					utils.Ajax({
						type: 'GET',
						url: settings.ApiUrl + _urlParameters,
						cache: UsarCache(settings)
					}).done(function (count) {
						// TODO: OLL: Al llamar a GetQuery retorna un array. Deberíamos llamar a GetQueryScalar para que retorne un valor.
						var _numeroRegistros = count[0][''];
						observable(_numeroRegistros);
						if (settings.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Count ' + settings.ApiUrl + ': Datos cargados : ' + settings.EntityName); }
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					}).fail(function (xhr, status) {
						observable(0);
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
						if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		};

		//self.Count = function (observable, options, settings) {
		//	options = (typeof (options) !== 'undefined' ? options : {});
		//	try {
		//		if (settings.debug) {
		//			observable(controller.registrosPrueba.length);
		//		} else {
		//			observable(0);

		//			if (settings.trace) { console.log(settings.EntitySet + ' cache: ' + (_ultimaVersion != null && !_ultimaVersion.ObtenerDelServidor)); }
		//			utils.Ajax({
		//				type: 'GET',
		//				url: settings.ApiUrl + '/actions/count',
		//				cache: UsarCache(settings)
		//			}).done(function (count) {
		//				observable(count);
		//			}).fail(function (xhr, status) {
		//				observable(0);
		//			});
		//		}
		//	} catch (excepcion) {
		//		options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
		//	}
		//};

		self.GetPorId = function (observable, registro, options, settings) {
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : '');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});
				options.Include = (typeof (options.Include) !== 'undefined' ? options.Include : []);

				var _registroJS = (registro != null ? ko.toJS(registro) : null);
				// OLL: No tiene sentido en un Get mirar el nuevo, pongo a false
				//var _nuevo = (_registroJS != null ? EsRegistroNuevo(settings.KeyProperties, _registroJS) : true);

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				//console.log('Obteniendo datos de ' + PrepararUrlApi(settings.ApiUrl, _registroJS, options, settings.KeyProperties, true, false /*_nuevo */))
				if (settings.debug) {
					observable(registro);
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
				} else {
					utils.Ajax({
						type: "GET",
						url: PrepararUrlApi(settings.ApiUrl, _registroJS, options, settings.KeyProperties, true, false /*_nuevo */),
						cache: false // OLL: Utilizamos ¿UsarCache(settings)? o ¿dejamos que siempre lo busque?
					}).done(function (registro) {
						//console.log('Obtenido el registro de ' + PrepararUrlApi(settings.ApiUrl, _registroJS, options, settings.KeyProperties, true, false /*_nuevo */))
						if (typeof (registro) !== "undefined" && registro != null) {
							options.MostrarMensaje(settings.System.settings.MensajeCargandoRegistros + ' de {0}'.format(settings.EntityName));
							var _registro = RevisarJSON(registro)
							if (typeof (options.RegistrosComoObservables) !== 'undefined' && options.RegistrosComoObservables == true) {
								_registro = ObtenerModelo(settings.Modelo, _registro, settings.System.ViewModel.TraduccionCampos);
							}
							if (typeof (options.RegistrosObtenidos) === 'function') { _registro = options.RegistrosObtenidos(observable, _registro); }
							observable(_registro);
							// Este código, para simular las otras peticiones debería estar fuera del if. Deberíamos ver si al cambiarlo, falla algo.
							if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable); }
						} else {
							options.MostrarMensaje(settings.System.settings.MensajeRespuestaServicioVacia);
						}
					}).fail(function (xhr, status) {
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
						if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		};

		self.Update = function (observable, registro, options, settings) {
			var _vm = ko.validatedObservable(registro);
			var _nuevo = EsRegistroNuevo(settings.KeyProperties, ko.toJS(registro), options.Modo);
			var _usuario = typeof (settings.Usuario) !== 'undefined' ? settings.Usuario : 'usuario_anonimo';
			if (_nuevo) {
				if (registro.hasOwnProperty('FechaAlta')) { if (ko.isObservable(registro.FechaAlta)) { registro.FechaAlta(moment().format()); } else { registro.FechaAlta = moment().format(); } }
				if (registro.hasOwnProperty('UsuarioAlta')) { if (ko.isObservable(registro.UsuarioAlta)) { registro.UsuarioAlta(_usuario); } else { registro.FechaAlta = _usuario; } }
			} else {
				if (registro.hasOwnProperty('FechaUltimaModificacion')) { if (ko.isObservable(registro.FechaUltimaModificacion)) { registro.FechaUltimaModificacion(moment().format()); } else { registro.FechaUltimaModificacion = moment().format(); } }
				if (registro.hasOwnProperty('UsuarioUltimaModificacion')) { if (ko.isObservable(registro.UsuarioUltimaModificacion)) { registro.UsuarioUltimaModificacion(_usuario); } else { registro.UsuarioUltimaModificacion = _usuario; } }
			}
			if (_vm.isValid()) {
				options = (typeof (options) !== 'undefined' ? options : {});
				try {
					options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : '');
					if (!_nuevo && typeof (options.ActionPut) !== 'undefined') { options.Action = options.ActionPut; }
					if (_nuevo && typeof (options.ActionPost) !== 'undefined') { options.Action = options.ActionPost; }
					options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});

					// OLL: ¿Que es mejor, ko.JS o ko.toJS?
					var _registroJS = ko.toJS(registro);

					if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

					if (settings.debug) {
						observable(registro);
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, registro); }
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					} else {
						utils.Ajax({
							type: (_nuevo ? "POST" : "PUT"),
							url: PrepararUrlApi(settings.ApiUrl, _registroJS, options, settings.KeyProperties, false, _nuevo),
							data: ko.toJSON(_registroJS),
							contentType: "application/json"
						}).done(function (registro) {
							ForzarRefrescoCache(settings, settings.EntitySet);
							// data contiene los datos indicados como segundo parámetro en la HttpResponseMessage
							observable(ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos));
							options.MostrarMensaje(settings.System.settings.MensajeRegistroGuardado, 'Correcto');
							if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, registro); }
						}).fail(function (xhr, status) {
							options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
							if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
							utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
						}).always(function () {
							if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
						});
					}
					if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
				} catch (excepcion) {
					options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
					utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
				}
			} else {
				options.MostrarMensaje(settings.System.settings.MensajeErrorValidacion + "<br/>" + _vm.errors(), 'Error');
				utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
			}
		};

		self.UpdateMany = function (observable, registros, options, settings) {
			for (var i = 0; i < registros.length; i++) {
				// Comentamos esto porque mete variables llamadas "errors" en los registros y es posible que tenga parte de la culpa de que la API no recoja los valores
				//var _vm = ko.validatedObservable(registros[i]);
				// GRM: Si no es válido... ¿mostrar mensaje para cada uno de ellos o agruparlos y mostrarlos?
			}
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : '');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});

				if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

				if (settings.debug) {
					observable(registros);
					if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, registros); }
					if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
				} else {
					//var _urlParameters = (options.Action != '' ? '/actions/' + options.Action : (registro.Id() == 0 ? '' : '/' + registro.Id()));
					// GRM: Por el momento este método siempre recibirá un options.Action
					var _urlParameters = '/actions/' + options.Action;
					for (var name in options.Parameters) {
						if (options.Parameters.hasOwnProperty(name)) {
							if (_urlParameters.indexOf('?') == -1) { _urlParameters += '?'; } else { _urlParameters += '&'; }
							_urlParameters += name + '=' + options.Parameters[name]
						};
					}
					// GRM: Convertimos los observables en objetos Json para eliminar las funciones asociadas de los modelos (constructores)
					var _registros = ko.toJSON(registros);
					// GRM: Ahora que nos hemos librado de las funciones, convertimos a objetos javascript corrientes para poder enviar los datos en formato "application/x-www-form-urlencoded"
					_registros = ko.utils.parseJson(_registros);
					utils.Ajax({
						//type: (registro.Id() == 0 ? "POST" : "PUT"),
						type: "POST", // GRM: Por el momento siempre haremos POST, ya que pueden mezclarse registros nuevos con actualizables (como en el caso de las planificaciones de delegaciones)
						url: settings.ApiUrl + _urlParameters,
						// GRM: Los datos los pasamos con este formato porque con Json no los acepta la API, además hay que pasarlos como si fuera un objeto con nombre vacío para poder pasar una lista de objetos
						// GRM: Enlace con información al respecto:
						// GRM: http://stackoverflow.com/questions/14779679/jquery-posts-null-instead-of-json-to-asp-net-web-api (Ver pregunta y comentario marcado como respuesta)
						data: { "": _registros },
						contentType: "application/x-www-form-urlencoded"
					}).done(function (registros) {
						ForzarRefrescoCache(settings, settings.EntitySet);
						// data contiene los datos indicados como segundo parámetro en la HttpResponseMessage
						// GRM: Aquí se debería hacer un foreach de los resultados, mapearlos a models y asignarlos al observable, pero de momento nos conformaremos con que guarde
						//observable(ObtenerModelo(settings.Modelo, registro));
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, registros); }
						options.MostrarMensaje(settings.System.settings.MensajeRegistroGuardado, 'Correcto');
					}).fail(function (xhr, status) {
						options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
						if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
						utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
					}).always(function () {
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					});
				}
				if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
				utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
			}
		}

		self.Delete = function (observable, registro, options, settings) {
			options = (typeof (options) !== 'undefined' ? options : {});
			try {
				options.Action = (typeof (options.Action) !== 'undefined' ? options.Action : '');
				options.Parameters = (typeof (options.Parameters) !== 'undefined' ? options.Parameters : {});
				options.PedirConfirmacion = (typeof (options.PedirConfirmacion) !== 'undefined' ? options.PedirConfirmacion : true);

				var _registroJS = ko.toJS(registro);

				if (!options.PedirConfirmacion || options.PedirConfirmacion && confirm(settings.System.settings.MensajeEstaSeguroBorrar)) {
					if (typeof (options.PrellamadaApi) === 'function') { options.PrellamadaApi(); }

					if (settings.debug) {
						observable(ObtenerModelo(settings.Modelo, registro, settings.System.ViewModel.TraduccionCampos));
						if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, registros); }
						if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
					} else {
						utils.Ajax({
							type: 'DELETE',
							url: PrepararUrlApi(settings.ApiUrl, _registroJS, options, settings.KeyProperties, false, false),
							data: ko.toJSON(_registroJS),
							contentType: 'application/json'
						}).done(function (data) {
							ForzarRefrescoCache(settings, settings.EntitySet);
							try {
								observable(ObtenerModelo(settings.Modelo, _registroJS, settings.System.ViewModel.TraduccionCampos));
								if (typeof (options.RespuestaPeticionCorrecta) === 'function') { options.RespuestaPeticionCorrecta(observable, _registroJS) }
								options.MostrarMensaje(settings.System.settings.MensajeRegistroEliminado, 'Correcto');
							} catch (excepcion) {
								options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
							}
						}).fail(function (xhr, status) {
							options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
							if (typeof (options.RespuestaPeticionConErrores) === 'function') { options.RespuestaPeticionConErrores(xhr, status); }
							utils.Cargando.Ocultar(settings.IdPartial + 'ContenedorCargandoFormulario');
						}).always(function () {
							if (typeof (options.PeticionFinalizada) === 'function') { options.PeticionFinalizada(observable); }
						});
						if (typeof (options.PostllamadaApi) === 'function') { options.PostllamadaApi(); }
					}
				}
			} catch (excepcion) {
				options.MostrarMensaje(settings.System.settings.MensajeError + ' ' + excepcion.message, 'Error');
			}
		};

		self.RegisterController = function (settings) {
			if (typeof (GlobalControllers) != 'undefined' && (typeof (GlobalControllers[settings.EntityName + 'Controller']) == 'undefined' || GlobalControllers[settings.EntityName + 'Controller'] == null)) { GlobalControllers[settings.EntityName + 'Controller'] = settings.Controller; }
		}

		self.DescargarScripts = function (entidad, settings) {
			if (typeof (GlobalControllers) != 'undefined' && typeof (GlobalControllers[entidad + 'Controller']) == 'undefined') {
				GlobalControllers[entidad + 'Controller'] = null;
				if (eval('typeof ' + entidad + 'Controller == \'undefined\'')) {
					$.when(
						$.getScript(settings.UrlWebAPI + '/scripts/Controllers/' + entidad + 'Controller.js'),
						$.getScript(settings.UrlWebAPI + '/scripts/Models/' + entidad + 'Model.js'),
						$.Deferred(function (deferred) { $(deferred.resolve); })
					).done(function () {
						GlobalControllers[entidad + 'Controller'] = eval('new ' + entidad + 'Controller(settings)');
					}).fail(function (xhr, status) {
						settings.MostrarMensaje("#InnerContainer", settings.System.settings.MensajeError + ' ' + status + ': ' + ProcesarExcepcionWeb(xhr), 'Error');
					});
				} else {
					GlobalControllers[entidad + 'Controller'] = eval('new ' + entidad + 'Controller(settings)');
				}
			}
		}

		self.EsRegistroNuevo = function (registro, settings) {
			return EsRegistroNuevo(settings.KeyProperties, ko.toJS(registro), settings.Modo);
		}

		function EsRegistroNuevo(propiedadesClave, registro, modo) {
			if (modo == 'Insercion' || modo == 'Defecto') { _nuevo = true; }
			else if (modo == 'Edicion') { _nuevo = false; }
			else {
				var _nuevo = true;
				propiedadesClave.forEach(function (property) {
					if (registro.hasOwnProperty(property) && (registro[property] > 0 && registro[property] != '' && registro[property] != null)) { _nuevo = false; }
				});
			}
			return _nuevo;
		}

		function ConcatenarPropiedadesClave(registro, propiedadesClave) {
			var _id = ''
			propiedadesClave.forEach(function (property) {
				if (registro.hasOwnProperty(property)) { _id = (_id != '' ? '|' : '') + property + '=' + registro[property]; }
			});
			return _id;
		}

		function PrepararUrlApi(apiUrl, registro, options, propiedadesClave, isQuery, nuevo) {
			var _url = apiUrl + (options.Action != '' ? '/actions/' + options.Action + '/' : '/');
			if (!nuevo && propiedadesClave.length >= 1) { _url += registro[propiedadesClave[0]].toString().trim(); }
			if (!nuevo) {
				propiedadesClave.forEach(function (property) {
					if (registro.hasOwnProperty(property)) { _url = (_url.indexOf('?') == -1 ? _url += '?' : _url += '&') + property + '=' + registro[property]; }
				});
			}

			for (var name in options.Parameters) {
				if (options.Parameters.hasOwnProperty(name)) {
					if (_url.indexOf('?') == -1) { _url += '?'; } else { _url += '&'; }
					_url += name + '=' + options.Parameters[name]
				};
			}

			if (isQuery && options.Include.length > 0) {
				options.Include.forEach(function (include) {
					if (_url.indexOf('?') == -1) { _url += '?'; } else { _url += '&'; }
					_url += 'include=' + include;
				});
			}
			return _url;
		}

		function PrepararData(propiedadesClave, registro) {
			var _resultado = {};
			for (var property in propiedadesClave) {
				_resultado[propiedadesClave[property]] = registro[propiedadesClave[property]];
			}
			return _resultado;
		}

		function ObtenerModelo(modelo, registro, traducciones) {
			return new modelo((typeof (registro) !== 'undefined' ? registro : {}), traducciones);
		}

		function ForzarRefrescoCache(settings, entidad) {
			if ((typeof (settings.UltimasVersionesTablas) === 'undefined' || settings.UltimasVersionesTablas == null || settings.UltimasVersionesTablas.length == 0) && typeof (window.ParametrosGlobales.UltimasVersionesTablas) !== 'undefined') { settings.UltimasVersionesTablas = window.ParametrosGlobales.UltimasVersionesTablas; }
			if (settings.UltimasVersionesTablas == null) { settings.UltimasVersionesTablas = []; }
			settings.UltimasVersionesTablas.push({ 'Nombre': entidad, "Version": 0 })
		}

		function ActualizarCache(settings, entidad) {
			if (settings.UltimasVersionesTablas != null) {
				settings.UltimasVersionesTablas = $.grep(settings.UltimasVersionesTablas, function (ultimaVersion) { return settings.EntitySet != ultimaVersion.Nombre; });
			}
		}

		function UsarCache(settings) {
			if ((typeof (settings.UltimasVersionesTablas) === 'undefined' || settings.UltimasVersionesTablas == null || settings.UltimasVersionesTablas.length == 0) && typeof (window.ParametrosGlobales.UltimasVersionesTablas) !== 'undefined') { settings.UltimasVersionesTablas = window.ParametrosGlobales.UltimasVersionesTablas; }
			if (settings.UltimasVersionesTablas == null) {
				// No hemos obtenido las últimas versiones. Actualizadmos todo.
				//console.log(settings.EntitySet + ': No se han recibido aún las versiones. Actualizo por si un caso...')
				return false;
			} else if (settings.UltimasVersionesTablas.length == 0) {
				// Hemos obtenido las últimas versiones pero no hay ninguna a actualizar
				//console.log(settings.EntitySet + ': No hay versiones a actualizar. Mantengo caché...')
				return true;
			} else {
				// Busco si tengo que actualizar esta entidad o no.
				var _ultimaVersion = (typeof (settings.UltimasVersionesTablas) !== 'undefined' && settings.UltimasVersionesTablas.length > 0 ? $.grep(settings.UltimasVersionesTablas, function (ultimaVersion) { return settings.EntitySet == ultimaVersion.Nombre; }) : null);
				//console.log(settings.EntitySet + ': Numero elementos en ultimas versiones ' + window.ParametrosGlobales.UltimasVersionesTablas.length)
				//console.log(settings.EntitySet + ': Cache = ' + (_ultimaVersion == null || _ultimaVersion.length == 0));
				return (_ultimaVersion == null || _ultimaVersion.length == 0);
			}
		}

		function RevisarJSON(objeto) {
			return dojox.json.ref.fromJson(dojox.json.ref.toJson(objeto), { idAttribute: '$id' });
		}

		function CrearObjetoSinReferencias(objeto) {
			if (Array.isArray(objeto)) {
				$.each(objeto, function (indice, elemento) {
					elemento = (typeof (elemento) === 'object' || Array.isArray(elemento) ? CrearObjetoSinReferencias(elemento) : elemento);
				});
			} else {
				if (typeof (objeto.$id) !== 'undefined' && typeof (objeto.__parent) !== 'undefined') {
					if (typeof (objeto.$id) !== 'undefined') { delete objeto.$id; }
					if (typeof (objeto.__parent) !== 'undefined') { delete objeto.__parent; }
					for (var _propiedad in objeto) {
						objeto[_propiedad] = (objeto.hasOwnProperty(_propiedad) && ((typeof (objeto[_propiedad]) === 'object' && objeto[_propiedad] != null) || Array.isArray(objeto[_propiedad])) ? CrearObjetoSinReferencias(objeto[_propiedad]) : objeto[_propiedad]);
					}
				}
			}
			return objeto;
		}

		function ProcesarExcepcionWeb(excepcion) {
			if (excepcion.responseJSON != null) {
				if (excepcion.responseJSON.ClassName == 'System.Data.Entity.Infrastructure.DbUpdateException' && excepcion.responseJSON.InnerException != null) {
					return excepcion.responseJSON.Message + '<br/>' + (excepcion.responseJSON.InnerException.InnerException != null ? excepcion.responseJSON.InnerException.InnerException.Message : excepcion.responseJSON.InnerException.Message);
				} else {
					return (typeof (excepcion.responseJSON.Message) != 'undefined' ? excepcion.responseJSON.Message : excepcion.responseJSON);
				}
			} else {
				return excepcion.responseText;
			}
		}
	};

	return new BaseController();
}));