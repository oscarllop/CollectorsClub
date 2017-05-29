using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CrearThumbnail : System.Web.UI.Page {

	protected void Page_Load(object sender, EventArgs e) {
		if (!Page.IsPostBack) {
			//RutaImagen.Text = Request.PhysicalApplicationPath;
			RutaImagen.Text = "c:\\Mis Proyectos\\CollectorsClub\\CollectorsClub1.0\\Principal\\Platform\\Website\\Portals\\0\\a.jpg";

			ImagenInicial.ImageUrl = ImagenInicial.ToolTip = Path.AltDirectorySeparatorChar + RutaImagen.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
			RutaThumbnail1.Text = RutaImagen.Text.Replace(".jpg", "_thumb.jpg");
			ImagenThumbnail1.ImageUrl = ImagenThumbnail1.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail1.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);

			RutaThumbnail2.Text = RutaImagen.Text.Replace(".jpg", "_thumb2.jpg");
			ImagenThumbnail2.ImageUrl = ImagenThumbnail2.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail2.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
		}
	}

	protected void Crear_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Global/Actions/CrearThumbnail?rutaOrigen={0}&rutaDestino={1}&ancho={2}&alto={3}", Server.UrlEncode(RutaImagen.Text), Server.UrlEncode(RutaThumbnail1.Text), Ancho.Text, Alto.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) {
				_excepcion = WebApi.ProcesarExcepcionWeb((WebException) _excepcion, "a");
			}
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsEmpresas_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Empresa/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoEmpresas.Text, AltoEmpresas.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsEntidadesColaboradoras_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/EntidadColaboradora/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoEntidadesColaboradoras.Text, AltoEntidadesColaboradoras.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsFotos_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Foto/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoFotos.Text, AltoFotos.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsHoteles_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Hotel/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoHoteles.Text, AltoHoteles.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsNoticias_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Noticia/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoNoticias.Text, AltoNoticias.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsPatrocinadores_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Patrocinador/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoPatrocinadores.Text, AltoPatrocinadores.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsPersonas_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Persona/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoPersonas.Text, AltoPersonas.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsSeminarios_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Seminario/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoSeminarios.Text, AltoSeminarios.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void CrearThumbnailsTestimoniales_Click(object sender, EventArgs e) {
		try {
			Error.Text = string.Empty;
			WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
			WebApi.Get(WebApi.UrlWebApi, string.Format("/api/Testimonial/Actions/CrearThumbnails?nuevoAncho={0}&nuevoAlto={1}", AnchoTestimoniales.Text, AltoTestimoniales.Text));
		} catch (Exception _excepcion) {
			if (_excepcion is WebException) { _excepcion = WebApi.ProcesarExcepcionWeb((WebException)_excepcion, "a"); }
			Error.Text = _excepcion.Message + _excepcion.StackTrace;
		}
	}

	protected void RutaImagen_TextChanged(object sender, EventArgs e) {
		ImagenInicial.ImageUrl = ImagenInicial.ToolTip = Path.AltDirectorySeparatorChar + RutaImagen.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
		RutaThumbnail1.Text = RutaImagen.Text.Replace(".jpg", "_thumb.jpg");
		ImagenThumbnail1.ImageUrl = ImagenThumbnail1.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail1.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);

		RutaThumbnail2.Text = RutaImagen.Text.Replace(".jpg", "_thumb2.jpg");
		ImagenThumbnail2.ImageUrl = ImagenThumbnail2.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail2.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
	}

	protected void RutaThumbnail1_TextChanged(object sender, EventArgs e) {
		ImagenThumbnail1.ImageUrl = ImagenThumbnail1.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail1.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
	}

	protected void RutaThumbnail2_TextChanged(object sender, EventArgs e) {
		ImagenThumbnail2.ImageUrl = ImagenThumbnail2.ToolTip = Path.AltDirectorySeparatorChar + RutaThumbnail2.Text.Replace(Request.PhysicalApplicationPath, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
	}
}