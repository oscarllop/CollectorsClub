
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class CategoriaCalendario {
	  public CategoriaCalendario() {
			this.Subcategorias = new HashSet<SubcategoriaCalendario>();
			this.RegistrosIdiomas = new HashSet<CategoriaCalendario_Idioma>();
			this.Calendarios = new HashSet<Calendario>();
	  }
	
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<SubcategoriaCalendario> Subcategorias { get; set; }
		public virtual ICollection<CategoriaCalendario_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
		public virtual ICollection<Calendario> Calendarios { get; set; }
	}
}