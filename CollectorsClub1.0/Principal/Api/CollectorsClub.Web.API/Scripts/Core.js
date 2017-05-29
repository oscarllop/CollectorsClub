var RevisarUrl = function (url) {
	return url.replace(/\/\//g, '/');
}

var logError = function (message, url, line) {
	if (message.indexOf('oF.ScrollTop')) { return false; }
	var error = {
		Nivel: 0,
		Mensaje: '[Error][' + new Date() + ']: ' + message + (line ? '\nLine: ' + line + '\n' : '') + url + '\nBrowser: {' + browserDetect.browser + ', version : ' + browserDetect.version + '}',
		Excepcion: 3
	}

	try {
		ajax(logErrorApi, 'POST', { data: decodeURIComponent($.param(error)) });
	} catch (Exception) {
	}
}
window.onerror = logError;

var llamadaAjax = function (options, contadorRecursividad) {
	var optionsIncludingAuthentication = {
		beforeSend: function (xhr) { xhr.setRequestHeader('Authorization', 'Session ' + ko.utils.parseJson(localStorage['token']).access_token); },
		error: function (e) {
			//contadorRecursividad = (typeof contadorRecursividad !== 'undefined' ? contadorRecursividad : 0);
			// OLL : Revisar recursividad. Antes tenía razón de ser por el bug de Autofac, ahora es correcto reintentar 3 veces? Podemos estar creando registros innecesarios mientras no haya transcaccions
			//if (contadorRecursividad < 3) {
			//	llamadaAjax(options, contadorRecursividad + 1);
			//}
		}
	};

	$.extend(optionsIncludingAuthentication, options);
	return response = $.ajax(optionsIncludingAuthentication);
}

var browserDetect = {
	init: function () {
		this.browser = this.searchString(this.dataBrowser) || 'Other';
		this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || 'Unknown';
	},

	searchString: function (data) {
		for (var i = 0; i < data.length; i++) {
			var dataString = data[i].string;
			this.versionSearchString = data[i].subString;

			if (dataString.indexOf(data[i].subString) != -1) {
				return data[i].identity;
			}
		}
	},

	searchVersion: function (dataString) {
		var index = dataString.indexOf(this.versionSearchString);
		if (index == -1) return;
		return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
	},

	dataBrowser: [
    { string: navigator.userAgent, subString: 'Chrome', identity: 'Chrome' },
    { string: navigator.userAgent, subString: 'MSIE', identity: 'Explorer' },
    { string: navigator.userAgent, subString: 'Firefox', identity: 'Firefox' },
    { string: navigator.userAgent, subString: 'Safari', identity: 'Safari' },
    { string: navigator.userAgent, subString: 'Opera', identity: 'Opera' },
	]
};