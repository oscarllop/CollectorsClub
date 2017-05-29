
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Evento {
	  public Evento() {
			this.RegistrosIdiomas = new HashSet<Evento_Idioma>();
	  }
	
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
		public virtual ICollection<Evento_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
		public virtual TipoEvento Tipo { get; set; }
	}
}