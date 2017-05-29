var errorHandler = function(m, u, l) {
	if (m.indexOf("oF.ScrollTop")) { return false; }
	var error = { Nivel: 0, Mensaje: "[Error][" + new Date() + "]: " + m + (l ? "\nLine: " + l + "\n" : "") + u + "\nBrowser: {" + browserDetect.browser + ", version : " + browserDetect.version + "}", Exception: 3 }
	try { ajax(logErrorApi, 'POST', { data: decodeURIComponent($.param(error)) }); } catch (Exception) { }
	return false;
}

var logError = function(m, u, l) {
	if (m.indexOf("oF.ScrollTop")) { return false; }
	var error = { Nivel: 0, Mensaje: "[Error][" + new Date() + "]: " + m + (l ? "\nLine: " + l + "\n" : "") + u + "\nBrowser: {" + browserDetect.browser + ", version : " + browserDetect.version + "}", Exception: 3 }
	try { ajax(logErrorApi, 'POST', { data: decodeURIComponent($.param(error)) }); } catch (Exception) { }

}
// Assign custom method to handle errors
window.onerror = errorHandler;
// generic method to wrap retrieval of stored data
var dbGet = function(key) { /* return $.jStorage.get(key);*/ }
// store to local database
var dbSet = function(key, value) { /*return $.jStorage.set(key, value);*/ }
// remove from local database
var dbRemove = function(key) { /*return $.jStorage.deleteKey(key);*/ }
// remove from both local and remote database
var dbDelete = function(u, k) { dbRemove(k); ajax(u, 'DELETE', { success: function(json) { } }); }
// store locally and remotely, returns the saved object with updated database id
var dbStore = function(u, k, v) {
	dbSet(k, v);
	/* console.debug(value);*/
	ajax(u, (value.Id <= 0) ? "POST" : "PUT", { data: decodeURIComponent($.param(value)), success: function(object) { /*update local store entry, used to update with database id*/dbSet(key, object); } });
}

var ajaxPendingRequests = [];
function endSoap(xmlHttpRequest, status) { $(xmlHttpRequest.responseXML).find('usuario').each(function() { return $(this).find('Name').text(); }); }

// wrap method to add authentication header on each ajax call
var ajax = function(url, methodType, options, contadorRecursividad) {
	contadorRecursividad = typeof contadorRecursividad !== 'undefined' ? contadorRecursividad : 0;
	if (methodType == "SOAP") {
		$.ajax({
			url: url,
			type: "POST",
			dataType: "xml",
			data: options.data,
			complete: endSoap,
			contentType: "text/xml; charset=\"utf-8\""
		});
	} else {
		// default value
		var optionsIncludingAuthentication = {
			type: methodType,
			beforeSend: function(xhr) {
				//temporarily disabled until fixed
				var authenticationToken = ko.utils.parseJson(localStorage.getItem("token")).access_token;
				xhr.setRequestHeader("Authorization", "Session " + authenticationToken);
			},

			error: function(e) {
				//console.log('Can\'t communicate with server\n' + url);
				//ajax(url, methodType, options);
				contadorRecursividad++;
				if (contadorRecursividad < 3) {
					ajax(url, methodType, options, contadorRecursividad);
				}
			}
		};

		$.extend(optionsIncludingAuthentication, options);

		response = $.ajax(apiUrl(server, url), optionsIncludingAuthentication);
		response.success(function(json) {
			// cache GET requests to display them when offline
			if (optionsIncludingAuthentication.type.toLowerCase() == "get") {
				// dbSet(md5(server + url + optionsIncludingAuthentication.data), json);
			}
		});
	}
}

var backgroundJob = function() {
	setTimeout(function() {
		if (ajaxPendingRequests.length > 0) {
			var request = ajaxPendingRequests[0];
			var response = $.ajax(request.url, request.options);
			response.success(function(json) {
				// @TODO: logout if invalid token?
				// logout();
				// remove successful request from pending queue
				ajaxPendingRequests.splice(0, 1);
				dbSet('ajaxPendingRequests', ajaxPendingRequests);
			});
		}
		backgroundJob();
	}, timeout);
}

// get param value from the url querystring
var getParam = function(key) {
	key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
	var regexS = "[\\?&]" + key + "=([^&#]*)",
      regex = new RegExp(regexS),
      results = regex.exec(window.location.href);
	if (results == null) {
		return "";
	} else {
		return decodeURIComponent(results[1].replace(/\+/g, " "));
	}
}


