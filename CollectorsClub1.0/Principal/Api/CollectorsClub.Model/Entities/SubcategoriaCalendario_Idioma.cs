
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class SubcategoriaCalendario_Idioma {
		public int Id { get; set; }
		public short IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public virtual SubcategoriaCalendario Registro { get; set; }
	}
}