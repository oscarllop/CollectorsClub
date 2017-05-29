define(['jquery', 'knockout', 'moment/moment-with-locales.min', 'ParametrosGlobales'], function ($, ko, moment, parametrosGlobales) {
	//first, checks if it isn't implemented yet
	if (!String.prototype.format) {
		String.prototype.format = function () {
			var args = arguments;
			return this.replace(/{(\d+)}/g, function (match, number) {
				return typeof args[number] != 'undefined'
					? args[number]
					: match
				;
			});
		};
	}

	var browserDetect = {
		init: function () { this.browser = this.searchString(this.dataBrowser) || "Other"; this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "Unknown"; },
		searchString: function (data) { for (var i = 0; i < data.length; i++) { var dataString = data[i].string; this.versionSearchString = data[i].subString; if (dataString.indexOf(data[i].subString) != -1) { return data[i].identity; } } },
		searchVersion: function (dataString) { var i = dataString.indexOf(this.versionSearchString); if (i == -1) return; return parseFloat(dataString.substring(i + this.versionSearchString.length + 1)); },
		dataBrowser: [{ string: navigator.userAgent, subString: "Chrome", identity: "Chrome" }, { string: navigator.userAgent, subString: "MSIE", identity: "Explorer" }, { string: navigator.userAgent, subString: "Firefox", identity: "Firefox" }, { string: navigator.userAgent, subString: "Safari", identity: "Safari" }, { string: navigator.userAgent, subString: "Opera", identity: "Opera" }]
	};

	// returns a well formed url depending on the browser version
	// For IE8 & IE9
	function ApiUrl(domain, path) {
		var url = "";
		if (browserDetect.browser == 'Explorer' && browserDetect.version < 10) {
			url = path;
		} else {
			url = domain + path;
		}
		return url;
	}

	function RevisarVersionesTablas(aplicacion, ultimasVersiones) {
		var _ultimaVersionDescargada = 0;
		$.each(ultimasVersiones, function (indice, ultimaVersion) { if (_ultimaVersionDescargada < ultimaVersion.Version) { _ultimaVersionDescargada = ultimaVersion.Version; } });
		localStorage[aplicacion + '_UltimaVersionDescargada'] = ko.toJSON(_ultimaVersionDescargada);
		localStorage[aplicacion + '_UltimaFechaDescargada'] = Date.now().toString();
		//console.log(ultimasVersiones);
		return ultimasVersiones;
	}

	// Con método SOAP. Usada para IE8
	//function LlamadaAjax(url, methodType, options) {
	//	if (methodType == "SOAP") {
	//		$.ajax({
	//			url: url,
	//			type: "POST",
	//			dataType: "xml",
	//			data: options.data,
	//			complete: function (xhr, status) { $(xhr.responseXML).find('usuario').each(function () { return $(this).find('Name').text(); }); },
	//			contentType: "text/xml; charset=\"utf-8\""
	//		});
	//	} else {
	//		var optionsIncludingAuthentication = {
	//			type: methodType,
	//			beforeSend: function (xhr) {
	//				xhr.setRequestHeader("Authorization", "Session " + ko.utils.parseJson(localStorage.getItem("token")).access_token);
	//			},
	//			error: function (e) {
	//				console.log('Error en la petición a la url ' + url);
	//				console.error(e);
	//			}
	//		};

	//		$.extend(optionsIncludingAuthentication, options);

	//		return response = $.ajax(ApiUrl(server, url), optionsIncludingAuthentication);
	//	}
	//}

	//function MostrarCargando() {
	//	var _cantidad = $('#' + window.ParametrosGlobales.CapaBloqueoCargando).data('cantidad');
	//	if (typeof (_cantidad) === 'undefined' || _cantidad == 0) { _cantidad = 0; $('#' + window.ParametrosGlobales.CapaBloqueoCargando).css('display', 'block'); console.log('Mostrando: ' + window.ParametrosGlobales.CapaBloqueoCargando); }
	//	$('#' + window.ParametrosGlobales.CapaBloqueoCargando).data('cantidad', ++_cantidad);
	//	// OLL: Usar settings.Trace
	//	console.log('Cantidad: ' + _cantidad);
	//	//console.log(new Error().stack);
	//}

	//function OcultarCargando() {
	//	var _cantidad = $('#' + window.ParametrosGlobales.CapaBloqueoCargando).data('cantidad');
	//	if (typeof (_cantidad) === 'undefined' || _cantidad <= 1) { _cantidad = 1; $('#' + window.ParametrosGlobales.CapaBloqueoCargando).css('display', 'none'); console.log('Ocultando: ' + window.ParametrosGlobales.CapaBloqueoCargando); }
	//	$('#' + window.ParametrosGlobales.CapaBloqueoCargando).data('cantidad', --_cantidad);
	//	// OLL: Usar settings.Trace
	//	console.log('Cantidad: ' + _cantidad);
	//	//console.log(new Error().stack);
	//}

	function MostrarCargando(capaBloqueoCargando) {
		var _cantidad = $('#' + capaBloqueoCargando).data('cantidad');
		if (typeof (_cantidad) === 'undefined' || _cantidad == 0) { _cantidad = 0; $('#' + capaBloqueoCargando).css('display', 'block'); /*console.log('Mostrando: ' + capaBloqueoCargando);*/ }
		$('#' + capaBloqueoCargando).data('cantidad', ++_cantidad);
		// OLL: Usar settings.Trace
		//console.log('Mostrando: ' + capaBloqueoCargando + ' - cantidad: ' + _cantidad);
		//console.log(new Error().stack);
	}

	function OcultarCargando(capaBloqueoCargando) {
		var _cantidad = $('#' + capaBloqueoCargando).data('cantidad');
		if (typeof (_cantidad) === 'undefined' || _cantidad <= 1) { _cantidad = 1; $('#' + capaBloqueoCargando).css('display', 'none'); /*console.log('Ocultando: ' + capaBloqueoCargando);*/ }
		$('#' + capaBloqueoCargando).data('cantidad', --_cantidad);
		// OLL: Usar settings.Trace
		//console.log('Ocultando: ' + capaBloqueoCargando + ' - cantidad: ' + _cantidad);
		//console.log(new Error().stack);
	}

	function LlamadaAjax(options) {
		var optionsIncludingAuthentication = {
			beforeSend: function (xhr) {
				//MostrarCargando();
				if (localStorage['token'] != null) { xhr.setRequestHeader('Authorization', 'Session ' + ko.utils.parseJson(localStorage['token']).access_token); }
			},
			error: function (e) {
				if (e.status == 401) {
					// No estamos autorizados a la API. Hacemos logout para volver a conectar
					top.location.href = top.location.origin + top.location.pathname + '/ctl/Logoff';
				} else {
					console.log('Error en la petición a la url ' + options.url);
					console.log(options);
					console.error(e);
				}
			}
		};

		$.extend(optionsIncludingAuthentication, options);
		return response = $.ajax(optionsIncludingAuthentication).always(function () { /*OcultarCargando();*/ });
	}

	function EnviarError(m, u, l) {
		//if (m.indexOf("oF.ScrollTop")) { return false; }
		var error = { Nivel: 0, Mensaje: "[Error][" + new Date() + "]: " + m + (l ? "\nLine: " + l + "\n" : "") + u + "\nBrowser: {" + browserDetect.browser + ", version : " + browserDetect.version + "}", Exception: 3 }
		try { LlamadaAjax(logErrorApi, 'POST', { data: decodeURIComponent($.param(error)) }); } catch (Exception) { }
		return false;
	}
	window.onerror = EnviarError;

	window.Utils = {
		Error: EnviarError,
		Ajax: LlamadaAjax,
		RevisarUrl: function (url) { return url.replace(/\/\//g, '/'); },
		MostrarMensaje: function (placeholderSelector, mensaje, tipo, ocultar) {
			if (typeof (tipo) === 'undefined') { tipo = 'Mensaje'; }
			var _estilo = '';
			switch (tipo) {
				case 'Correcto': _estilo = 'dnnFormSuccess'; break;
				case 'Error': _estilo = 'dnnFormValidationSummary'; break;
				case 'Advertencia': _estilo = 'dnnFormWarning'; break;
				default: _estilo = '';
			}

			$(placeholderSelector).stop();
			$(placeholderSelector).removeClass();
			$(placeholderSelector).addClass('errorLabel dnnFormMessage' + (typeof(_estilo) !== '' ? ' ' + _estilo : '')).html(mensaje);
			$(placeholderSelector).show();

			if (typeof (ocultar) === 'undefined' || ocultar) { $(placeholderSelector).fadeOut(5000, 'easeInExpo', function () { $(placeholderSelector).hide(); }); }
			if (tipo == 'Error') { EnviarError(mensaje); }

			var _mensajes = parametrosGlobales.Mensajes();
			if (_mensajes.length > 0 && _mensajes[_mensajes.length - 1].Tipo == tipo) {
				_mensajes[_mensajes.length - 1].Contenido(_mensajes[_mensajes.length - 1].Contenido() + '<br />' + mensaje);
			} else {
				_mensajes.push({ Contenido: ko.observable(mensaje), Tipo: tipo, Estilo: _estilo });
			}
			parametrosGlobales.Mensajes(_mensajes);
		}/*,
		MostrarMensajeAnt: function (placeholderSelector, mensaje, tipo, ocultar) {
			var messageNode = $("<div/>").addClass('dnnFormMessage' + (typeof (tipo) !== 'undefined' ? ' ' + tipo : '')).text(mensaje);
			$(placeholderSelector).prepend(messageNode);7

			if (typeof (ocultar) === 'undefined' || ocultar) {
				messageNode.fadeOut(9000, 'easeInExpo', function () { messageNode.remove(); });
			}
			if (tipo == 'dnnFormError') { EnviarError(mensaje); }
		}*/,
		FormatearFecha: function (fecha, formatoSalida, formatosEntrada) { return (fecha != null ? moment(fecha, formatosEntrada).format(formatoSalida) : ''); },
		FormatearMoneda: function (moneda, cultura) {
			if (moneda != null) {
				switch (cultura) {
				case 'es-ES':
				case 'ca-ES': return moneda.toFixed(2).toString().replace('.', ',') + ' €';
				case 'en-US': return '$ ' + moneda.toFixed(2).toString();
				}
			} else {
				return '';
			}
		},
		CadenaFormatoFecha: function (fecha, tipo, cultura) {
			switch (tipo) {
				case 'Largo':
					switch (cultura) {
						case 'ca-ES': return 'dddd D [' + ('AEIOU'.indexOf(moment(fecha).format('MMMM').substring(0, 1)) >= 0 ? 'd\'' : 'de ') + ']MMMM';
						case 'en-US': return 'dddd[,] MMMM Do';
						default: return 'dddd D [de] MMMM';
					}
				case 'Corto':
					switch (cultura) {
						case 'en-US': return 'MM/DD/YYYY';
						default: return 'DD/MM/YYYY';
					}
			}
		},
		CadenaFormatoHora: function (hora, tipo, cultura) {
			switch (tipo) {
				case 'Largo': return 'H:mm:ss';
				case 'Corto': return 'H:mm';
			}
		},
		ObtenerUltimoParametroQuerystring: function (ç) {
			var _partes = window.location.href.split('/');
			return _partes[_partes.length - 1].split('?')[0].split('#')[0]; 
		},
		ObtenerParametroUrl: function (parametro) {
			// Buscamos el parámetro en el querystring de la url
			var _results = new RegExp('[\\?&]' + parametro + '=([^&#]*)').exec(window.location.search);
			if (_results == null) {
				// DotNetNuke transforma a veces los parámetros, separándolos por barras. Lo buscamos así.
				_results = new RegExp('[/]' + parametro + '/([^/?]*)').exec(window.location.href);
				return (_results == null ? '' : _results[1]);
			} else {
				return _results[1];
			}
		},
		Cargando: {
			Mostrar: MostrarCargando,
			Ocultar: OcultarCargando
		},
		ObtenerVersionesTablas: function () {
			// OLL: REVISAR CACHE!!!!!
			// OLL: Solo estoy guardando la última versión. Tendría que guardar también las entidades que se han cambiado desde la versión anterior
			// y cuáles de estas he solicitado (y que se han actualizado). Sino, puede ser que la página actual no necesite alguna entidad que ha cambiado
			// y ya no la solicitaría, quedándome con lo que hay en caché.

			// Otro problema es editar una entidad y pedir otra que tiene datos de la primera. estos datos no llegan actualizados ya que lo he pedido la
			// entidad que se ha modificado, sino la relacionada. ¿Como puedo atajar esto? Un GetQuery puede obtener datos de cualquier tabla y no lo sabemos
			// deberíamos tener un método que nos diga que entidades trabaja el GetQuery, un poco feo, la verdad.

			// Asigno null para indicar que no se han recibido aún las tablas
			parametrosGlobales.UltimasVersionesTablas = null;
			// Si se han superado 2 días desde la última descarga, descargamos todo (parámetro VersionAnterior a 0). 
			$.ajax({
				beforeSend: function (xhr) { if (localStorage['token'] != null) { xhr.setRequestHeader('Authorization', 'Session ' + ko.utils.parseJson(localStorage['token']).access_token); } },
				type: "GET",
				url: parametrosGlobales.UrlWebAPI + '/api/Marca/actions/GetQuery?query=Global_ObtenerUltimasVersionesTablas&parameter=VersionAnterior|bigint|' + (typeof (localStorage[parametrosGlobales.Aplicacion + '_UltimaVersionDescargada']) === 'undefined' || typeof (localStorage[parametrosGlobales.Aplicacion + '_UltimaFechaDescargada']) === 'undefined' || Math.round((((new Date() - new Date(parseInt(localStorage[parametrosGlobales.Aplicacion + '_UltimaFechaDescargada']))) % 86400000) % 3600000) / 60000) > 2880 ? 0 : parseInt(localStorage[parametrosGlobales.Aplicacion + '_UltimaVersionDescargada'])),
				cache: false
			}).done(function (ultimasVersionesTablas) {
				if (ultimasVersionesTablas != null) {
					parametrosGlobales.UltimasVersionesTablas = RevisarVersionesTablas(parametrosGlobales.Aplicacion, ultimasVersionesTablas);
				} else {
					// Asigno un arrey vacío para indicar que no hay entidades para actualizar
					parametrosGlobales.UltimasVersionesTablas = [];
					//console.log('No hay tablas actualizadas. Obtener de caché');
				}
			})
		}
	};

	return window.Utils;
});