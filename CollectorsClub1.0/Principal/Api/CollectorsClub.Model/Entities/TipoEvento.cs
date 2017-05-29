
using System;
using System.Collections.Generic;

namespace CollectorsClub.Model.Entities {
	public partial class TipoEvento {
	  public TipoEvento() {
			this.Eventos = new HashSet<Evento>();
			this.RegistrosIdiomas = new HashSet<TipoEvento_Idioma>();
	  }
	
		public short Id { get; set; }
		public string Nombre { get; set; }
		public string Codigo { get; set; }
		public short Orden { get; set; }
		public string IdMarca { get; set; }
		public virtual ICollection<Evento> Eventos { get; set; }
		public virtual Marca Marca { get; set; }
		public virtual ICollection<TipoEvento_Idioma> RegistrosIdiomas { get; set; }
	}
}