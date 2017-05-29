(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/EventoModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/EventoModel'));
	} else {
		window.Evento_IdiomaModel = factory(jQuery, EventoModel);
	}
}(function ($, moment, EventoModel) {
	function Evento_IdiomaModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.IdRegistro = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdRegistro_Text')() } });
		this.Cultura = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Cultura_Text')() }, maxLength: 5 });
		this.Ubicacion = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Ubicacion_Text')() }, maxLength: 500 });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 750 });
		this.Descripcion = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Descripcion_Text')() }, maxLength: 2147483647 });
		this.Registro = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	Evento_IdiomaModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.IdRegistro(item.IdRegistro || null);
		this.Cultura(item.Cultura || '');
		this.Ubicacion(item.Ubicacion || '');
		this.Nombre(item.Nombre || '');
		this.Descripcion(item.Descripcion || '');
		if (typeof (item) !== 'undefined' && typeof (item.Registro) === 'object' && item.Registro !== null) {
			if (!ParsedModels.containsKey(item.Registro)) {
				this.Registro(new EventoModel(item.Registro, traducciones));
			} else {
				this.Registro(ParsedModels.get(item.Registro));
			}
		} else {
			this.Registro(null);
		}
	}

	return Evento_IdiomaModel;
}));
