
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class EstadoCalendario_IdiomaModel {
		public int Id { get; set; }
		public short IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public EstadoCalendarioModel Registro { get; set; }
	}
}