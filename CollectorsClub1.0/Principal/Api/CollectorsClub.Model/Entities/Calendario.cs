
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class Calendario {
	  public Calendario() {
			this.RegistrosIdiomas = new HashSet<Calendario_Idioma>();
	  }
	
		public int Id { get; set; }
		public string Nombre { get; set; }
		public short IdTipoColeccion { get; set; }
		public short IdCategoria { get; set; }
		public short IdSubcategoria { get; set; }
		public string Codigo { get; set; }
		public string Anyo { get; set; }
		public string Serie { get; set; }
		public int IdEntidad { get; set; }
		public Nullable<short> NumeroRepetidos { get; set; }
		public string NumeroSerie { get; set; }
		public Nullable<short> IdEstado { get; set; }
		public string DL { get; set; }
		public Nullable<int> IdEntidadContratante { get; set; }
		public string Variante { get; set; }
		public Nullable<int> IdFabricante { get; set; }
		public string PaginaWeb { get; set; }
		public int IdUsuario { get; set; }
		public string Imagen { get; set; }
		public byte[] ImagenEnBinario { get; set; }
		public bool Visible { get; set; }
		public string IdMarca { get; set; }
		public virtual Entidad Entidad { get; set; }
		public virtual Entidad EntidadContratante { get; set; }
		public virtual EstadoCalendario Estado { get; set; }
		public virtual Fabricante Fabricante { get; set; }
		public virtual ICollection<Calendario_Idioma> RegistrosIdiomas { get; set; }
		public virtual TipoColeccionCalendario TipoColeccionCalendario { get; set; }
		public virtual CategoriaCalendario Categoria { get; set; }
		public virtual SubcategoriaCalendario Subcategoria { get; set; }
		public virtual Usuario Usuario { get; set; }
		public virtual Marca Marca { get; set; }
	}
}