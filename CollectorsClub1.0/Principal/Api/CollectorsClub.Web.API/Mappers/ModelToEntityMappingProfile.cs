

using AutoMapper;
using CollectorsClub.Model.Entities;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Mappers { 
	public partial class ModelToEntityMappingProfile : Profile {
	  public override string ProfileName {
			get { return "ModelToEntityMappingProfile"; }
		}
	
		protected override void Configure() {
			Mapper.CreateMap<CalendarioModel, Calendario>();
			Mapper.CreateMap<Calendario_IdiomaModel, Calendario_Idioma>();
			Mapper.CreateMap<CategoriaCalendarioModel, CategoriaCalendario>();
			Mapper.CreateMap<CategoriaCalendario_IdiomaModel, CategoriaCalendario_Idioma>();
			Mapper.CreateMap<CategoriaFotoModel, CategoriaFoto>();
			Mapper.CreateMap<CategoriaFoto_IdiomaModel, CategoriaFoto_Idioma>();
			Mapper.CreateMap<EntidadModel, Entidad>();
			Mapper.CreateMap<Entidad_IdiomaModel, Entidad_Idioma>();
			Mapper.CreateMap<EstadoCalendarioModel, EstadoCalendario>();
			Mapper.CreateMap<EstadoCalendario_IdiomaModel, EstadoCalendario_Idioma>();
			Mapper.CreateMap<EventoModel, Evento>();
			Mapper.CreateMap<Evento_IdiomaModel, Evento_Idioma>();
			Mapper.CreateMap<FabricanteModel, Fabricante>();
			Mapper.CreateMap<Fabricante_IdiomaModel, Fabricante_Idioma>();
			Mapper.CreateMap<FotoModel, Foto>();
			Mapper.CreateMap<Foto_IdiomaModel, Foto_Idioma>();
			Mapper.CreateMap<MarcaModel, Marca>();
			Mapper.CreateMap<SolicitudContactoModel, SolicitudContacto>();
			Mapper.CreateMap<SubcategoriaCalendarioModel, SubcategoriaCalendario>();
			Mapper.CreateMap<SubcategoriaCalendario_IdiomaModel, SubcategoriaCalendario_Idioma>();
			Mapper.CreateMap<TipoColeccionCalendarioModel, TipoColeccionCalendario>();
			Mapper.CreateMap<TipoColeccionCalendario_IdiomaModel, TipoColeccionCalendario_Idioma>();
			Mapper.CreateMap<TipoEventoModel, TipoEvento>();
			Mapper.CreateMap<TipoEvento_IdiomaModel, TipoEvento_Idioma>();
			Mapper.CreateMap<UsuarioModel, Usuario>();
			Mapper.CreateMap<VideoModel, Video>();
			Mapper.CreateMap<Video_IdiomaModel, Video_Idioma>();
		}
	}
}
