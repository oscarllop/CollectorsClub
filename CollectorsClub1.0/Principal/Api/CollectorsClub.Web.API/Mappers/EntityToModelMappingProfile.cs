

using AutoMapper;
using CollectorsClub.Model.Entities;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Mappers { 
	public partial class EntityToModelMappingProfile : Profile {
	  public override string ProfileName {
			get { return "EntityToModelMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<Calendario, CalendarioModel>();
			Mapper.CreateMap<Calendario_Idioma, Calendario_IdiomaModel>();
			Mapper.CreateMap<CategoriaCalendario, CategoriaCalendarioModel>();
			Mapper.CreateMap<CategoriaCalendario_Idioma, CategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<CategoriaFoto, CategoriaFotoModel>();
			Mapper.CreateMap<CategoriaFoto_Idioma, CategoriaFoto_IdiomaModel>();
			Mapper.CreateMap<Entidad, EntidadModel>();
			Mapper.CreateMap<Entidad_Idioma, Entidad_IdiomaModel>();
			Mapper.CreateMap<EstadoCalendario, EstadoCalendarioModel>();
			Mapper.CreateMap<EstadoCalendario_Idioma, EstadoCalendario_IdiomaModel>();
			Mapper.CreateMap<Evento, EventoModel>();
			Mapper.CreateMap<Evento_Idioma, Evento_IdiomaModel>();
			Mapper.CreateMap<Fabricante, FabricanteModel>();
			Mapper.CreateMap<Fabricante_Idioma, Fabricante_IdiomaModel>();
			Mapper.CreateMap<Foto, FotoModel>();
			Mapper.CreateMap<Foto_Idioma, Foto_IdiomaModel>();
			Mapper.CreateMap<Marca, MarcaModel>();
			Mapper.CreateMap<SolicitudContacto, SolicitudContactoModel>();
			Mapper.CreateMap<SubcategoriaCalendario, SubcategoriaCalendarioModel>();
			Mapper.CreateMap<SubcategoriaCalendario_Idioma, SubcategoriaCalendario_IdiomaModel>();
			Mapper.CreateMap<TipoColeccionCalendario, TipoColeccionCalendarioModel>();
			Mapper.CreateMap<TipoColeccionCalendario_Idioma, TipoColeccionCalendario_IdiomaModel>();
			Mapper.CreateMap<TipoEvento, TipoEventoModel>();
			Mapper.CreateMap<TipoEvento_Idioma, TipoEvento_IdiomaModel>();
			Mapper.CreateMap<Usuario, UsuarioModel>();
			Mapper.CreateMap<Video, VideoModel>();
			Mapper.CreateMap<Video_Idioma, Video_IdiomaModel>();
		}
	}
}
