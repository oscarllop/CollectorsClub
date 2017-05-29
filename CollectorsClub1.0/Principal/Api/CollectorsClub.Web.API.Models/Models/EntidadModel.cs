
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class EntidadModel {
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public ICollection<CalendarioModel> CalendariosPorEntidad { get; set; }
		public ICollection<CalendarioModel> CalendariosPorEntidadContratante { get; set; }
		public ICollection<Entidad_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
	}
}