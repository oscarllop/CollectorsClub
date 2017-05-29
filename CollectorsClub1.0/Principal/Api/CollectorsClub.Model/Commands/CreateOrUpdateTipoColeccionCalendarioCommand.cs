
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateTipoColeccionCalendarioCommand : ICommand {
			public short Id { get; set; }
			public string Nombre { get; set; }
			public string Codigo { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> Calendarios { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
			public ICollection<CreateOrUpdateTipoColeccionCalendario_IdiomaCommand> RegistrosIdiomas { get; set; }
	}
}