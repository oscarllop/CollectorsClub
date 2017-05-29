using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class LocalizarImagenes : System.Web.UI.Page {

	protected void Page_Load(object sender, EventArgs e) {
		try {
			Mensajes.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			Mensajes.Text = string.Join("<br/>", JsonConvert.DeserializeObject<List<string>>(WebApi.Get(WebApi.UrlWebApi, "/api/Calendario/Actions/LocalizarImagenes")));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) {
				_excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a");
			}
			Mensajes.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

}