//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Planeta.EAE.Integrador.EntityFramework
{
    using System;
    using System.Collections.Generic;
    
    public partial class Marca
    {
        public Marca()
        {
            this.Calendarios = new HashSet<Calendario>();
            this.CategoriasFotos = new HashSet<CategoriaFoto>();
            this.Entidades = new HashSet<Entidad>();
            this.EstadosCalendario = new HashSet<EstadoCalendario>();
            this.Fabricantes = new HashSet<Fabricante>();
            this.Fotos = new HashSet<Foto>();
            this.SolicitudesContacto = new HashSet<SolicitudContacto>();
            this.SubcategoriasCalendario = new HashSet<SubcategoriaCalendario>();
            this.Usuarios = new HashSet<Usuario>();
            this.Videos = new HashSet<Video>();
            this.Eventos = new HashSet<Evento>();
            this.TiposEvento = new HashSet<TipoEvento>();
            this.CategoriasCalendario = new HashSet<CategoriaCalendario>();
            this.TiposColeccionCalendario = new HashSet<TipoColeccionCalendario>();
        }
    
        public string Id { get; set; }
        public string Nombre { get; set; }
    
        public virtual ICollection<Calendario> Calendarios { get; set; }
        public virtual ICollection<CategoriaFoto> CategoriasFotos { get; set; }
        public virtual ICollection<Entidad> Entidades { get; set; }
        public virtual ICollection<EstadoCalendario> EstadosCalendario { get; set; }
        public virtual ICollection<Fabricante> Fabricantes { get; set; }
        public virtual ICollection<Foto> Fotos { get; set; }
        public virtual ICollection<SolicitudContacto> SolicitudesContacto { get; set; }
        public virtual ICollection<SubcategoriaCalendario> SubcategoriasCalendario { get; set; }
        public virtual ICollection<Usuario> Usuarios { get; set; }
        public virtual ICollection<Video> Videos { get; set; }
        public virtual ICollection<Evento> Eventos { get; set; }
        public virtual ICollection<TipoEvento> TiposEvento { get; set; }
        public virtual ICollection<CategoriaCalendario> CategoriasCalendario { get; set; }
        public virtual ICollection<TipoColeccionCalendario> TiposColeccionCalendario { get; set; }
    }
}