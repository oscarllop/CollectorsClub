using log4net;
using System.Reflection;

namespace CollectorsClub.IdentityModel.Security {
	public static class UserCredentials {
		private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		public static bool Validate(string username, string password) {
			log4net.Config.XmlConfigurator.Configure();

			log.Info(string.Format("Validando usuario {0} con la contrase�a {1}", username, password));
			return System.Web.Security.Membership.ValidateUser(username, password);
			////Validar que exista en la base de datos
			//			if (System.Web.Security.Membership.ValidateUser(username, password))
			//			{
			//					string IdSesion = (System.Web.HttpContext.Current.Request.Headers["Authorization"].Split(' '))[1];
			//					return true;
			//			}
			//			else
			//			{
			//					return false;
			//			}
		}
	}
}
