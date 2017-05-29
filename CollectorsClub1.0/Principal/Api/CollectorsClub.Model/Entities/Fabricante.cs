
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Fabricante {
	  public Fabricante() {
			this.Calendarios = new HashSet<Calendario>();
			this.RegistrosIdiomas = new HashSet<Fabricante_Idioma>();
	  }
	
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Calendario> Calendarios { get; set; }
		public virtual ICollection<Fabricante_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
	}
}