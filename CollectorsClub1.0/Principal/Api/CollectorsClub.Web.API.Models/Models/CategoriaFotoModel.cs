
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class CategoriaFotoModel {
		public int Id { get; set; }
		public System.DateTime FechaAlta { get; set; }
		public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
		public bool Activa { get; set; }
		public short Orden { get; set; }
		public string Nombre { get; set; }
		public string IdMarca { get; set; }
		public ICollection<CategoriaFoto_IdiomaModel> RegistrosIdiomas { get; set; }
		public ICollection<FotoModel> Fotos { get; set; }
		public MarcaModel Marca { get; set; }
	}
}