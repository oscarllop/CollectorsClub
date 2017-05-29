
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class CategoriaCalendarioModel {
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public ICollection<SubcategoriaCalendarioModel> Subcategorias { get; set; }
		public ICollection<CategoriaCalendario_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
		public ICollection<CalendarioModel> Calendarios { get; set; }
	}
}