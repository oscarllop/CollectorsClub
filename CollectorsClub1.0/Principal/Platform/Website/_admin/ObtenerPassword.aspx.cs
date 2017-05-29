using System;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Membership;
using log4net;

namespace CollectorsClub.Web._Admin {
	public partial class ObtenerPassword : System.Web.UI.Page {
		public readonly ILog log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

		protected void Page_Load(object sender, EventArgs e) {
			log4net.Config.XmlConfigurator.Configure();
		}

		protected void btnObtenerPassword_Click(object sender, EventArgs e) {
			try {
				UserInfo UsuarioCliente = MembershipProvider.Instance().GetUserByUserName((PortalSettings.Current != null ? PortalSettings.Current.PortalId : 0), txtIdUsuario.Text);
				txtIdUsuarioDNN.Text = MembershipProvider.Instance().GetPassword(UsuarioCliente, UsuarioCliente.Membership.PasswordAnswer);
			} catch (Exception _excepcion) {
				log.Error("Obtener Password: Error genérico", _excepcion);
			}
		}
	}
}
