
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Evento_Idioma {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Ubicacion { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public virtual Evento Registro { get; set; }
	}
}