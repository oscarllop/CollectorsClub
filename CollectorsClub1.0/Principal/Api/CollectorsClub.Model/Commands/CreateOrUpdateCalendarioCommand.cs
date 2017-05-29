
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateCalendarioCommand : ICommand {
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
			public CreateOrUpdateEntidadCommand Entidad { get; set; }
			public CreateOrUpdateEntidadCommand EntidadContratante { get; set; }
			public CreateOrUpdateEstadoCalendarioCommand Estado { get; set; }
			public CreateOrUpdateFabricanteCommand Fabricante { get; set; }
			public ICollection<CreateOrUpdateCalendario_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateTipoColeccionCalendarioCommand TipoColeccionCalendario { get; set; }
			public CreateOrUpdateCategoriaCalendarioCommand Categoria { get; set; }
			public CreateOrUpdateSubcategoriaCalendarioCommand Subcategoria { get; set; }
			public CreateOrUpdateUsuarioCommand Usuario { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}