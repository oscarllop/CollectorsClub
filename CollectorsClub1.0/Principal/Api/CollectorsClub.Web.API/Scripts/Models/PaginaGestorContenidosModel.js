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
	function MarcaModel(item) {
		this.Id = ko.observable().extend({ required: { message: 'Indique el campo Id.' } });
		this.Orden = ko.observable().extend({ required: { message: 'Indique el campo Orden.' } });
		this.Nombre = ko.observable().extend({ required: { message: 'Indique el campo Nombre.' }, maxLength: 500 });
		this.Descripcion = ko.observable().extend({ maxLength: 500 });
		this.Visible = ko.observable().extend({ required: { message: 'Indique el campo Activo.' } });
		this.IdPadre = ko.observable();
		this.AchivoIcono = ko.observable().extend({ maxLength: 255 });
		this.deshabilitado = ko.observable().extend({ required: { message: 'Indique el campo Deshabilitado.' } });
		this.FechaAlta = ko.observable().extend({ required: { message: 'Indique el campo FechaAlta.' } });
		this.FechaModificacion = ko.observable();
		this.Cultura = ko.observable().extend({ required: { message: 'Indique el campo Cultura.' }, maxLength: 5 });
		this.Nivel = ko.observable().extend({ required: { message: 'Indique el campo Nivel.' } });
		this.Url = ko.observable().extend({ required: { message: 'Indique el campo Url.' }, maxLength: 255 });

		this.UpdateData(item);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	MarcaModel.prototype.UpdateData = function (item) {
		this.Id(item.Id || 0);
		this.Orden(item.Orden || 0);
		this.Nombre(item.Nombre || '');
		this.Descripcion(item.Descripcion || '');
		this.Visible(item.Visible || true);
		this.IdPadre(item.IdPadre || null);
		this.AchivoIcono(item.AchivoIcono || null);
		this.Deshabilitado(item.Deshabilitado || false);
		this.FechaAlta(item.FechaAlta || (typeof moment !== 'undefined' ? moment().format() : new Date('01/01/0001 0:00:00')));
		this.FechaModificacion(item.FechaModificacion || null);
		this.Cultura(item.Cultura || '');
		this.Nivel(item.Nivel || 0);
		this.Url(item.Url || '');
	}

	return MarcaModel;
}));
