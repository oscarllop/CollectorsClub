(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/CategoriaFotoModel', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/CategoriaFotoModel'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.FotoModel = factory(jQuery, CategoriaFotoModel, MarcaModel);
	}
}(function ($, moment, CategoriaFotoModel, MarcaModel) {
	function FotoModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.FechaAlta = ko.observable().extend({ required: { message: traducciones.get('MensajeError_FechaAlta_Text')() } });
		this.FechaUltimaModificacion = ko.observable();
		this.NombreArchivoImagen = ko.observable().extend({ required: { message: traducciones.get('MensajeError_NombreArchivoImagen_Text')() }, maxLength: 150 });
		this.Orden = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Orden_Text')() } });
		this.Activa = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Activa_Text')() } });
		this.IdCategoria = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdCategoria_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 750 });
		this.Descripcion = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Descripcion_Text')() }, maxLength: 2147483647 });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.Categoria = ko.observable();
		this.RegistrosIdiomas = ko.observableArray();
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	FotoModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.FechaUltimaModificacion(item.FechaUltimaModificacion || null);
		this.NombreArchivoImagen(item.NombreArchivoImagen || '');
		this.Orden(item.Orden || 0);
		this.Activa(item.Activa || false);
		this.IdCategoria(item.IdCategoria || null);
		this.Nombre(item.Nombre || '');
		this.Descripcion(item.Descripcion || '');
		this.IdMarca(item.IdMarca || null);
		if (typeof (item) !== 'undefined' && typeof (item.Categoria) === 'object' && item.Categoria !== null) {
			if (!ParsedModels.containsKey(item.Categoria)) {
				this.Categoria(new CategoriaFotoModel(item.Categoria, traducciones));
			} else {
				this.Categoria(ParsedModels.get(item.Categoria));
			}
		} else {
			this.Categoria(null);
		}
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new Foto_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
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

	return FotoModel;
}));
