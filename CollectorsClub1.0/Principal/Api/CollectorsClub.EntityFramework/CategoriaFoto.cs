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
    
    public partial class CategoriaFoto
    {
        public CategoriaFoto()
        {
            this.RegistrosIdiomas = new HashSet<CategoriaFoto_Idioma>();
            this.Fotos = new HashSet<Foto>();
        }
    
        public int Id { get; set; }
        public System.DateTime FechaAlta { get; set; }
        public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
        public bool Activa { get; set; }
        public short Orden { get; set; }
        public string Nombre { get; set; }
        public string IdMarca { get; set; }
    
        public virtual ICollection<CategoriaFoto_Idioma> RegistrosIdiomas { get; set; }
        public virtual ICollection<Foto> Fotos { get; set; }
        public virtual Marca Marca { get; set; }
    }
}
