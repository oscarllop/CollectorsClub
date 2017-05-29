
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class MarcaModel {
		public string Id { get; set; }
		public string Nombre { get; set; }
		public ICollection<CalendarioModel> Calendarios { get; set; }
		public ICollection<CategoriaFotoModel> CategoriasFotos { get; set; }
		public ICollection<EntidadModel> Entidades { get; set; }
		public ICollection<EstadoCalendarioModel> EstadosCalendario { get; set; }
		public ICollection<FabricanteModel> Fabricantes { get; set; }
		public ICollection<FotoModel> Fotos { get; set; }
		public ICollection<SolicitudContactoModel> SolicitudesContacto { get; set; }
		public ICollection<SubcategoriaCalendarioModel> SubcategoriasCalendario { get; set; }
		public ICollection<UsuarioModel> Usuarios { get; set; }
		public ICollection<VideoModel> Videos { get; set; }
		public ICollection<EventoModel> Eventos { get; set; }
		public ICollection<TipoEventoModel> TiposEvento { get; set; }
		public ICollection<CategoriaCalendarioModel> CategoriasCalendario { get; set; }
		public ICollection<TipoColeccionCalendarioModel> TiposColeccionCalendario { get; set; }
	}
}