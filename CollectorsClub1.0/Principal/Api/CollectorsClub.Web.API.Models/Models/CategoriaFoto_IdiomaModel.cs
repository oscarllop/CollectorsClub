
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class CategoriaFoto_IdiomaModel {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public CategoriaFotoModel Registro { get; set; }
	}
}