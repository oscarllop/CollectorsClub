

using AutoMapper;
using CollectorsClub.Model.Commands;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Mappers { 
	public partial class CreateOrUpdateCommandToEntityMappingProfile : Profile {
	  public override string ProfileName {
			get { return "CreateOrUpdateCommandToEntityMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<CreateOrUpdateCalendarioCommand, Calendario>();
			Mapper.CreateMap<CreateOrUpdateCalendario_IdiomaCommand, Calendario_Idioma>();
			Mapper.CreateMap<CreateOrUpdateCategoriaCalendarioCommand, CategoriaCalendario>();
			Mapper.CreateMap<CreateOrUpdateCategoriaCalendario_IdiomaCommand, CategoriaCalendario_Idioma>();
			Mapper.CreateMap<CreateOrUpdateCategoriaFotoCommand, CategoriaFoto>();
			Mapper.CreateMap<CreateOrUpdateCategoriaFoto_IdiomaCommand, CategoriaFoto_Idioma>();
			Mapper.CreateMap<CreateOrUpdateEntidadCommand, Entidad>();
			Mapper.CreateMap<CreateOrUpdateEntidad_IdiomaCommand, Entidad_Idioma>();
			Mapper.CreateMap<CreateOrUpdateEstadoCalendarioCommand, EstadoCalendario>();
			Mapper.CreateMap<CreateOrUpdateEstadoCalendario_IdiomaCommand, EstadoCalendario_Idioma>();
			Mapper.CreateMap<CreateOrUpdateEventoCommand, Evento>();
			Mapper.CreateMap<CreateOrUpdateEvento_IdiomaCommand, Evento_Idioma>();
			Mapper.CreateMap<CreateOrUpdateFabricanteCommand, Fabricante>();
			Mapper.CreateMap<CreateOrUpdateFabricante_IdiomaCommand, Fabricante_Idioma>();
			Mapper.CreateMap<CreateOrUpdateFotoCommand, Foto>();
			Mapper.CreateMap<CreateOrUpdateFoto_IdiomaCommand, Foto_Idioma>();
			Mapper.CreateMap<CreateOrUpdateMarcaCommand, Marca>();
			Mapper.CreateMap<CreateOrUpdateSolicitudContactoCommand, SolicitudContacto>();
			Mapper.CreateMap<CreateOrUpdateSubcategoriaCalendarioCommand, SubcategoriaCalendario>();
			Mapper.CreateMap<CreateOrUpdateSubcategoriaCalendario_IdiomaCommand, SubcategoriaCalendario_Idioma>();
			Mapper.CreateMap<CreateOrUpdateTipoColeccionCalendarioCommand, TipoColeccionCalendario>();
			Mapper.CreateMap<CreateOrUpdateTipoColeccionCalendario_IdiomaCommand, TipoColeccionCalendario_Idioma>();
			Mapper.CreateMap<CreateOrUpdateTipoEventoCommand, TipoEvento>();
			Mapper.CreateMap<CreateOrUpdateTipoEvento_IdiomaCommand, TipoEvento_Idioma>();
			Mapper.CreateMap<CreateOrUpdateUsuarioCommand, Usuario>();
			Mapper.CreateMap<CreateOrUpdateVideoCommand, Video>();
			Mapper.CreateMap<CreateOrUpdateVideo_IdiomaCommand, Video_Idioma>();
		}
	}
}
