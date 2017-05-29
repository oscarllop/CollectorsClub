namespace CollectorsClub.Web.API.Models {

	public partial class TrazaModel {
		public enum TiposMensaje : short {
			Informativo,
			Advertencia,
			Error,
		}

		public short Nivel { get; set; }
		public string Mensaje { get; set; }
		public short Excepcion { get; set; }
	}
}