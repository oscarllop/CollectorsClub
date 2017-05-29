
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Video {
	  public Video() {
			this.RegistrosIdiomas = new HashSet<Video_Idioma>();
	  }
	
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public string Url { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Video_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
	}
}