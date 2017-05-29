(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.EntidadModel = factory(jQuery, MarcaModel);
	}
}(function ($, moment, MarcaModel) {
	function EntidadModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 50 });
		this.Codigo = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Codigo_Text')() }, maxLength: 50 });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.CalendariosPorEntidad = ko.observableArray();
		this.CalendariosPorEntidadContratante = ko.observableArray();
		this.RegistrosIdiomas = ko.observableArray();
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	EntidadModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.Codigo(item.Codigo || '');
		this.IdMarca(item.IdMarca || null);
		this.CalendariosPorEntidad(typeof (item) !== 'undefined' && typeof (item.CalendariosPorEntidad) === 'object' && item.CalendariosPorEntidad !== null ? $.map(item.CalendariosPorEntidad, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.CalendariosPorEntidadContratante(typeof (item) !== 'undefined' && typeof (item.CalendariosPorEntidadContratante) === 'object' && item.CalendariosPorEntidadContratante !== null ? $.map(item.CalendariosPorEntidadContratante, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new Entidad_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
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

	return EntidadModel;
}));
