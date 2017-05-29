namespace CollectorsClub.IdentityModel {
	public static class Constants {
		//
		// change the below constants to match your local system
		//

		public const string WebHostName = "localhost";
		public const string SelfHostName = "localhost";

		public const string WebHostAppName = "/webhost/api/";
		public const string SelfHostAppName = "/webhost/api/";

		public const string WebHostBaseAddress = "http://" + WebHostName + WebHostAppName;
		public const string SelfHostBaseAddress = "http://" + SelfHostName + SelfHostAppName;


		//
		// These are the config settings for the sts - don't need to be changed if you use the sample idsrv
		//
		public const string Realm = "urn:webapisecurity";
		public const string Audience = Realm;
		public const string Scope = Realm;
		public const string SessionKey = "lm88gqCHGGe1UdmQ2hK62wHUpQwCvpRw5N1AZ1fEMlU=";

		public static class IdSrv {
			public const string OAuth2TokenEndpoint = "https://identity.thinktecture.com/sample/issue/oauth2/token";
			public const string OAuth2AuthorizeEndpoint = "https://identity.thinktecture.com/sample/issue/oauth2/authorize";
			public const string WSTrustEndpoint = "https://identity.thinktecture.com/sample/issue/wstrust/mixed/username";

			public const string IssuerUri = "http://identityserver.v2.thinktecture.com/samples";
			public const string SigningKey = "fWUU28oBOIcaQuwUKiL01KztD/CsZX83C3I0M1MOYN4=";
			public const string SigningCertThumbprint = "a1eed7897e55388fce60fef1a1eed81ff1cbaec6";


			public const string OAuthClientName = "client";
			public const string Win8OAuthClientName = "win8client";
			public const string OAuthClientSecret = "secret";

			public static string SamlScheme = "SAML";
		}

		public static class ACS {
			public const string Namespace = "webapisecuritysample";
			public const string IssuerUri = "https://" + Namespace + ".accesscontrol.windows.net/";
			public const string Scheme = "ACS";
			public const string SigningKey = "eo95XJ/5jT++blJlxybYwSn+BhP932QogAeUWVfWG8k=";

			public const string OAuth2Endpoint = IssuerUri + "v2/OAuth2-13";
		}
	}
}
