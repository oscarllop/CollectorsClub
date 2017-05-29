
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class TipoEvento_IdiomaModel {
		public short Id { get; set; }
		public short IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public TipoEventoModel Registro { get; set; }
	}
}