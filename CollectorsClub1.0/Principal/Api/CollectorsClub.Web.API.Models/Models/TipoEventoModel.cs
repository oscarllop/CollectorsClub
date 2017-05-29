
using System;
using System.Collections.Generic;

namespace CollectorsClub.Web.API.Models {
	public partial class TipoEventoModel {
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public short Orden { get; set; }
		public string IdMarca { get; set; }
		public ICollection<EventoModel> Eventos { get; set; }
		public MarcaModel Marca { get; set; }
		public ICollection<TipoEvento_IdiomaModel> RegistrosIdiomas { get; set; }
	}
}