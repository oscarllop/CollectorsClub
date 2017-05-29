
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class TipoEvento_Idioma {
		public short Id { get; set; }
		public short IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public virtual TipoEvento Registro { get; set; }
	}
}