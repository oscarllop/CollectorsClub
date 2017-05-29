
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Commands {
	
	public partial class CreateOrUpdateMarcaCommand : ICommand {
			public string Id { get; set; }
			public string Nombre { get; set; }
			public ICollection<CreateOrUpdateCalendarioCommand> Calendarios { get; set; }
			public ICollection<CreateOrUpdateCategoriaFotoCommand> CategoriasFotos { get; set; }
			public ICollection<CreateOrUpdateEntidadCommand> Entidades { get; set; }
			public ICollection<CreateOrUpdateEstadoCalendarioCommand> EstadosCalendario { get; set; }
			public ICollection<CreateOrUpdateFabricanteCommand> Fabricantes { get; set; }
			public ICollection<CreateOrUpdateFotoCommand> Fotos { get; set; }
			public ICollection<CreateOrUpdateSolicitudContactoCommand> SolicitudesContacto { get; set; }
			public ICollection<CreateOrUpdateSubcategoriaCalendarioCommand> SubcategoriasCalendario { get; set; }
			public ICollection<CreateOrUpdateUsuarioCommand> Usuarios { get; set; }
			public ICollection<CreateOrUpdateVideoCommand> Videos { get; set; }
			public ICollection<CreateOrUpdateEventoCommand> Eventos { get; set; }
			public ICollection<CreateOrUpdateTipoEventoCommand> TiposEvento { get; set; }
			public ICollection<CreateOrUpdateCategoriaCalendarioCommand> CategoriasCalendario { get; set; }
			public ICollection<CreateOrUpdateTipoColeccionCalendarioCommand> TiposColeccionCalendario { get; set; }
	}
}