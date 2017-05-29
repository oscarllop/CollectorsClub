using System;
using System.IdentityModel.Services;
using System.IdentityModel.Services.Tokens;
using System.IdentityModel.Tokens;

namespace Thinktecture.IdentityModel.Web
{
    public static class PassiveSessionConfiguration
    {
        public static void ConfigureMackineKeyProtectionForSessionTokens()
        {
            var handler = (SessionSecurityTokenHandler)FederatedAuthentication.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers[typeof(SessionSecurityToken)];
            if (!(handler is MachineKeySessionSecurityTokenHandler))
            {
                var mkssth = new MachineKeySessionSecurityTokenHandler();
                if (handler != null) mkssth.TokenLifetime = handler.TokenLifetime;
                FederatedAuthentication.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers.AddOrReplace(mkssth);
            }
        }

        public static void ConfigureSessionCache(ITokenCacheRepository tokenCacheRepository)
        {
            if (!(FederatedAuthentication.FederationConfiguration.IdentityConfiguration.Caches.SessionSecurityTokenCache is PassiveRepositorySessionSecurityTokenCache))
            {
                FederatedAuthentication.FederationConfiguration.IdentityConfiguration.Caches.SessionSecurityTokenCache = new PassiveRepositorySessionSecurityTokenCache(tokenCacheRepository);
            }
        }

        public static void ConfigureDefaultSessionDuration(TimeSpan sessionDuration)
        {
            if (FederatedAuthentication.FederationConfiguration.WsFederationConfiguration.PersistentCookiesOnPassiveRedirects)
            {
                throw new Exception("Persistent session cookies are configured. Use ConfigurePersistentSessions instead to set the session cookie duration.");
            }

            var handler = (SessionSecurityTokenHandler)FederatedAuthentication.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers[typeof(SessionSecurityToken)];
            if (handler != null)
            {
                handler.TokenLifetime = sessionDuration;
            }
        }

        public static void ConfigurePersistentSessions(TimeSpan sessionDuration)
        {
            FederatedAuthentication.FederationConfiguration.WsFederationConfiguration.PersistentCookiesOnPassiveRedirects = true;

            var handler = (SessionSecurityTokenHandler)FederatedAuthentication.FederationConfiguration.IdentityConfiguration.SecurityTokenHandlers[typeof(SessionSecurityToken)];
            if (handler != null)
            {
                handler.TokenLifetime = sessionDuration;
                var skew = FederatedAuthentication.FederationConfiguration.IdentityConfiguration.MaxClockSkew;
                FederatedAuthentication.FederationConfiguration.CookieHandler.PersistentSessionLifetime = sessionDuration + skew;
            }
        }
    }
}
