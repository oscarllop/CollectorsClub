namespace CollectorsClub.Web.API.Models {



	public partial class MensajeModel {
		public string Tipo { get; set; }
		public string Texto { get; set; }
	}

	public partial class CargaArchivoModel {
		public string Ruta { get; set; }
		public string Mensaje { get; set; }
		public MensajeModel[] Mensajes { get; set; }
	}
}