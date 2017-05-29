
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateVideoCommand : ICommand {
			public int Id { get; set; }
			public System.DateTime FechaAlta { get; set; }
			public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
			public string Nombre { get; set; }
			public string Descripcion { get; set; }
			public string Url { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateVideo_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}