

using AutoMapper;
using CollectorsClub.Model.Commands;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Mappers { 
	public partial class ModelToCreateOrUpdateCommandMappingProfile : Profile {
	  public override string ProfileName {
			get { return "ModelToCreateOrUpdateCommandMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<CalendarioModel, CreateOrUpdateCalendarioCommand>();
			Mapper.CreateMap<Calendario_IdiomaModel, CreateOrUpdateCalendario_IdiomaCommand>();
			Mapper.CreateMap<CategoriaCalendarioModel, CreateOrUpdateCategoriaCalendarioCommand>();
			Mapper.CreateMap<CategoriaCalendario_IdiomaModel, CreateOrUpdateCategoriaCalendario_IdiomaCommand>();
			Mapper.CreateMap<CategoriaFotoModel, CreateOrUpdateCategoriaFotoCommand>();
			Mapper.CreateMap<CategoriaFoto_IdiomaModel, CreateOrUpdateCategoriaFoto_IdiomaCommand>();
			Mapper.CreateMap<EntidadModel, CreateOrUpdateEntidadCommand>();
			Mapper.CreateMap<Entidad_IdiomaModel, CreateOrUpdateEntidad_IdiomaCommand>();
			Mapper.CreateMap<EstadoCalendarioModel, CreateOrUpdateEstadoCalendarioCommand>();
			Mapper.CreateMap<EstadoCalendario_IdiomaModel, CreateOrUpdateEstadoCalendario_IdiomaCommand>();
			Mapper.CreateMap<EventoModel, CreateOrUpdateEventoCommand>();
			Mapper.CreateMap<Evento_IdiomaModel, CreateOrUpdateEvento_IdiomaCommand>();
			Mapper.CreateMap<FabricanteModel, CreateOrUpdateFabricanteCommand>();
			Mapper.CreateMap<Fabricante_IdiomaModel, CreateOrUpdateFabricante_IdiomaCommand>();
			Mapper.CreateMap<FotoModel, CreateOrUpdateFotoCommand>();
			Mapper.CreateMap<Foto_IdiomaModel, CreateOrUpdateFoto_IdiomaCommand>();
			Mapper.CreateMap<MarcaModel, CreateOrUpdateMarcaCommand>();
			Mapper.CreateMap<SolicitudContactoModel, CreateOrUpdateSolicitudContactoCommand>();
			Mapper.CreateMap<SubcategoriaCalendarioModel, CreateOrUpdateSubcategoriaCalendarioCommand>();
			Mapper.CreateMap<SubcategoriaCalendario_IdiomaModel, CreateOrUpdateSubcategoriaCalendario_IdiomaCommand>();
			Mapper.CreateMap<TipoColeccionCalendarioModel, CreateOrUpdateTipoColeccionCalendarioCommand>();
			Mapper.CreateMap<TipoColeccionCalendario_IdiomaModel, CreateOrUpdateTipoColeccionCalendario_IdiomaCommand>();
			Mapper.CreateMap<TipoEventoModel, CreateOrUpdateTipoEventoCommand>();
			Mapper.CreateMap<TipoEvento_IdiomaModel, CreateOrUpdateTipoEvento_IdiomaCommand>();
			Mapper.CreateMap<UsuarioModel, CreateOrUpdateUsuarioCommand>();
			Mapper.CreateMap<VideoModel, CreateOrUpdateVideoCommand>();
			Mapper.CreateMap<Video_IdiomaModel, CreateOrUpdateVideo_IdiomaCommand>();
		}
	}
}
