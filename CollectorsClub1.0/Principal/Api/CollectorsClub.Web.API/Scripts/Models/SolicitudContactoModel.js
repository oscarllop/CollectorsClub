(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.SolicitudContactoModel = factory(jQuery, MarcaModel);
	}
}(function ($, moment, MarcaModel) {
	function SolicitudContactoModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 150 });
		this.CorreoElectronico = ko.observable().extend({ required: { message: traducciones.get('MensajeError_CorreoElectronico_Text')() }, maxLength: 150 });
		this.Asunto = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Asunto_Text')() }, maxLength: 150 });
		this.Contenido = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Contenido_Text')() }, maxLength: 2147483647 });
		this.FechaAlta = ko.observable().extend({ required: { message: traducciones.get('MensajeError_FechaAlta_Text')() } });
		this.FechaUltimaModificacion = ko.observable();
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	SolicitudContactoModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.CorreoElectronico(item.CorreoElectronico || '');
		this.Asunto(item.Asunto || '');
		this.Contenido(item.Contenido || '');
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.FechaUltimaModificacion(item.FechaUltimaModificacion || null);
		this.IdMarca(item.IdMarca || null);
		if (typeof (item) !== 'undefined' && typeof (item.Marca) === 'object' && item.Marca !== null) {
			if (!ParsedModels.containsKey(item.Marca)) {
				this.Marca(new MarcaModel(item.Marca, traducciones));
			} else {
				this.Marca(ParsedModels.get(item.Marca));
			}
		} else {
			this.Marca(null);
		}
	}

	return SolicitudContactoModel;
}));
