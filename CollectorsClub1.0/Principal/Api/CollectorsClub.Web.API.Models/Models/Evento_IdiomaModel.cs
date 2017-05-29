
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class Evento_IdiomaModel {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Ubicacion { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public EventoModel Registro { get; set; }
	}
}