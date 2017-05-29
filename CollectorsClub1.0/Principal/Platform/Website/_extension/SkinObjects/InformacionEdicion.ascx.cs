using System;
using System.Linq;
using System.Web.UI;
using DotNetNuke.UI.Skins;
using CollectorsClub.Web.API.Models;
using Newtonsoft.Json;
using System.Threading;
using System.Web.UI.HtmlControls;

namespace CollectorsClub.UI.Skins.Controls {
	/// -----------------------------------------------------------------------------
	/// <summary></summary>
	/// <returns></returns>
	/// <remarks></remarks>
	/// -----------------------------------------------------------------------------
	public partial class InformacionEdicion : SkinObjectBase {

		protected override void OnInit(EventArgs e) {
			try {
				if (Context.User.Identity.IsAuthenticated) {
					HtmlLink _cssAutenticado = new HtmlLink();
					_cssAutenticado.Href = "~/Portals/_default/Skins/Porto/Autenticado.css";
					_cssAutenticado.Attributes.Add("rel", "stylesheet");
					_cssAutenticado.Attributes.Add("type", "text/css");
					Page.Header.Controls.Add(_cssAutenticado);
				}

				WebApi.ObtenerToken(WebApi.UrlWebApi, WebApi.UsuarioWebApi, WebApi.ContrasenyaWebApi);
				string _script = string.Format("localStorage['token'] = '{0}'; var _tokenExpiresAt = new Date(); _tokenExpiresAt.setSeconds(_tokenExpiresAt.getSeconds() + 36000); localStorage['tokenExpiresAt'] = _tokenExpiresAt;", JsonConvert.SerializeObject(WebApi.Tokens[WebApi.UrlWebApi]));
				if (ScriptManager.GetCurrent(Page).IsInAsyncPostBack) {
					ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "token", _script, true);
				} else {
					Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "token", _script, true);
				}
			} catch (Exception _excepcion) {
				LiteralError.Text = _excepcion.Message;
			}
			base.OnInit(e);
		}
	}
}