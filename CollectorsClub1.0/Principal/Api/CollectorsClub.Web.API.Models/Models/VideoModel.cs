
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class VideoModel {
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public string Url { get; set; }
		public string IdMarca { get; set; }
		public ICollection<Video_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
	}
}