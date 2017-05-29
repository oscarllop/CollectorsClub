
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class FotoModel {
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
		public CategoriaFotoModel Categoria { get; set; }
		public ICollection<Foto_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
	}
}