(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.CategoriaFotoModel = factory(jQuery, MarcaModel);
	}
}(function ($, moment, MarcaModel) {
	function CategoriaFotoModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.FechaAlta = ko.observable().extend({ required: { message: traducciones.get('MensajeError_FechaAlta_Text')() } });
		this.FechaUltimaModificacion = ko.observable();
		this.Activa = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Activa_Text')() } });
		this.Orden = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Orden_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 150 });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.RegistrosIdiomas = ko.observableArray();
		this.Fotos = ko.observableArray();
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	CategoriaFotoModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.FechaUltimaModificacion(item.FechaUltimaModificacion || null);
		this.Activa(item.Activa || false);
		this.Orden(item.Orden || 0);
		this.Nombre(item.Nombre || '');
		this.IdMarca(item.IdMarca || null);
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CategoriaFoto_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Fotos(typeof (item) !== 'undefined' && typeof (item.Fotos) === 'object' && item.Fotos !== null ? $.map(item.Fotos, function (registro) { if (!ParsedModels.containsKey(registro)) { return new FotoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
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

	return CategoriaFotoModel;
}));
