
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateCategoriaFotoCommand : ICommand {
			public int Id { get; set; }
			public System.DateTime FechaAlta { get; set; }
			public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
			public bool Activa { get; set; }
			public short Orden { get; set; }
			public string Nombre { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateCategoriaFoto_IdiomaCommand> RegistrosIdiomas { get; set; }
			public ICollection<CreateOrUpdateFotoCommand> Fotos { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}