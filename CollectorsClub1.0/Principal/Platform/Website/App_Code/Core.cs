using System;
using DotNetNuke.Entities.Modules;

namespace CollectorsClub.Core {
	public class CoreModule : PortalModuleBase {
		protected override void OnLoad(EventArgs e) {
			try {
				if (Session["Marca"] == null) {
					Session["Marca"] = "CCB";
				}
			} catch (Exception _excepcion) {
				//Incluir log
			}
			base.OnLoad(e);
		}
	}
}