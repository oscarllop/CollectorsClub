
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateTipoEvento_IdiomaCommand : ICommand {
			public short Id { get; set; }
			public short IdRegistro { get; set; }
			public string Cultura { get; set; }
			public string Nombre { get; set; }
			public CreateOrUpdateTipoEventoCommand Registro { get; set; }
	}
}