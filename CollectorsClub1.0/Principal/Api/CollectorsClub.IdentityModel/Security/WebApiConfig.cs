using System.IdentityModel.Selectors;
using System.Web.Http;
using Thinktecture.IdentityModel.Http.Cors;
using Thinktecture.IdentityModel.Http.Cors.WebApi;
using Thinktecture.IdentityModel.Tokens.Http;
using CollectorsClub.IdentityModel.Security;
using log4net;

namespace CollectorsClub.IdentityModel.Security {
	public static class WebApiConfig {
		public static void Register(HttpConfiguration config, ILog log) {
			CorsConfiguration corsConfig = new CorsConfiguration();
			corsConfig.AllowAll();
			var corsHandler = new CorsMessageHandler(corsConfig, config);
			config.MessageHandlers.Add(corsHandler);
			log.Info("Configurado CORS.");

			// authentication configuration for identity controller
			var authentication = CreateAuthenticationConfiguration(log);
			config.MessageHandlers.Add(new AuthenticationHandler(authentication));
			log.Info("Configurada la autenticación.");

			// default API route
			//config.Routes.MapHttpRoute(
			//		name: "DefaultApi",
			//		routeTemplate: "api/{controller}/{id}",
			//		defaults: new { id = RouteParameter.Optional }
			//);
		}

		public static AuthenticationConfiguration CreateAuthenticationConfiguration(ILog log) {
			var authentication = new AuthenticationConfiguration {
				ClaimsAuthenticationManager = new ClaimsTransformer(),
				RequireSsl = false,
				EnableSessionToken = true
			};

			#region Basic Authentication
			authentication.AddBasicAuthentication(UserCredentials.Validate);
			log.Info("Configurada autenticación básica.");
			#endregion

			#region IdentityServer JWT
			//authentication.AddJsonWebToken(
			//    issuer: Constants.IdSrv.IssuerUri,
			//    audience: Constants.Audience,
			//    signingKey: Constants.IdSrv.SigningKey);

			authentication.AddMsftJsonWebToken(
					issuer: Constants.IdSrv.IssuerUri,
					audience: Constants.Audience,
					signingKey: Constants.IdSrv.SigningKey);
			log.Info("Configurado IdentityServer JWT.");
			#endregion

			#region Access Control Service JWT
			authentication.AddJsonWebToken(
					issuer: Constants.ACS.IssuerUri,
					audience: Constants.Audience,
					signingKey: Constants.ACS.SigningKey,
					scheme: Constants.ACS.Scheme);
			log.Info("Configurado Access Control Service JWT.");
			#endregion

			#region IdentityServer SAML
			authentication.AddSaml2(
					issuerThumbprint: Constants.IdSrv.SigningCertThumbprint,
					issuerName: Constants.IdSrv.IssuerUri,
					audienceUri: Constants.Realm,
					certificateValidator: X509CertificateValidator.None,
					options: AuthenticationOptions.ForAuthorizationHeader(Constants.IdSrv.SamlScheme),
					scheme: AuthenticationScheme.SchemeOnly(Constants.IdSrv.SamlScheme));
			log.Info("Configurado IdentityServer SAML.");
			#endregion

			#region Client Certificates
			authentication.AddClientCertificate(ClientCertificateMode.ChainValidation);
			log.Info("Configurado Client Certificate.");
			#endregion

			// OLL: Reeemplazo la session key generada automaticamente. Tendría que haber una variable de web.config para indicar si la quiero random o fija
			// y obtener la key del config;
			authentication.SessionToken.SigningKey = Constants.SessionKey;
			log.Info("Configurada Clave.");

			return authentication;
		}
	}
}