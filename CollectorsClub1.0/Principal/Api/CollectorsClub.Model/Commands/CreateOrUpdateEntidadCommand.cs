
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateEntidadCommand : ICommand {
			public int Id { get; set; }
			public string Nombre { get; set; }
			public string Codigo { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> CalendariosPorEntidad { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> CalendariosPorEntidadContratante { get; set; }
			public ICollection<CreateOrUpdateEntidad_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}