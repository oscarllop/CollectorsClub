(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/CategoriaCalendarioModel', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/CategoriaCalendarioModel'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.SubcategoriaCalendarioModel = factory(jQuery, CategoriaCalendarioModel, MarcaModel);
	}
}(function ($, moment, CategoriaCalendarioModel, MarcaModel) {
	function SubcategoriaCalendarioModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 50 });
		this.Codigo = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Codigo_Text')() }, maxLength: 50 });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.IdCategoria = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdCategoria_Text')() } });
		this.Calendarios = ko.observableArray();
		this.RegistrosIdiomas = ko.observableArray();
		this.Marca = ko.observable();
		this.Categoria = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	SubcategoriaCalendarioModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.Codigo(item.Codigo || '');
		this.IdMarca(item.IdMarca || null);
		this.IdCategoria(item.IdCategoria || null);
		this.Calendarios(typeof (item) !== 'undefined' && typeof (item.Calendarios) === 'object' && item.Calendarios !== null ? $.map(item.Calendarios, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new SubcategoriaCalendario_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		if (typeof (item) !== 'undefined' && typeof (item.Marca) === 'object' && item.Marca !== null) {
			if (!ParsedModels.containsKey(item.Marca)) {
				this.Marca(new MarcaModel(item.Marca, traducciones));
			} else {
				this.Marca(ParsedModels.get(item.Marca));
			}
		} else {
			this.Marca(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Categoria) === 'object' && item.Categoria !== null) {
			if (!ParsedModels.containsKey(item.Categoria)) {
				this.Categoria(new CategoriaCalendarioModel(item.Categoria, traducciones));
			} else {
				this.Categoria(ParsedModels.get(item.Categoria));
			}
		} else {
			this.Categoria(null);
		}
	}

	return SubcategoriaCalendarioModel;
}));
