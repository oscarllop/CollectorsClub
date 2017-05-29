
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class SolicitudContactoModel {
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string CorreoElectronico { get; set; }
		public string Asunto { get; set; }
		public string Contenido { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public string IdMarca { get; set; }
		public MarcaModel Marca { get; set; }
	}
}