

using AutoMapper;
using CollectorsClub.Model.Commands;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Mappers { 
	public partial class EntityToCreateOrUpdateCommandMappingProfile : Profile {
	  public override string ProfileName {
			get { return "EntityToCreateOrUpdateCommandMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<Calendario, CreateOrUpdateCalendarioCommand>();
			Mapper.CreateMap<Calendario_Idioma, CreateOrUpdateCalendario_IdiomaCommand>();
			Mapper.CreateMap<CategoriaCalendario, CreateOrUpdateCategoriaCalendarioCommand>();
			Mapper.CreateMap<CategoriaCalendario_Idioma, CreateOrUpdateCategoriaCalendario_IdiomaCommand>();
			Mapper.CreateMap<CategoriaFoto, CreateOrUpdateCategoriaFotoCommand>();
			Mapper.CreateMap<CategoriaFoto_Idioma, CreateOrUpdateCategoriaFoto_IdiomaCommand>();
			Mapper.CreateMap<Entidad, CreateOrUpdateEntidadCommand>();
			Mapper.CreateMap<Entidad_Idioma, CreateOrUpdateEntidad_IdiomaCommand>();
			Mapper.CreateMap<EstadoCalendario, CreateOrUpdateEstadoCalendarioCommand>();
			Mapper.CreateMap<EstadoCalendario_Idioma, CreateOrUpdateEstadoCalendario_IdiomaCommand>();
			Mapper.CreateMap<Evento, CreateOrUpdateEventoCommand>();
			Mapper.CreateMap<Evento_Idioma, CreateOrUpdateEvento_IdiomaCommand>();
			Mapper.CreateMap<Fabricante, CreateOrUpdateFabricanteCommand>();
			Mapper.CreateMap<Fabricante_Idioma, CreateOrUpdateFabricante_IdiomaCommand>();
			Mapper.CreateMap<Foto, CreateOrUpdateFotoCommand>();
			Mapper.CreateMap<Foto_Idioma, CreateOrUpdateFoto_IdiomaCommand>();
			Mapper.CreateMap<Marca, CreateOrUpdateMarcaCommand>();
			Mapper.CreateMap<SolicitudContacto, CreateOrUpdateSolicitudContactoCommand>();
			Mapper.CreateMap<SubcategoriaCalendario, CreateOrUpdateSubcategoriaCalendarioCommand>();
			Mapper.CreateMap<SubcategoriaCalendario_Idioma, CreateOrUpdateSubcategoriaCalendario_IdiomaCommand>();
			Mapper.CreateMap<TipoColeccionCalendario, CreateOrUpdateTipoColeccionCalendarioCommand>();
			Mapper.CreateMap<TipoColeccionCalendario_Idioma, CreateOrUpdateTipoColeccionCalendario_IdiomaCommand>();
			Mapper.CreateMap<TipoEvento, CreateOrUpdateTipoEventoCommand>();
			Mapper.CreateMap<TipoEvento_Idioma, CreateOrUpdateTipoEvento_IdiomaCommand>();
			Mapper.CreateMap<Usuario, CreateOrUpdateUsuarioCommand>();
			Mapper.CreateMap<Video, CreateOrUpdateVideoCommand>();
			Mapper.CreateMap<Video_Idioma, CreateOrUpdateVideo_IdiomaCommand>();
		}
	}
}
