(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/BaseController', 'WebAPI/Models/FabricanteModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/BaseController'), require('WebAPI/Models/FabricanteModel'));
	} else {
		// Browser globals
		if (typeof (BaseController) == 'undefined') {
			$.when(
				$.getScript(parametrosGlobales.UrlWebAPI + '/scripts/BaseController.js'),
				$.getScript(parametrosGlobales.UrlWebAPI + '/scripts/Models/FabricanteModel.js'),
				$.Deferred(function (deferred) { $(deferred.resolve); })
			).done(function () {
				window.FabricanteController = factory(jQuery, window.GlobalBaseController, FabricanteModel);
			}).fail(function (xhr, status) {
				displayMessage("#InnerContainer", settings.MensajeError + status + xhr.responseText, 'Error');
			});
		} else {
			window.FabricanteController = factory(jQuery, window.GlobalBaseController, FabricanteModel);
		}
	}
}(function ($, moment, baseController, modelo) {
	return function FabricanteController(settings) {
		var self = this;
		self.settings = $.extend({}, settings);
		self.settings.EntitySet = 'Fabricantes';
		self.settings.EntityName = 'Fabricante';
		self.settings.Controller = self;
		self.settings.ApiUrl = settings.UrlWebAPI + '/api/' + self.settings.EntityName;
		self.settings.KeyProperties = ['Id'];
		self.settings.Modelo = modelo;

		self.registrosPrueba = new Array();
		for (i = 1; i <= 15; i++) {
			self.registrosPrueba.push({ 'Id': i, 'Nombre': 'Nombre' + i, 'Codigo': 'Codigo' + i, 'IdMarca': 'IdMarca' + i });
		}

		self.Get = function (observable, options) { baseController.Get(observable, options, self.settings); }
		self.GetQuery = function (observable, options) { baseController.GetQuery(observable, options, self.settings); }
		self.GetExcel = function (options) { baseController.GetExcel(options, self.settings); }
		self.GetPdf = function (registros, options) { baseController.GetPdf(registros, options, self.settings); }
		self.Count = function (observable, options) { baseController.Count(observable, options, self.settings); }
		self.GetPorId = function (observable, registro, options) { baseController.GetPorId(observable, registro, options, self.settings); }
		self.Update = function (observable, registro, options) { baseController.Update(observable, registro, options, self.settings); }
		self.UpdateMany = function (observable, registros, options) { baseController.UpdateMany(observable, registros, options, self.settings); }
		self.Delete = function (observable, registro, options) { baseController.Delete(observable, registro, options, self.settings); }
		self.EsRegistroNuevo = function (registro) { return baseController.EsRegistroNuevo(registro, self.settings); }

		// OLL: pero por ahora no funcionan bien los DescargarScripts, cuando funcionen quitar el registro en el ViewModel
		//baseController.DescargarScripts('Calendario', settings);
		//baseController.DescargarScripts('Fabricante_Idioma', settings);
		//baseController.DescargarScripts('Marca', settings);
		
		baseController.RegisterController(self.settings);
	};
}));
