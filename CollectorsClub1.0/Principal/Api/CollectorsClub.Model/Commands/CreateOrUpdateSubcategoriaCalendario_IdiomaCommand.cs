
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateSubcategoriaCalendario_IdiomaCommand : ICommand {
			public int Id { get; set; }
			public short IdRegistro { get; set; }
			public string Cultura { get; set; }
			public string Nombre { get; set; }
			public CreateOrUpdateSubcategoriaCalendarioCommand Registro { get; set; }
	}
}