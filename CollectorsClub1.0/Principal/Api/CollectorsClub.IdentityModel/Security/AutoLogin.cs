using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Threading.Tasks;
using Thinktecture.IdentityModel.Tokens.Http;
using log4net;
using System.Reflection;

namespace CollectorsClub.IdentityModel.Security {
	public static class AutoLogin {
		public static string CreateSessionToken(HttpRequestMessage request) {
			ILog _log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
			_log.Info("AutoLogin.CreateSessionToken");
			HttpAuthentication _httpAuthentication = new HttpAuthentication(WebApiConfig.CreateAuthenticationConfiguration(_log));
			string _resultadoAutenticacion = _httpAuthentication.CreateSessionTokenResponse(_httpAuthentication.Authenticate(request));
			_log.Info("Resultado autenticación: " + _resultadoAutenticacion);
			return _resultadoAutenticacion;
		}
	}
}
