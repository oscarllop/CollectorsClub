
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class CategoriaFoto {
	  public CategoriaFoto() {
			this.RegistrosIdiomas = new HashSet<CategoriaFoto_Idioma>();
			this.Fotos = new HashSet<Foto>();
	  }
	
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public bool Activa { get; set; }
		public short Orden { get; set; }
		public string Nombre { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<CategoriaFoto_Idioma> RegistrosIdiomas { get; set; }
		public virtual ICollection<Foto> Fotos { get; set; }
		public virtual Marca Marca { get; set; }
	}
}