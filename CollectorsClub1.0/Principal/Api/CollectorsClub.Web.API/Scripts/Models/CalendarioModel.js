(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery', 'moment/moment-with-locales.min', 'WebAPI/Models/TipoColeccionCalendarioModel', 'WebAPI/Models/CategoriaCalendarioModel', 'WebAPI/Models/SubcategoriaCalendarioModel', 'WebAPI/Models/EstadoCalendarioModel', 'WebAPI/Models/EntidadModel', 'WebAPI/Models/FabricanteModel', 'WebAPI/Models/UsuarioModel', 'WebAPI/Models/MarcaModel'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'), require('moment/moment-with-locales.min'), require('WebAPI/Models/TipoColeccionCalendarioModel'), require('WebAPI/Models/CategoriaCalendarioModel'), require('WebAPI/Models/SubcategoriaCalendarioModel'), require('WebAPI/Models/EstadoCalendarioModel'), require('WebAPI/Models/EntidadModel'), require('WebAPI/Models/FabricanteModel'), require('WebAPI/Models/UsuarioModel'), require('WebAPI/Models/MarcaModel'));
	} else {
		window.CalendarioModel = factory(jQuery, TipoColeccionCalendarioModel, CategoriaCalendarioModel, SubcategoriaCalendarioModel, EstadoCalendarioModel, EntidadModel, FabricanteModel, UsuarioModel, MarcaModel);
	}
}(function ($, moment, TipoColeccionCalendarioModel, CategoriaCalendarioModel, SubcategoriaCalendarioModel, EstadoCalendarioModel, EntidadModel, FabricanteModel, UsuarioModel, MarcaModel) {
	function CalendarioModel(item, traducciones) {
		this.Id = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Id_Text')() } });
		this.Nombre = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Nombre_Text')() }, maxLength: 50 });
		this.IdTipoColeccion = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdTipoColeccion_Text')() } });
		this.IdCategoria = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdCategoria_Text')() } });
		this.IdSubcategoria = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdSubcategoria_Text')() } });
		this.Codigo = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Codigo_Text')() }, maxLength: 50 });
		this.Anyo = ko.observable().extend({ maxLength: 50 });
		this.Serie = ko.observable().extend({ maxLength: 50 });
		this.IdEntidad = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdEntidad_Text')() } });
		this.NumeroRepetidos = ko.observable();
		this.NumeroSerie = ko.observable().extend({ maxLength: 50 });
		this.IdEstado = ko.observable();
		this.DL = ko.observable().extend({ maxLength: 50 });
		this.IdEntidadContratante = ko.observable();
		this.Variante = ko.observable().extend({ maxLength: 50 });
		this.IdFabricante = ko.observable();
		this.PaginaWeb = ko.observable().extend({ maxLength: 100 });
		this.IdUsuario = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdUsuario_Text')() } });
		this.Imagen = ko.observable().extend({ maxLength: 250 });
		this.ImagenEnBinario = ko.observable().extend({ maxLength: 2147483647 });
		this.Visible = ko.observable().extend({ required: { message: traducciones.get('MensajeError_Visible_Text')() } });
		this.IdMarca = ko.observable().extend({ required: { message: traducciones.get('MensajeError_IdMarca_Text')() }, maxLength: 3 });
		this.Entidad = ko.observable();
		this.EntidadContratante = ko.observable();
		this.Estado = ko.observable();
		this.Fabricante = ko.observable();
		this.RegistrosIdiomas = ko.observableArray();
		this.TipoColeccionCalendario = ko.observable();
		this.Categoria = ko.observable();
		this.Subcategoria = ko.observable();
		this.Usuario = ko.observable();
		this.Marca = ko.observable();

		this.UpdateData(item, traducciones);
		if (typeof (this.ExtendModel) !== 'undefined') { this.ExtendModel(this, item); }
	}

	CalendarioModel.prototype.UpdateData = function (item, traducciones) {
		ParsedModels.put(item, this);
		this.Id(item.Id || 0);
		this.Nombre(item.Nombre || '');
		this.IdTipoColeccion(item.IdTipoColeccion || null);
		this.IdCategoria(item.IdCategoria || null);
		this.IdSubcategoria(item.IdSubcategoria || null);
		this.Codigo(item.Codigo || '');
		this.Anyo(item.Anyo || null);
		this.Serie(item.Serie || null);
		this.IdEntidad(item.IdEntidad || null);
		this.NumeroRepetidos(item.NumeroRepetidos || null);
		this.NumeroSerie(item.NumeroSerie || null);
		this.IdEstado(item.IdEstado || null);
		this.DL(item.DL || null);
		this.IdEntidadContratante(item.IdEntidadContratante || null);
		this.Variante(item.Variante || null);
		this.IdFabricante(item.IdFabricante || null);
		this.PaginaWeb(item.PaginaWeb || null);
		this.IdUsuario(item.IdUsuario || null);
		this.Imagen(item.Imagen || null);
		this.ImagenEnBinario(item.ImagenEnBinario || null);
		this.Visible(item.Visible || false);
		this.IdMarca(item.IdMarca || null);
		if (typeof (item) !== 'undefined' && typeof (item.Entidad) === 'object' && item.Entidad !== null) {
			if (!ParsedModels.containsKey(item.Entidad)) {
				this.Entidad(new EntidadModel(item.Entidad, traducciones));
			} else {
				this.Entidad(ParsedModels.get(item.Entidad));
			}
		} else {
			this.Entidad(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.EntidadContratante) === 'object' && item.EntidadContratante !== null) {
			if (!ParsedModels.containsKey(item.EntidadContratante)) {
				this.EntidadContratante(new EntidadModel(item.EntidadContratante, traducciones));
			} else {
				this.EntidadContratante(ParsedModels.get(item.EntidadContratante));
			}
		} else {
			this.EntidadContratante(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Estado) === 'object' && item.Estado !== null) {
			if (!ParsedModels.containsKey(item.Estado)) {
				this.Estado(new EstadoCalendarioModel(item.Estado, traducciones));
			} else {
				this.Estado(ParsedModels.get(item.Estado));
			}
		} else {
			this.Estado(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Fabricante) === 'object' && item.Fabricante !== null) {
			if (!ParsedModels.containsKey(item.Fabricante)) {
				this.Fabricante(new FabricanteModel(item.Fabricante, traducciones));
			} else {
				this.Fabricante(ParsedModels.get(item.Fabricante));
			}
		} else {
			this.Fabricante(null);
		}
		this.RegistrosIdiomas(typeof (item) !== 'undefined' && typeof (item.RegistrosIdiomas) === 'object' && item.RegistrosIdiomas !== null ? $.map(item.RegistrosIdiomas, function (registro) { if (!ParsedModels.containsKey(registro)) { return new Calendario_IdiomaModel(registro, traducciones); } else { return ParsedModels.get(registro); } }) : []);
		if (typeof (item) !== 'undefined' && typeof (item.TipoColeccionCalendario) === 'object' && item.TipoColeccionCalendario !== null) {
			if (!ParsedModels.containsKey(item.TipoColeccionCalendario)) {
				this.TipoColeccionCalendario(new TipoColeccionCalendarioModel(item.TipoColeccionCalendario, traducciones));
			} else {
				this.TipoColeccionCalendario(ParsedModels.get(item.TipoColeccionCalendario));
			}
		} else {
			this.TipoColeccionCalendario(null);
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
		if (typeof (item) !== 'undefined' && typeof (item.Subcategoria) === 'object' && item.Subcategoria !== null) {
			if (!ParsedModels.containsKey(item.Subcategoria)) {
				this.Subcategoria(new SubcategoriaCalendarioModel(item.Subcategoria, traducciones));
			} else {
				this.Subcategoria(ParsedModels.get(item.Subcategoria));
			}
		} else {
			this.Subcategoria(null);
		}
		if (typeof (item) !== 'undefined' && typeof (item.Usuario) === 'object' && item.Usuario !== null) {
			if (!ParsedModels.containsKey(item.Usuario)) {
				this.Usuario(new UsuarioModel(item.Usuario, traducciones));
			} else {
				this.Usuario(ParsedModels.get(item.Usuario));
			}
		} else {
			this.Usuario(null);
		}
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

	return CalendarioModel;
}));
