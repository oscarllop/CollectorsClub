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
    
    public partial class SolicitudContacto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string CorreoElectronico { get; set; }
        public string Asunto { get; set; }
        public string Contenido { get; set; }
        public System.DateTime FechaAlta { get; set; }
        public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
        public string IdMarca { get; set; }
    
        public virtual Marca Marca { get; set; }
    }
}
