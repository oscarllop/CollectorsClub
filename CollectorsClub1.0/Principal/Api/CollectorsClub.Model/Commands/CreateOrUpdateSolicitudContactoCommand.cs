
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateSolicitudContactoCommand : ICommand {
			public int Id { get; set; }
			public string Nombre { get; set; }
			public string CorreoElectronico { get; set; }
			public string Asunto { get; set; }
			public string Contenido { get; set; }
			public System.DateTime FechaAlta { get; set; }
			public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
			public string IdMarca { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
	}
}