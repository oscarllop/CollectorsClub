
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateEventoCommand : ICommand {
			public int Id { get; set; }
			public System.DateTime FechaAlta { get; set; }
			public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
			public System.DateTime Fecha { get; set; }
			public System.TimeSpan HoraInicio { get; set; }
			public System.TimeSpan HoraFin { get; set; }
			public short IdTipo { get; set; }
			public bool Activa { get; set; }
			public string IdMarca { get; set; }
			public string Nombre { get; set; }
			public string Descripcion { get; set; }
			public string Ubicacion { get; set; }
			public ICollection<CreateOrUpdateEvento_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
			public CreateOrUpdateTipoEventoCommand Tipo { get; set; }
	}
}