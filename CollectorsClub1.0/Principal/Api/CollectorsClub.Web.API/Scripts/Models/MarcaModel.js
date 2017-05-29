(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'));
	} else {
		window.MarcaModel = factory(jQuery);
	}
}(function ($, moment) {
	function MarcaModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() }, maxLength: 3 });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 50 });
		this.Calendarios = ko.observableArray();
		this.CategoriasFotos = ko.observableArray();
		this.Entidades = ko.observableArray();
		this.EstadosCalendario = ko.observableArray();
		this.Fabricantes = ko.observableArray();
		this.Fotos = ko.observableArray();
		this.SolicitudesContacto = ko.observableArray();
		this.SubcategoriasCalendario = ko.observableArray();
		this.Usuarios = ko.observableArray();
		this.Videos = ko.observableArray();
		this.Eventos = ko.observableArray();
		this.TiposEvento = ko.observableArray();
		this.CategoriasCalendario = ko.observableArray();
		this.TiposColeccionCalendario = ko.observableArray();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	MarcaModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || '');
		this.Nombre(item.Nombre || '');
		this.Calendarios(typeof (item) !== 'undefined' && typeof (item.Calendarios) === 'object' && item.Calendarios !== null ? $.map(item.Calendarios, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.CategoriasFotos(typeof (item) !== 'undefined' && typeof (item.CategoriasFotos) === 'object' && item.CategoriasFotos !== null ? $.map(item.CategoriasFotos, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CategoriaFotoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Entidades(typeof (item) !== 'undefined' && typeof (item.Entidades) === 'object' && item.Entidades !== null ? $.map(item.Entidades, function (registro) { if (!ParsedModels.containsKey(registro)) { return new EntidadModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.EstadosCalendario(typeof (item) !== 'undefined' && typeof (item.EstadosCalendario) === 'object' && item.EstadosCalendario !== null ? $.map(item.EstadosCalendario, function (registro) { if (!ParsedModels.containsKey(registro)) { return new EstadoCalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Fabricantes(typeof (item) !== 'undefined' && typeof (item.Fabricantes) === 'object' && item.Fabricantes !== null ? $.map(item.Fabricantes, function (registro) { if (!ParsedModels.containsKey(registro)) { return new FabricanteModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Fotos(typeof (item) !== 'undefined' && typeof (item.Fotos) === 'object' && item.Fotos !== null ? $.map(item.Fotos, function (registro) { if (!ParsedModels.containsKey(registro)) { return new FotoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.SolicitudesContacto(typeof (item) !== 'undefined' && typeof (item.SolicitudesContacto) === 'object' && item.SolicitudesContacto !== null ? $.map(item.SolicitudesContacto, function (registro) { if (!ParsedModels.containsKey(registro)) { return new SolicitudContactoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.SubcategoriasCalendario(typeof (item) !== 'undefined' && typeof (item.SubcategoriasCalendario) === 'object' && item.SubcategoriasCalendario !== null ? $.map(item.SubcategoriasCalendario, function (registro) { if (!ParsedModels.containsKey(registro)) { return new SubcategoriaCalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Usuarios(typeof (item) !== 'undefined' && typeof (item.Usuarios) === 'object' && item.Usuarios !== null ? $.map(item.Usuarios, function (registro) { if (!ParsedModels.containsKey(registro)) { return new UsuarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Videos(typeof (item) !== 'undefined' && typeof (item.Videos) === 'object' && item.Videos !== null ? $.map(item.Videos, function (registro) { if (!ParsedModels.containsKey(registro)) { return new VideoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.Eventos(typeof (item) !== 'undefined' && typeof (item.Eventos) === 'object' && item.Eventos !== null ? $.map(item.Eventos, function (registro) { if (!ParsedModels.containsKey(registro)) { return new EventoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.TiposEvento(typeof (item) !== 'undefined' && typeof (item.TiposEvento) === 'object' && item.TiposEvento !== null ? $.map(item.TiposEvento, function (registro) { if (!ParsedModels.containsKey(registro)) { return new TipoEventoModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.CategoriasCalendario(typeof (item) !== 'undefined' && typeof (item.CategoriasCalendario) === 'object' && item.CategoriasCalendario !== null ? $.map(item.CategoriasCalendario, function (registro) { if (!ParsedModels.containsKey(registro)) { return new CategoriaCalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		this.TiposColeccionCalendario(typeof (item) !== 'undefined' && typeof (item.TiposColeccionCalendario) === 'object' && item.TiposColeccionCalendario !== null ? $.map(item.TiposColeccionCalendario, function (registro) { if (!ParsedModels.containsKey(registro)) { return new TipoColeccionCalendarioModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
	}

	return MarcaModel;
}));
