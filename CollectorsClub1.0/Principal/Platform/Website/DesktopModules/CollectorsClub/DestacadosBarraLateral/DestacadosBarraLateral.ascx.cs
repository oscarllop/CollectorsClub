using CollectorsClub.Core;
using System;
using System.Configuration;
using System.IO;
using System.Web.UI;

namespace CollectorsClub.UI.Skins.Controls {
	public partial class DestacadosBarraLateral : CoreModule {
		#region Eventos

		#region Eventos del ciclo de vida
		protected void Page_Init(object sender, EventArgs e) {
			Page.ViewStateMode = ViewStateMode.Disabled;
			Session["DojoCargado"] = false;
		}

		protected void Page_PreRender(object sender, EventArgs e) {
			if ((bool)Session["DojoCargado"] == false) {
				Page.Header.Controls.AddAt(0, new LiteralControl("<script type=\"text/javascript\">\nvar _urlWebAPI = '" + ConfigurationManager.AppSettings["UrlWebAPI"] + "'\n" + File.ReadAllText(Server.MapPath("~/js/AMD/dojoConfig.js")) + "</script>\n" +
								"<script src=\"~/Resources/Shared/scripts/dojo/dojo/dojo.js\" data-dojo-config=\"async: true\"></script>\n" +
								"<script type=\"text/javascript\">\n" + File.ReadAllText(Server.MapPath("~/js/AMD/useConfig.js")) + "</script>\n"));
				Session["DojoCargado"] = true;
			}
		}
		#endregion Eventos del ciclo de vida

		#endregion Eventos
	}
}