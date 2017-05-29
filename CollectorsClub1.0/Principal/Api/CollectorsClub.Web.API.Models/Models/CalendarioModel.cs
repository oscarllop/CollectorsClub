
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class CalendarioModel {
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
		public EntidadModel Entidad { get; set; }
		public EntidadModel EntidadContratante { get; set; }
		public EstadoCalendarioModel Estado { get; set; }
		public FabricanteModel Fabricante { get; set; }
		public ICollection<Calendario_IdiomaModel> RegistrosIdiomas { get; set; }
		public TipoColeccionCalendarioModel TipoColeccionCalendario { get; set; }
		public CategoriaCalendarioModel Categoria { get; set; }
		public SubcategoriaCalendarioModel Subcategoria { get; set; }
		public UsuarioModel Usuario { get; set; }
		public MarcaModel Marca { get; set; }
	}
}