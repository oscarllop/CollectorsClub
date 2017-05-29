
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Foto_Idioma {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public virtual Foto Registro { get; set; }
	}
}