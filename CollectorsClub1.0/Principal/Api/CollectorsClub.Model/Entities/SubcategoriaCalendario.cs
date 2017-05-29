
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class SubcategoriaCalendario {
	  public SubcategoriaCalendario() {
			this.Calendarios = new HashSet<Calendario>();
			this.RegistrosIdiomas = new HashSet<SubcategoriaCalendario_Idioma>();
	  }
	
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public short IdCategoria { get; set; }
		public virtual ICollection<Calendario> Calendarios { get; set; }
		public virtual ICollection<SubcategoriaCalendario_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
		public virtual CategoriaCalendario Categoria { get; set; }
	}
}