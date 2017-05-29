
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Calendario_Idioma {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public string Variante { get; set; }
		public virtual Calendario Registro { get; set; }
	}
}