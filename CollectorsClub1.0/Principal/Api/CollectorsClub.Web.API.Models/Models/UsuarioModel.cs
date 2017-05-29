
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class UsuarioModel {
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string PrimerApellido { get; set; }
		public string SegundoApellido { get; set; }
		public string NombreDeUsuario { get; set; }
		public string CorreoElectronico { get; set; }
		public string IdMarca { get; set; }
		public ICollection<CalendarioModel> Calendarios { get; set; }
		public MarcaModel Marca { get; set; }
	}
}