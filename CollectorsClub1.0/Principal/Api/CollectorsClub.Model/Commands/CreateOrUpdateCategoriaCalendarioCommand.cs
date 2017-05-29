
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateCategoriaCalendarioCommand : ICommand {
			public short Id { get; set; }
			public string Nombre { get; set; }
			public string Codigo { get; set; }
			public string IdMarca { get; set; }
			public ICollection<CreateOrUpdateSubcategoriaCalendarioCommand> Subcategorias { get; set; }
			public ICollection<CreateOrUpdateCategoriaCalendario_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> Calendarios { get; set; }
	}
}