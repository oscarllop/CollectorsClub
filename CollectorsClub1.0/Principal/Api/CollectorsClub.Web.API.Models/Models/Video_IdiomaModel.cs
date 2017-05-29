
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class Video_IdiomaModel {
		public int Id { get; set; }
		public int IdRegistro { get; set; }
		public string Cultura { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public string Url { get; set; }
		public VideoModel Registro { get; set; }
	}
}