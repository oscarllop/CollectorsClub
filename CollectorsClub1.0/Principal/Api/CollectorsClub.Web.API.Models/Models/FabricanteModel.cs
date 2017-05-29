
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class FabricanteModel {
		public int Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public ICollection<CalendarioModel> Calendarios { get; set; }
		public ICollection<Fabricante_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
	}
}