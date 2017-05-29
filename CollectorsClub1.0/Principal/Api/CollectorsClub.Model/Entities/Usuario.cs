
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Usuario {
	  public Usuario() {
			this.Calendarios = new HashSet<Calendario>();
	  }
	
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string PrimerApellido { get; set; }
		public string SegundoApellido { get; set; }
		public string NombreDeUsuario { get; set; }
		public string CorreoElectronico { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Calendario> Calendarios { get; set; }
		public virtual Marca Marca { get; set; }
	}
}