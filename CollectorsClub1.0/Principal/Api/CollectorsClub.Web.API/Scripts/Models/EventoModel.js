(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/TipoEventoModel', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/TipoEventoModel'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.EventoModel = factory(jQuery, TipoEventoModel, MarcaModel);
	}
}(function ($, moment, TipoEventoModel, MarcaModel) {
	function EventoModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.FechaAlta = ko.observable().extend({ required: { message: traducciones.get('MensajeError_FechaAlta_Text')() } });
		this.FechaUltimaModificacion = ko.observable();
		this.Fecha = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Fecha_Text')() } });
		this.HoraInicio = ko.observable().extend({ required: { message: traducciones.get('MensajeError_HoraInicio_Text')() } });
		this.HoraFin = ko.observable().extend({ required: { message: traducciones.get('MensajeError_HoraFin_Text')() } });
		this.IdTipo = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdTipo_Text')() } });
		this.Activa = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Activa_Text')() } });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 750 });
		this.Descripcion = ko.observable().extend({ maxLength: 2147483647 });
		this.Ubicacion = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Ubicacion_Text')() }, maxLength: 500 });
		this.RegistrosIdiomas = ko.observableArray();
		this.Marca = ko.observable();
		this.Tipo = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	EventoModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.FechaUltimaModificacion(item.FechaUltimaModificacion || null);
		this.Fecha(typeof (item.Fecha) !== 'undefined' && item.Fecha != null ? moment(item.Fecha).format('YYYY-MM-DD') : null);
		this.HoraInicio(item.HoraInicio || (typeof moment !== 'undefined' ? moment().format() : new Date('00:00:00')));
		this.HoraFin(item.HoraFin || (typeof moment !== 'undefined' ? moment().format() : new Date('00:00:00')));
		this.IdTipo(item.IdTipo || null);
		this.Activa(item.Activa || false);
		this.IdMarca(item.IdMarca || null);
		this.Nombre(item.Nombre || '');
		this.Descripcion(item.Descripcion || null);
		this.Ubicacion(item.Ubicacion || '');
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new Evento_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		if (typeof (item) !== 'undefined' && typeof (item.Marca) === 'object' && item.Marca !== null) {
			if (!ParsedModels.containsKey(item.Marca)) {
				this.Marca(new MarcaModel(item.Marca, traducciones));
			} else {
				this.Marca(ParsedModels.get(item.Marca));
			}
		} else {
			this.Marca(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Tipo) === 'object' && item.Tipo !== null) {
			if (!ParsedModels.containsKey(item.Tipo)) {
				this.Tipo(new TipoEventoModel(item.Tipo, traducciones));
			} else {
				this.Tipo(ParsedModels.get(item.Tipo));
			}
		} else {
			this.Tipo(null);
		}
	}

	return EventoModel;
}));
