

using AutoMapper;
using CollectorsClub.Model.Commands;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Mappers { 
	public partial class CreateOrUpdateCommandToModelMappingProfile : Profile {
	  public override string ProfileName {
			get { return "CreateOrUpdateCommandToModelMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<CreateOrUpdateCalendarioCommand, CalendarioModel>();
			Mapper.CreateMap<CreateOrUpdateCalendario_IdiomaCommand, Calendario_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateCategoriaCalendarioCommand, CategoriaCalendarioModel>();
			Mapper.CreateMap<CreateOrUpdateCategoriaCalendario_IdiomaCommand, CategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateCategoriaFotoCommand, CategoriaFotoModel>();
			Mapper.CreateMap<CreateOrUpdateCategoriaFoto_IdiomaCommand, CategoriaFoto_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateEntidadCommand, EntidadModel>();
			Mapper.CreateMap<CreateOrUpdateEntidad_IdiomaCommand, Entidad_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateEstadoCalendarioCommand, EstadoCalendarioModel>();
			Mapper.CreateMap<CreateOrUpdateEstadoCalendario_IdiomaCommand, EstadoCalendario_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateEventoCommand, EventoModel>();
			Mapper.CreateMap<CreateOrUpdateEvento_IdiomaCommand, Evento_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateFabricanteCommand, FabricanteModel>();
			Mapper.CreateMap<CreateOrUpdateFabricante_IdiomaCommand, Fabricante_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateFotoCommand, FotoModel>();
			Mapper.CreateMap<CreateOrUpdateFoto_IdiomaCommand, Foto_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateMarcaCommand, MarcaModel>();
			Mapper.CreateMap<CreateOrUpdateSolicitudContactoCommand, SolicitudContactoModel>();
			Mapper.CreateMap<CreateOrUpdateSubcategoriaCalendarioCommand, SubcategoriaCalendarioModel>();
			Mapper.CreateMap<CreateOrUpdateSubcategoriaCalendario_IdiomaCommand, SubcategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateTipoColeccionCalendarioCommand, TipoColeccionCalendarioModel>();
			Mapper.CreateMap<CreateOrUpdateTipoColeccionCalendario_IdiomaCommand, TipoColeccionCalendario_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateTipoEventoCommand, TipoEventoModel>();
			Mapper.CreateMap<CreateOrUpdateTipoEvento_IdiomaCommand, TipoEvento_IdiomaModel>();
			Mapper.CreateMap<CreateOrUpdateUsuarioCommand, UsuarioModel>();
			Mapper.CreateMap<CreateOrUpdateVideoCommand, VideoModel>();
			Mapper.CreateMap<CreateOrUpdateVideo_IdiomaCommand, Video_IdiomaModel>();
		}
	}
}
