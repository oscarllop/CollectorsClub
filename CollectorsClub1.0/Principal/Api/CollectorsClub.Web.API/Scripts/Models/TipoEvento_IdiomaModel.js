(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/TipoEventoModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/TipoEventoModel'));
	} else {
		window.TipoEvento_IdiomaModel = factory(jQuery, TipoEventoModel);
	}
}(function ($, moment, TipoEventoModel) {
	function TipoEvento_IdiomaModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.IdRegistro = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdRegistro_Text')() } });
		this.Cultura = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Cultura_Text')() }, maxLength: 5 });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 250 });
		this.Registro = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	TipoEvento_IdiomaModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.IdRegistro(item.IdRegistro || null);
		this.Cultura(item.Cultura || '');
		this.Nombre(item.Nombre || '');
		if (typeof (item) !== 'undefined' && typeof (item.Registro) === 'object' && item.Registro !== null) {
			if (!ParsedModels.containsKey(item.Registro)) {
				this.Registro(new TipoEventoModel(item.Registro, traducciones));
			} else {
				this.Registro(ParsedModels.get(item.Registro));
			}
		} else {
			this.Registro(null);
		}
	}

	return TipoEvento_IdiomaModel;
}));
