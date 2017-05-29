
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateTipoColeccionCalendario_IdiomaCommand : ICommand {
			public int Id { get; set; }
			public short IdRegistro { get; set; }
			public string Cultura { get; set; }
			public string Nombre { get; set; }
			public CreateOrUpdateTipoColeccionCalendarioCommand Registro { get; set; }
	}
}