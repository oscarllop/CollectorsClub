/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using log4net;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Reflection;
using System.Security.Claims;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Dispatcher;
using Thinktecture.IdentityModel.Diagnostics;

namespace Thinktecture.IdentityModel.Tokens.Http {
	public class AuthenticationHandler : DelegatingHandler {
		private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		HttpAuthentication _authN;

		public const string PrincipalKey = "TT_Principal";

		public AuthenticationHandler(AuthenticationConfiguration configuration, HttpConfiguration httpConfiguration = null) {
			log.Info("Creando AuthenticationHandler...");
			_authN = new HttpAuthentication(configuration);

			if (httpConfiguration != null) {
				InnerHandler = new HttpControllerDispatcher(httpConfiguration);
			}
		}

		public AuthenticationHandler(AuthenticationConfiguration configuration, HttpMessageHandler innerHandler) {
			log.Info("Creando AuthenticationHandler2...");
			_authN = new HttpAuthentication(configuration);
			InnerHandler = innerHandler;
		}

		protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken) {
			log.Info("Iniciando SendAsync...");
			Tracing.Start(Area.HttpAuthentication);

			// check SSL requirement
			if (_authN.Configuration.RequireSsl) {
				if (request.RequestUri.Scheme != Uri.UriSchemeHttps) {
					Tracing.Information(Area.HttpAuthentication, "Request rejected because it is not over HTTPS.");

					var forbiddenResponse =
							request.CreateResponse(HttpStatusCode.Forbidden);

					forbiddenResponse.ReasonPhrase = "HTTPS Required.";
					return forbiddenResponse;
				}
			}

			// check if reuse of host client identity is allowed
			if (_authN.Configuration.InheritHostClientIdentity == false) {
				Tracing.Verbose(Area.HttpAuthentication, "Host client identity is not inherited. Setting anonymous principal");
				SetPrincipal(request, Principal.Anonymous);
			} else {
				Tracing.Verbose(Area.HttpAuthentication, "Host client identity is inherited. Setting current principal");
				SetPrincipal(request, ClaimsPrincipal.Current);
			}

			ClaimsPrincipal principal;
			try {
				log.Info("try to authenticate...");
				// try to authenticate
				// returns an anonymous principal if no credential was found
				principal = _authN.Authenticate(request);

				if (principal == null) {
					// this should never return null - check the corresponding handler!
					Tracing.Error(Area.HttpAuthentication, "Authentication returned null principal. Something is wrong!");
					return SendUnauthorizedResponse(request);
				} else {
					log.Info("Principal..." + principal.Identity.Name);
				}
			} catch (AuthenticationException aex) {
				// a handler wants to send back a specific error response
				log.Info("Excepcion al autenticar...", aex);
				return SendAuthenticationExceptionResponse(aex, request);
			} catch (Exception ex) {
				log.Info("Excepcion al autenticar...", ex);
				// something went wrong during authentication (e.g. invalid credentials)
				Tracing.Error(Area.HttpAuthentication, "Exception while validating the token: " + ex.ToString());
				return SendUnauthorizedResponse(request);
			}

			// credential was found *and* authentication was successful
			if (principal.Identity.IsAuthenticated) {
				Tracing.Verbose(Area.HttpAuthentication, "Authentication successful.");

				// check for token request - if yes send token back and return
				if (_authN.IsSessionTokenRequest(request)) {
					Tracing.Information(Area.HttpAuthentication, "Request for session token.");
					return SendSessionTokenResponse(principal, request);
				}

				// else set the principal
				SetPrincipal(request, principal);
			}

			// call service code
			var response = await base.SendAsync(request, cancellationToken);

			if (response.StatusCode == HttpStatusCode.Unauthorized) {
				SetAuthenticateHeaders(response);
			}

			return response;
		}

		private HttpResponseMessage SendAuthenticationExceptionResponse(AuthenticationException aex, HttpRequestMessage request) {
			var response = request.CreateResponse(aex.StatusCode);
			response.ReasonPhrase = aex.ReasonPhrase;

			if (aex.StatusCode == HttpStatusCode.Unauthorized) {
				SetAuthenticateHeaders(response);
			}

			return response;
		}

		private HttpResponseMessage SendUnauthorizedResponse(HttpRequestMessage request) {
			var unauthorizedResponse = request.CreateResponse(HttpStatusCode.Unauthorized);

			SetAuthenticateHeaders(unauthorizedResponse);
			unauthorizedResponse.ReasonPhrase = "Unauthorized.";

			return unauthorizedResponse;
		}

		private HttpResponseMessage SendSessionTokenResponse(ClaimsPrincipal principal, HttpRequestMessage request) {
			var tokenResponse = _authN.CreateSessionTokenResponse(principal);

			var response = request.CreateResponse(HttpStatusCode.OK);
			response.Content = new StringContent(tokenResponse, Encoding.UTF8, "application/json");

			return response;
		}

		protected virtual void SetAuthenticateHeaders(HttpResponseMessage response) {
			if (_authN.Configuration.SendWwwAuthenticateResponseHeaders) {
				foreach (var mapping in _authN.Configuration.Mappings) {
					if (mapping.Scheme != null && !string.IsNullOrEmpty(mapping.Scheme.Scheme)) {
						var header = new AuthenticationHeaderValue(mapping.Scheme.Scheme, mapping.Scheme.Challenge ?? "");
						response.Headers.WwwAuthenticate.Add(header);
					}
				}
			}
		}

		protected virtual void SetPrincipal(HttpRequestMessage request, ClaimsPrincipal principal) {
			if (principal.Identity.IsAuthenticated) {
				string name = "unknown";

				if (!string.IsNullOrWhiteSpace(principal.Identity.Name)) {
					name = principal.Identity.Name;
				} else if (principal.Claims.First() != null) {
					name = principal.Claims.First().Value;
				}

				Tracing.Verbose(Area.HttpAuthentication, "Principal set for: " + name);
			} else {
				Tracing.Verbose(Area.HttpAuthentication, "Setting anonymous principal.");
			}

			Thread.CurrentPrincipal = principal;

			if (HttpContext.Current != null) {
				HttpContext.Current.User = principal;
			}

			if (_authN.Configuration.SetPrincipalOnRequestInstance) {
				request.Properties[PrincipalKey] = principal;
			}
		}
	}
}