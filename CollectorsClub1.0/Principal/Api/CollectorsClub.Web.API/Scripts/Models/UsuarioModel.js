(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.UsuarioModel = factory(jQuery, MarcaModel);
	}
}(function ($, moment, MarcaModel) {
	function UsuarioModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 50 });
		this.PrimerApellido = ko.observable().extend({ required: { message: traducciones.get('MensajeError_PrimerApellido_Text')() }, maxLength: 50 });
		this.SegundoApellido = ko.observable().extend({ required: { message: traducciones.get('MensajeError_SegundoApellido_Text')() }, maxLength: 50 });
		this.NombreDeUsuario = ko.observable().extend({ required: { message: traducciones.get('MensajeError_NombreDeUsuario_Text')() }, maxLength: 150 });
		this.CorreoElectronico = ko.observable().extend({ required: { message: traducciones.get('MensajeError_CorreoElectronico_Text')() }, maxLength: 150 });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.Calendarios = ko.observableArray();
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	UsuarioModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.PrimerApellido(item.PrimerApellido || '');
		this.SegundoApellido(item.SegundoApellido || '');
		this.NombreDeUsuario(item.NombreDeUsuario || '');
		this.CorreoElectronico(item.CorreoElectronico || '');
		this.IdMarca(item.IdMarca || null);
		this.Calendarios(typeof (item) !== 'undefined' && typeof (item.Calendarios) === 'object' && item.Calendarios !== null ? $.map(item.Calendarios, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
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

	return UsuarioModel;
}));
