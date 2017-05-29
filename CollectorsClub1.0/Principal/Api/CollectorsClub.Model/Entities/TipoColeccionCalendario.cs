
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class TipoColeccionCalendario {
	  public TipoColeccionCalendario() {
			this.Calendarios = new HashSet<Calendario>();
			this.RegistrosIdiomas = new HashSet<TipoColeccionCalendario_Idioma>();
	  }
	
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Calendario> Calendarios { get; set; }
		public virtual Marca Marca { get; set; }
		public virtual ICollection<TipoColeccionCalendario_Idioma> RegistrosIdiomas { get; set; }
	}
}