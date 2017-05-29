
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Entidad {
	  public Entidad() {
			this.CalendariosPorEntidad = new HashSet<Calendario>();
			this.CalendariosPorEntidadContratante = new HashSet<Calendario>();
			this.RegistrosIdiomas = new HashSet<Entidad_Idioma>();
	  }
	
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Calendario> CalendariosPorEntidad { get; set; }
		public virtual ICollection<Calendario> CalendariosPorEntidadContratante { get; set; }
		public virtual ICollection<Entidad_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
	}
}