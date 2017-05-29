(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/TipoDocumentoUsuariosModel', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/TipoDocumentoUsuariosModel'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.DocumentoUsuariosModel = factory(jQuery, TipoDocumentoUsuariosModel, MarcaModel);
	}
}(function ($, moment, TipoDocumentoUsuariosModel, MarcaModel) {
	function DocumentoUsuariosModel(item) {
		this.Id = ko.observable().extend({ required: { message: 'Indique el campo Id.' } });
		this.Nombre = ko.observable().extend({ required: { message: 'Indique el campo Nombre.' }, maxLength: 255 });
		this.RutaArchivo = ko.observable().extend({ required: { message: 'Indique el campo RutaArchivo.' }, maxLength: 1024 });
		this.Doctype = ko.observable().extend({ maxLength: 255 });
		this.IdMarca = ko.observable().extend({ required: { message: 'Indique el campo IdMarca.' } });
		this.IdTipo = ko.observable().extend({ required: { message: 'Indique el campo IdTipo.' } });
		this.FechaAlta = ko.observable().extend({ required: { message: 'Indique el campo FechaAlta.' } });
		this.UsuarioAlta = ko.observable().extend({ required: { message: 'Indique el campo UsuarioAlta.' }, maxLength: 100 });
		this.FechaEliminacion = ko.observable();
		this.Marca = ko.observable();
		this.Tipo = ko.observable();
		this.AccionesUsuarios = ko.observableArray();
		this.Usuarios = ko.observableArray();

		this.UpdateData(item);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	DocumentoUsuariosModel.prototype.UpdateData = function (item) {
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.RutaArchivo(item.RutaArchivo || '');
		this.Doctype(item.Doctype || null);
		this.IdMarca(item.IdMarca || '');
		this.IdTipo(item.IdTipo || null);
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.UsuarioAlta(item.UsuarioAlta || '');
		this.FechaEliminacion(item.FechaEliminacion || null);
		if (typeof (item) !== 'undefined' && typeof (item.Marca) === 'object' && item.Marca !== null) {
			if (!ParsedModels.containsKey(item.Marca)) {
				ParsedModels.put(item.Marca, '');
				ParsedModels.put(item.Marca, new MarcaModel(item.Marca));
			}
			this.Marca(ParsedModels.get(item.Marca));
		} else {
			this.Marca(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Tipo) === 'object' && item.Tipo !== null) {
			if (!ParsedModels.containsKey(item.Tipo)) {
				ParsedModels.put(item.Tipo, '');
				ParsedModels.put(item.Tipo, new TipoDocumentoUsuariosModel(item.Tipo));
			}
			this.Tipo(ParsedModels.get(item.Tipo));
		} else {
			this.Tipo(null);
		}
		this.AccionesUsuarios(typeof (item) !== 'undefined' && typeof (item.AccionesUsuarios) === 'object' && item.AccionesUsuarios !== null ? $.map(item.AccionesUsuarios, function (registro) { if (!ParsedModels.containsKey(registro)) { ParsedModels.put(item.AccionesUsuarios, ''); ParsedModels.put(registro, new AccionUsuariosModel(registro)); } return ParsedModels.get(registro); }) : []);
		this.Usuarios(typeof (item) !== 'undefined' && typeof (item.Usuarios) === 'object' && item.Usuarios !== null ? $.map(item.Usuarios, function (registro) { if (!ParsedModels.containsKey(registro)) { ParsedModels.put(item.Usuarios, ''); ParsedModels.put(registro, new UsuarioModel(registro)); } return ParsedModels.get(registro); }) : []);
	}

	return DocumentoUsuariosModel;
}));
