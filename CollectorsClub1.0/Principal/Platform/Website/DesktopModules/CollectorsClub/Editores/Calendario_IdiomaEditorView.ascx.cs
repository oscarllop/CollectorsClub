
using System;
using System.Configuration;
using System.IO;
using System.Web.UI;
using CollectorsClub.Core;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Skins;
using DotNetNuke.UI.Skins.Controls;

namespace CollectorsClub.Modules.Editores.EditorCalendario_Idioma {

	partial class View : CoreModule {

		#region Eventos

		#region Eventos del ciclo de vida
		protected void Page_Init(object sender, EventArgs e) {
			Page.ViewStateMode = System.Web.UI.ViewStateMode.Disabled;
			Session["DojoCargado"] = false;
		}
		
		protected void Page_Load(object sender, EventArgs e) {
			try {
				// OLL: Revisar si es necesario, en teoría el módulo solo se ve si está autenticado, quizás es por si pierde la sesión
				if (!Request.IsAuthenticated) {
					// Do not redirect but hide the content of the module and display a message.
					Container.Visible = false;
					Skin.AddModuleMessage(this, Localization.GetString("ContentNotAvailable", LocalResourceFile), ModuleMessage.ModuleMessageType.YellowWarning);
					return;
				}

				//ServicesFramework.Instance.RequestAjaxAntiForgerySupport();
			} catch (Exception Excepcion) {
				Exceptions.ProcessModuleLoadException(this, Excepcion);
			}
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
