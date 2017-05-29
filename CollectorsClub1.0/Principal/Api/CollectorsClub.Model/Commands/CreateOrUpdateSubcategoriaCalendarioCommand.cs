
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateSubcategoriaCalendarioCommand : ICommand {
			public short Id { get; set; }
			public string Nombre { get; set; }
			public string Codigo { get; set; }
			public string IdMarca { get; set; }
			public short IdCategoria { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> Calendarios { get; set; }
			public ICollection<CreateOrUpdateSubcategoriaCalendario_IdiomaCommand> RegistrosIdiomas { get; set; }
			public CreateOrUpdateMarcaCommand Marca { get; set; }
			public CreateOrUpdateCategoriaCalendarioCommand Categoria { get; set; }
	}
}