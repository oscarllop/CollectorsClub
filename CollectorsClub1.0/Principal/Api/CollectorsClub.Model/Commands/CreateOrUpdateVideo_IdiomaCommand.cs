
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateVideo_IdiomaCommand : ICommand {
			public int Id { get; set; }
			public int IdRegistro { get; set; }
			public string Cultura { get; set; }
			public string Nombre { get; set; }
			public string Descripcion { get; set; }
			public string Url { get; set; }
			public CreateOrUpdateVideoCommand Registro { get; set; }
	}
}