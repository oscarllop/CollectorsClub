
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class EventoModel {
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public System.DateTime Fecha { get; set; }
		public System.TimeSpan HoraInicio { get; set; }
		public System.TimeSpan HoraFin { get; set; }
		public short IdTipo { get; set; }
		public bool Activa { get; set; }
		public string IdMarca { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public string Ubicacion { get; set; }
		public ICollection<Evento_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
		public TipoEventoModel Tipo { get; set; }
	}
}