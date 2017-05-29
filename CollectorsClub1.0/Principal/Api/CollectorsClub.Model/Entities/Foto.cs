
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Foto {
	  public Foto() {
			this.RegistrosIdiomas = new HashSet<Foto_Idioma>();
	  }
	
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public string NombreArchivoImagen { get; set; }
		public short Orden { get; set; }
		public bool Activa { get; set; }
		public int IdCategoria { get; set; }
		public string Nombre { get; set; }
		public string Descripcion { get; set; }
		public string IdMarca { get; set; }
		public virtual CategoriaFoto Categoria { get; set; }
		public virtual ICollection<Foto_Idioma> RegistrosIdiomas { get; set; }
		public virtual Marca Marca { get; set; }
	}
}