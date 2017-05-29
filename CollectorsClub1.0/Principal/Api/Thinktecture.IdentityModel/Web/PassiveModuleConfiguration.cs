using System;
using System.IdentityModel.Services;
using System.IdentityModel.Tokens;
using System.Web;
using System.Web.Mvc;

namespace Thinktecture.IdentityModel.Web
{
    public class PassiveModuleConfiguration
    {
        public static void SuppressSecurityTokenExceptions(
                    string redirectPath = "~/",
                    Action<SecurityTokenException> logger = null)
        {
            HttpContext.Current.ApplicationInstance.Error +=
                delegate(object sender, EventArgs e)
                {
                    var ctx = HttpContext.Current;
                    var ex = ctx.Error;

                    SecurityTokenException ste = ex as SecurityTokenException;
                    if (ste != null)
                    {
                        var sam = FederatedAuthentication.SessionAuthenticationModule;
                        if (sam != null) sam.SignOut();

                        ctx.ClearError();

                        if (logger != null) logger(ste);

                        ctx.Response.Redirect(redirectPath);
                    }
                };
        }

        public static void CacheSessionsOnServer(bool checkForSessionSecurityTokenCache = true)
        {
            if (checkForSessionSecurityTokenCache && 
                !(FederatedAuthentication.FederationConfiguration.IdentityConfiguration.Caches.SessionSecurityTokenCache is PassiveRepositorySessionSecurityTokenCache))
            {
                throw new Exception("SessionSecurityTokenCache not configured.");
            }

            SessionAuthenticationModule sam = FederatedAuthentication.SessionAuthenticationModule;
            if (sam == null) throw new ArgumentException("SessionAuthenticationModule is null");

            sam.IsReferenceMode = true;
        }

        public static void EnableSlidingSessionExpirations()
        {
            SessionAuthenticationModule sam = FederatedAuthentication.SessionAuthenticationModule;
            if (sam == null) throw new ArgumentException("SessionAuthenticationModule is null");

            sam.SessionSecurityTokenReceived +=
                delegate(object sender, SessionSecurityTokenReceivedEventArgs e)
                {
                    var token = e.SessionToken;
                    
                    var duration = token.ValidTo.Subtract(token.ValidFrom);
                    if (duration <= TimeSpan.Zero) return;

                    var diff = token.ValidTo.Add(sam.FederationConfiguration.IdentityConfiguration.MaxClockSkew).Subtract(DateTime.UtcNow);
                    if (diff <= TimeSpan.Zero) return;

                    var halfWay = duration.Add(sam.FederationConfiguration.IdentityConfiguration.MaxClockSkew).TotalMinutes / 2;
                    var timeLeft = diff.TotalMinutes;
                    if (timeLeft <= halfWay)
                    {
                        // set duration not from original token, but from current app configuration
                        var handler = sam.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers[typeof(SessionSecurityToken)] as SessionSecurityTokenHandler;
                        duration = handler.TokenLifetime;

                        e.ReissueCookie = true;
                        e.SessionToken =
                            new SessionSecurityToken(
                                token.ClaimsPrincipal, 
                                token.Context, 
                                DateTime.UtcNow, 
                                DateTime.UtcNow.Add(duration))
                            {
                                IsPersistent = token.IsPersistent,
                                IsReferenceMode = token.IsReferenceMode
                            };
                    }
                };
        }

        public static void SuppressLoginRedirectsForApiCalls()
        {
            var app = HttpContext.Current.ApplicationInstance;
            app.PostMapRequestHandler += 
                delegate
                {
                    var ctx = HttpContext.Current;
                    var req = new HttpRequestWrapper(ctx.Request);
                    if (req.IsAjaxRequest())
                    {
                        ctx.Response.SuppressFormsAuthenticationRedirect = true;
                    }
                };

            var fam = FederatedAuthentication.WSFederationAuthenticationModule;
            if (fam != null)
            {
                fam.AuthorizationFailed +=
                    delegate(object sender, AuthorizationFailedEventArgs e)
                    {
                        var ctx = HttpContext.Current;
                        if (!ctx.User.Identity.IsAuthenticated)
                        {
                            e.RedirectToIdentityProvider = !ctx.Response.SuppressFormsAuthenticationRedirect;
                        }
                    };
            }
        }

        public static void OverrideWSFedTokenLifetime()
        {
            var fam = FederatedAuthentication.WSFederationAuthenticationModule;
            if (fam == null)
            {
                throw new Exception("WSFederationAuthenticationModule not configured.");
            }

            fam.SessionSecurityTokenCreated +=
                delegate(object sender, SessionSecurityTokenCreatedEventArgs e)
                {
                    var handler = (SessionSecurityTokenHandler)FederatedAuthentication.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers[typeof(SessionSecurityToken)];
                    var duration = handler.TokenLifetime;
                    
                    var token = e.SessionToken;
                    e.SessionToken = 
                        new SessionSecurityToken(
                            token.ClaimsPrincipal,
                            token.Context,
                            token.ValidFrom,
                            token.ValidFrom.Add(duration))
                        {
                            IsPersistent = token.IsPersistent,
                            IsReferenceMode = token.IsReferenceMode
                        };
                };
        }
    }
}