// remove the current session
var logout = function(item, event) {
	// ajax method to logout?
	// on success remove key and redirect
	dbRemove("currentUser"); window.location = logoutUrl; event.preventDefault();
}


//funcion que retorna si es o no númerico
function IsNumeric(n) { return (num >= 0 || num < 0); }

//numeros render con formato ok 0+num hasta < 10 no habrá un 010
function addformatNumber(n, t) { /*var s="0"+num;*/var s = n; /*return s.substr(s.length-t);*/return s; }
function addformatNumber5(n, t) { var s = "0000000" + n; /*var s=num;*/return s.substr(s.length - t); /*return s;*/ }

// returns a well formed url depending on the browser version
// For IE8 & IE9
var apiUrl = function(domain, path) {
	var url = "";
	if (browserDetect.browser == 'Explorer' && browserDetect.version < 10) {
		url = path;
	}
	else {
		url = domain + path;
	}
	return url;
}

function inicializaValidacionPass() { $.each($('html').find('[type=password]'), function(index, value) { /*if (this.id != "discount1" && this.id != "discount2" && this.id != "discount3" && this.id != "discount4") {*/$(this).on('focusout', function() { validainputs(this); }); /*}*/ }); }
function inicializaValidacion() {
	$.each($('html').find('[type=text]'), function(index, value) { /*if (this.id != "discount1" && this.id != "discount2" && this.id != "discount3" && this.id != "discount4") {*/if (!$(this).hasClass("no_validar")) { $(this).on('focusout', function() { validainputs(this); }); } /*}*/ });
	/* $.each($('html').find('[type=checkbox]'), function(index, value) {$(this).on('focusout', function() { validacheck(this); });});*/
	$.each($('html').find('select'), function(index, value) { if (this.id.indexOf("novalidable") != 0) { $(this).on('focusout', function() { validainputs(this); }); } });
}

