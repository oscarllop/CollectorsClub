using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Recursos : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		Response.Clear();
		if (!string.IsNullOrEmpty(Request.QueryString["Modulo"])) {
			string _rutaRecursos = (!string.IsNullOrEmpty(Request.QueryString["Ruta"]) ? "~/" + Request.QueryString["Ruta"].Replace("__", "/") : "~/DesktopModules/Integrador/Editores/App_LocalResources");
			Response.Write(TraduccionRecursos.obtenerTraduccionLiteralDesdeRecursos(Server.MapPath(_rutaRecursos), Request.QueryString["Modulo"] + ".ascx", (!string.IsNullOrEmpty(Request.QueryString["Cultura"]) ? Request.QueryString["Cultura"] : Thread.CurrentThread.CurrentUICulture.ToString())));
		} else {
			Response.Write("{}");
		}
		Response.End();
	}
}