
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateTipoEventoCommand : ICommand {
			public short Id { get; set; }
			public string Nombre { get; set; }
			public string Codigo { get; set; }
			public short Orden { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateEventoCommand> Eventos { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
			public ICollection<CreateOrUpdateTipoEvento_IdiomaCommand> RegistrosIdiomas { get; set; }
	}
}