
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateUsuarioCommand : ICommand {
			public int Id { get; set; }
			public string Nombre { get; set; }
			public string PrimerApellido { get; set; }
			public string SegundoApellido { get; set; }
			public string NombreDeUsuario { get; set; }
			public string CorreoElectronico { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> Calendarios { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}