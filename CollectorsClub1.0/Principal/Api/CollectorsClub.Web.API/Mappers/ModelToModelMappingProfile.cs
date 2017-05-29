

using AutoMapper;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Mappers { 
	public partial class ModelToModelMappingProfile : Profile {
	  public override string ProfileName {
			get { return "ModelToModelMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<CalendarioModel, CalendarioModel>();
			Mapper.CreateMap<Calendario_IdiomaModel, Calendario_IdiomaModel>();
			Mapper.CreateMap<CategoriaCalendarioModel, CategoriaCalendarioModel>();
			Mapper.CreateMap<CategoriaCalendario_IdiomaModel, CategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<CategoriaFotoModel, CategoriaFotoModel>();
			Mapper.CreateMap<CategoriaFoto_IdiomaModel, CategoriaFoto_IdiomaModel>();
			Mapper.CreateMap<EntidadModel, EntidadModel>();
			Mapper.CreateMap<Entidad_IdiomaModel, Entidad_IdiomaModel>();
			Mapper.CreateMap<EstadoCalendarioModel, EstadoCalendarioModel>();
			Mapper.CreateMap<EstadoCalendario_IdiomaModel, EstadoCalendario_IdiomaModel>();
			Mapper.CreateMap<EventoModel, EventoModel>();
			Mapper.CreateMap<Evento_IdiomaModel, Evento_IdiomaModel>();
			Mapper.CreateMap<FabricanteModel, FabricanteModel>();
			Mapper.CreateMap<Fabricante_IdiomaModel, Fabricante_IdiomaModel>();
			Mapper.CreateMap<FotoModel, FotoModel>();
			Mapper.CreateMap<Foto_IdiomaModel, Foto_IdiomaModel>();
			Mapper.CreateMap<MarcaModel, MarcaModel>();
			Mapper.CreateMap<SolicitudContactoModel, SolicitudContactoModel>();
			Mapper.CreateMap<SubcategoriaCalendarioModel, SubcategoriaCalendarioModel>();
			Mapper.CreateMap<SubcategoriaCalendario_IdiomaModel, SubcategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<TipoColeccionCalendarioModel, TipoColeccionCalendarioModel>();
			Mapper.CreateMap<TipoColeccionCalendario_IdiomaModel, TipoColeccionCalendario_IdiomaModel>();
			Mapper.CreateMap<TipoEventoModel, TipoEventoModel>();
			Mapper.CreateMap<TipoEvento_IdiomaModel, TipoEvento_IdiomaModel>();
			Mapper.CreateMap<UsuarioModel, UsuarioModel>();
			Mapper.CreateMap<VideoModel, VideoModel>();
			Mapper.CreateMap<Video_IdiomaModel, Video_IdiomaModel>();
		}
	}
}