// Pasamos el id del objeto a verificar, por si hay diferentes capas con diferentes "formularios" en una misma página
function validaFormulario(idObjeto) {
	var formularioCorrecto = true;
	$.each($(idObjeto).find('[type=text]'), function(index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	$.each($(idObjeto).find('textarea'), function(index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	$.each($(idObjeto).find('[type=hidden]'), function(index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	$.each($(idObjeto).find('[type=checkbox]'), function(index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	$.each($(idObjeto).find('[type=password]'), function(index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	$.each($(idObjeto).find('select'), function (index, value) { if (!validainputs(this)) { formularioCorrecto = false; } });
	return formularioCorrecto;
}

function validainputs(self) {
	//Validaciones
	var errorMessage = 'Formato incorrecto.';
	var errorDetectado = false;
	/*-----------------------------------------------------------------------------------------
	/*validar un texto solo texto*/
	if ($(self).hasClass('required-text')) { if ($.trim($(self).val()) == "") { errorDetectado = true; } }
	/*-----------------------------------------------------------------------------------------
	/*validar un texto solo texto*/
	if ($(self).hasClass('required-checkbox')) { if (!$(self).is(':checked')) { errorDetectado = true; } }
	/*-----------------------------------------------------------------------------------------
	Validar un E-mail*/
	if ($(self).hasClass('required-email')) { var RegExPattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/; }
	/*-----------------------------------------------------------------------------------------
	Validar un número de teléfono*/
	if ($(self).hasClass('required-telephone')) { var RegExPattern = /^\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d$/ }
	/*-----------------------------------------------------------------------------------------
	/*Validar código postal*/
	if ($(self).hasClass('required-zipcode')) { var RegExPattern = /(^\d{5}$)|(^\d{5}-\d{4}$)/ }
	// Validar fecha
	if ($(self).hasClass('required-date')) { if (!validaFechaDDMMAAAA($(self).val())) { errorDetectado = true; } }
	if ($(self).hasClass('optional-date')) { if ($(self).val() != "") { if (!validaFechaDDMMAAAA($(self).val())) { errorDetectado = true; } } }
	// Validar hora
	if ($(self).hasClass('required-time')) {
		var RegExPattern = /^(20|21|22|23|[0-1]\d)[:][0-5]\d$/;
		if ($(self).val().indexOf(":") < 0 && parseInt($(self).val()) > -1 && parseInt($(self).val()) < 24) {
			if (parseInt($(self).val()) < 10 && $(self).val().indexOf("0") < 0) {
				$(self).val("0"+$(self).val());
			}
			$(self).val($(self).val() + ":00");
		}
	}
	/*-----------------------------------------------------------------------------------------*/
	if (RegExPattern != undefined) { if ($(self).val() == "" || (RegExPattern.test($(self).val()) == false)) { errorDetectado = true; } }
	if (errorDetectado) { changestyError(self); return false; }
	else { QuitError(self); return true; }
}

function validacheck(self) {
	if ($(self).is(':checked')) {
		QuitError(self);
		return true;
	} else {
		changestyError(self);
		return false;
	}
}
function QuitError(s) { $(s).removeClass('warning'); }
function changestyError(s) { $(s).addClass('warning'); /*setTimeout("quitawarning(" + $(self).attr('id') + ")", 1500);*/ }
function quitawarning(s) { /*$(self).addClass('noticed');*/ }

var browserDetect =
{
	init: function() { this.browser = this.searchString(this.dataBrowser) || "Other"; this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "Unknown"; },
	searchString: function(data) { for (var i = 0; i < data.length; i++) { var dataString = data[i].string; this.versionSearchString = data[i].subString; if (dataString.indexOf(data[i].subString) != -1) { return data[i].identity; } } },
	searchVersion: function(dataString) { var i = dataString.indexOf(this.versionSearchString); if (i == -1) return; return parseFloat(dataString.substring(i + this.versionSearchString.length + 1)); },
	dataBrowser: [{ string: navigator.userAgent, subString: "Chrome", identity: "Chrome" }, { string: navigator.userAgent, subString: "MSIE", identity: "Explorer" }, { string: navigator.userAgent, subString: "Firefox", identity: "Firefox" }, { string: navigator.userAgent, subString: "Safari", identity: "Safari" }, { string: navigator.userAgent, subString: "Opera", identity: "Opera"}]
};

function validaFechaDDMMAAAA(fecha) {
	var dtCh = "/";
	var minYear = 1900;
	var maxYear = 2100;
	function isInteger(s) { for (var i = 0; i < s.length; i++) { var c = s.charAt(i); if (((c < "0") || (c > "9"))) return false; } return true; }
	function stripCharsInBag(s, bag) { var i; var returnString = ""; for (i = 0; i < s.length; i++) { var c = s.charAt(i); if (bag.indexOf(c) == -1) returnString += c; } return returnString; }
	function daysInFebruary(y) { return (((y % 4 == 0) && ((!(y % 100 == 0)) || (y % 400 == 0))) ? 29 : 28); }
	function DaysArray(n) { for (var i = 1; i <= n; i++) { this[i] = 31; if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 } if (i == 2) { this[i] = 29 } } return this; }
	function isDate(dtStr) {
		var daysInMonth = DaysArray(12);
		var pos1 = dtStr.indexOf(dtCh);
		var pos2 = dtStr.indexOf(dtCh, pos1 + 1);
		var strDay = dtStr.substring(0, pos1);
		var strMonth = dtStr.substring(pos1 + 1, pos2);
		var strYear = dtStr.substring(pos2 + 1);
		strYr = strYear;
		if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1);
		if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1);
		for (var i = 1; i <= 3; i++) { if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1); }
		month = parseInt(strMonth);
		day = parseInt(strDay);
		year = parseInt(strYr);
		if (pos1 == -1 || pos2 == -1) { return false; }
		if (strMonth.length < 1 || month < 1 || month > 12) { return false; }
		if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) { return false; }
		if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) { return false; }
		if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) { return false; }
		return true;
	}
	if (isDate(fecha)) { return true; } else { return false; }
}

var hoy = function() { var t = new Date(); var d = t.getDate(); var m = t.getMonth() + 1; /*January is 0!*/var y = t.getFullYear(); if (d < 10) { d = '0' + d } if (m < 10) { m = '0' + m } t = y + '-' + m + '-' + d; return t; }
var estadoLoading = new Object();

// Nueva función de loading. Se le pasa el tipo de operador "+" o "-". Cuando se inicia un proceso de carga se usa "+", cuando
// finaliza el proceso (success de una llamada ajax, por ejemplo) se usa "-".
function loading(operadorLoading, clase) {
	if (clase == undefined) { clase = "divStandBy"; }
	eval("if(estadoLoading." + clase + "==undefined){estadoLoading." + clase + "=0;}");
	if (operadorLoading == "+") { eval("estadoLoading." + clase + "++;"); }
	else { eval("estadoLoading." + clase + "--;"); }
	if (eval("estadoLoading." + clase) > 0) { $('.' + clase).css('display', 'block'); $('.' + clase).css('z-index', '10057000'); }
	else { $('.' + clase).css('display', 'none'); }
}

// Convierte una fecha en formato dd/mm/yyyy a tipo Date
function convertStringToDate(stringDate) { var a = stringDate.split("/"); return new Date(a[2], a[1] - 1, a[0]); }
function crearIframeDescargaArchivo(url) {
	if ($('#frameDescargaArchivo').length > 0) { $('#frameDescargaArchivo').remove(); }
	$('<iframe />', { name: 'frameDescargaArchivo', id: 'frameDescargaArchivo' }).appendTo('body');
	$('#frameDescargaArchivo').css('display', "none");
	$('#frameDescargaArchivo').attr('src', url);
}

function DatosKnockout() {
	this.datos = ko.observableArray();
	this.oldDatos = null;
	this.getDataUrl = null;
	this.Binding = function(html) { if ($(html).length > 0) ko.applyBindings(this, $(html)[0]); };
	this.RecogerDatos = function(Url, Data, Method, Succes, Error) { var _s = this; loading("+"); ajax(Url, Method, { dataType: "json", data: Data, async: true, context: this, success: function(d) { _s.datos(Succes(dojox.json.ref.fromJson(dojox.json.ref.toJson(d), { idAttribute: '$id' }))); return d; }, complete: function() { loading("-"); }, error: function() { Error(); } }); return _s; };
	this.RecogerDatosSync = function(Url, Data, Method, Succes, Error) { var _s = this; loading("+"); ajax(Url, Method, { dataType: "json", data: Data, async: false, context: this, success: function(d) { _s.datos(Succes(dojox.json.ref.fromJson(dojox.json.ref.toJson(d), { idAttribute: '$id' }))); return d; }, complete: function() { loading("-"); }, error: function() { Error(); } }); return _s; };
	this.RecogerDatosComplete = function(Url, Data, Method, Succes, Error, Complete) { var _s = this; loading("+"); ajax(Url, Method, { dataType: "json", data: Data, async: true, context: this, success: function(d) { _s.datos(Succes(dojox.json.ref.fromJson(dojox.json.ref.toJson(d), { idAttribute: '$id' }))); return d; }, complete: function() { Complete(); loading("-"); }, error: function() { Error(); } }); return this; };
	this.Add = function(t, d) { var _t = this.datos(); _t[t] = d; this.datos(_t); }
	this.Limpiar = function() { this.oldDatos = this.datos(); this.datos([]); return this; };
	this.Copiar = function() { var _t = new DatosKnockout(); _t.datos(this.datos()); return _t; };
	return this;
}

function GridValoresServidor(url, parametos, nombreCabeceraOrdenacion) {
	this.datos = ko.observableArray([]);
	this.nombreExcel = "ListadoMatriculas";
	this.pasoEntreDatos = 10;
	this.ultimoPaso = 0;
	this.Ordenacion = ko.observable('');
	this.TipoOrdenacion = ko.observable('');
	this.NumRows = ko.observable(0);
	this.urlDatos = url;
	this.masDatos = ko.observable(true);
	this.parametros = parametos;
	this.nombreCabeceraOrdenacion = nombreCabeceraOrdenacion;
	this.MostrarMas = function() {
		if (this.masDatos() == true) {
			var _p = new DatosKnockout(); var _s = this;
			//var _params = this.parametros + '&parameter=Orden|nvarchar|' + this.Ordenacion() + '&parameter=RegistroInicial|int|' + this.ultimoPaso + '&parameter=RegistroFinal|int|' + (this.ultimoPaso + this.pasoEntreDatos);
			var _params = this.parametros + '&parameter=Orden|nvarchar|' + this.Ordenacion() + '&parameter=TipoOrden|int|' + this.TipoOrdenacion() + '&parameter=RegistroInicial|int|' + this.ultimoPaso + '&parameter=RegistroFinal|int|' + (this.ultimoPaso + this.pasoEntreDatos);
			_p.RecogerDatos(this.urlDatos + "?" + _params, "", "GET", function(d) { _m = _s.datos(); for (a in d) { _m.push(d[a]); } _s.ultimoPaso = _m.length; _s.datos(_m); if (d == null || d.length < _s.pasoEntreDatos) { _s.masDatos(false); } return d; }, function() { });
		}
		try{ this.NumRows = datos[0].NumRows; }catch( Exception ) { this.NumRows = 0;}
	}
	this.Ordenar = function(valor) {
		this.datos([]);
		this.ultimoPaso = 0;
		this.masDatos(true);
		this.Ordenacion(valor);
		if (this.TipoOrdenacion() == '' || this.TipoOrdenacion() == 2) { this.TipoOrdenacion(1); }
		else { this.TipoOrdenacion(2); }
		this.MostrarMas();
		$(".CabecerasListado").removeClass("tituloOrdenacion");
		$("#" + this.nombreCabeceraOrdenacion + valor).addClass("tituloOrdenacion");
	}
	this.ExportarAExcel = function() {
		var _partialData = new DatosKnockout();
		var _s = this;
		var _params = this.parametros + '&parameter=Orden|nvarchar|' + this.Ordenacion() + '&parameter=TipoOrden|int|' + this.TipoOrdenacion() + '&parameter=RegistroInicial|int|&parameter=RegistroFinal|int|&tipoRetorno=2';
		loading("+");
		ajax(this.urlDatos, "GET", { dataType: "json", data: _params, async: true, context: this, success: function(d) { crearIframeDescargaArchivo(urls.ObtenerArchivo + '?rutaArchivo=' + d + '&nombre=' + _s.nombreExcel); }, complete: function() { loading("-"); }, error: function() { } });
	}
	this.Binding = function(h) { if ($(h).length > 0) { ko.applyBindings(this, $(h)[0]) } };
	this.MostrarMas();
	this.GetNumRows = function() {
		var self = this;
		if (self.datos() != undefined && self.datos().length > 0) {
			if (self.datos[0].NumRows == undefined) { return 0; } else { return self.datos[0].NumRows; }
		}
		else
			return 0;
	}
}

function GridValores(_datos, nombreCabeceraOrdenacion) {
	this.datos = ko.observableArray(_datos);
	this.datosMostrados = ko.observableArray();
	this.pasoEntreDatos = 10;
	this.valoresParaOrdenar = ko.observable({});
	this.ComprobarMasDatos = ko.observable(true);
	this.nombreCabeceraOrdenacion = nombreCabeceraOrdenacion;
	if (_datos != undefined && _datos.length > 0) {
		for (var p in _datos[0]) { this.valoresParaOrdenar()[p] = ''; }
	}
	this.MostrarMas = function() {
		if (this.datos().length <= this.pasoEntreDatos + this.datosMostrados().length) { this.datosMostrados(this.datos()); this.ComprobarMasDatos(false); }
		else {
			var max = this.datosMostrados().length + this.pasoEntreDatos;
			var min = this.datosMostrados().length;
			for (var i = min; i < max; i++) { var array = this.datosMostrados(); array.push(this.datos()[i]); this.datosMostrados(array); }
			this.ComprobarMasDatos(true);
		}
	}
	this.Ordenar = function(v) {
		var _o = 'ASC'; var _t = this.valoresParaOrdenar();
		if (_t[v] == '' || _t[v] == 'orden_desc') { for (i in _t) { _t[i] = ''; } _t[v] = 'orden_asc'; } else { for (i in _t) { _t[i] = ''; } _t[v] = 'orden_desc'; _o = 'DESC'; }
		var _m = this.datos();
		_m.sort(function(a, b) {
			var c = null; if (a[v] == null && b[v] == null) { c = 0; } if (a[v] == null && b[v] != null) { c = (_o == "ASC" ? -1 : 1); }
			if (a[v] != null && b[v] == null) { c = (_o == "ASC" ? 1 : -1); } if (a[v] >= b[v]) { c = (_o == "ASC" ? 1 : -1); } if (a[v] < b[v]) { c = (_o == "ASC" ? -1 : 1); } if (a[v] == b[v]) { c = 0; } return c;
		});
		this.datos(_m);
		this.valoresParaOrdenar(_t);
		var max = this.datosMostrados().length;
		this.datosMostrados([]);
		for (var i = 0; i < max; i++) { var array = this.datosMostrados(); array.push(this.datos()[i]); this.datosMostrados(array); }
		$(".CabecerasListado").removeClass("tituloOrdenacion");
		$("#" + this.nombreCabeceraOrdenacion + v).addClass("tituloOrdenacion");
	};
	this.Binding = function(h) { if ($(h).length > 0) ko.applyBindings(this, $(h)[0]); };
}

function PlegarODesplegar(id) {
	if ($("#" + id).is(":hidden")) {
		$("#" + id).slideDown();
	} else {
		$("#" + id).slideUp();
	}
}

function Max(a, b) { return a < b ? b : a; }