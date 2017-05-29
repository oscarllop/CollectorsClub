
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class SubcategoriaCalendarioModel {
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public string IdMarca { get; set; }
		public short IdCategoria { get; set; }
		public ICollection<CalendarioModel> Calendarios { get; set; }
		public ICollection<SubcategoriaCalendario_IdiomaModel> RegistrosIdiomas { get; set; }
		public MarcaModel Marca { get; set; }
		public CategoriaCalendarioModel Categoria { get; set; }
	}
}