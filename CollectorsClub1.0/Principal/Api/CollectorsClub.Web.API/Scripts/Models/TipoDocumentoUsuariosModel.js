(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.TipoDocumentoUsuariosModel = factory(jQuery, MarcaModel);
	}
}(function ($, moment, EmpresaModel) {
	function TipoDocumentoUsuariosModel(item) {
		this.Id = ko.observable().extend({ required: { message: 'Indique el campo Id.' } });
		this.Nombre = ko.observable().extend({ required: { message: 'Indique el campo Nombre.' }, maxLength: 50 });
		this.Codigo = ko.observable().extend({ required: { message: 'Indique el campo Codigo.' }, maxLength: 50 });
		this.IdMarca = ko.observable().extend({ required: { message: 'Indique el campo IdMarca.' }, maxLength: 3 });
		this.DocumentosUsuarios = ko.observableArray();
		this.Marca = ko.observable();

		this.UpdateData(item);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	TipoDocumentoUsuariosModel.prototype.UpdateData = function (item) {
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.Codigo(item.Codigo || '');
		this.IdMarca(item.IdMarca || '');
		this.DocumentosUsuarios(typeof (item) !== 'undefined' && typeof (item.DocumentosUsuarios) === 'object' && item.DocumentosUsuarios !== null ? $.map(item.DocumentosUsuarios, function (registro) { if (!ParsedModels.containsKey(registro)) { ParsedModels.put(item.DocumentosUsuarios, ''); ParsedModels.put(registro, new DocumentoUsuariosModel(registro)); } return ParsedModels.get(registro); }) : []);
		if (typeof (item) !== 'undefined' && typeof (item.Marca) === 'object' && item.Marca !== null) {
			if (!ParsedModels.containsKey(item.Marca)) {
				ParsedModels.put(item.Marca, '');
				ParsedModels.put(item.Marca, new MarcaModel(item.Marca));
			}
			this.Marca(ParsedModels.get(item.Marca));
		} else {
			this.Marca(null);
		}
	}

	return TipoDocumentoUsuariosModel;
}));
