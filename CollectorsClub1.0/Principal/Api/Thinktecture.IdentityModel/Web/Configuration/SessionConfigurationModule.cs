using Microsoft.Web.Infrastructure.DynamicModuleHelper;
using System;
using System.Collections.Generic;
using System.IdentityModel.Services;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Thinktecture.IdentityModel.Web;

namespace Thinktecture.IdentityModel.Web.Configuration
{
    public class SessionConfigurationModule : IHttpModule
    {
        static public bool CacheSessionsOnServer { get; set; }
        static public bool EnableSlidingSessionExpirations { get; set; }
        static public bool OverrideWSFedTokenLifetime { get; set; }
        static public bool SuppressLoginRedirectsForApiCalls { get; set; }
        static public bool SuppressSecurityTokenExceptions { get; set; }

        public void Init(HttpApplication application)
        {
            if (CacheSessionsOnServer)
            {
                PassiveModuleConfiguration.CacheSessionsOnServer();
            }

            if (EnableSlidingSessionExpirations)
            {
                PassiveModuleConfiguration.EnableSlidingSessionExpirations();
            }

            if (OverrideWSFedTokenLifetime)
            {
                PassiveModuleConfiguration.OverrideWSFedTokenLifetime();
            }

            if (SuppressLoginRedirectsForApiCalls)
            {
                PassiveModuleConfiguration.SuppressLoginRedirectsForApiCalls();
            }

            if (SuppressSecurityTokenExceptions)
            {
                PassiveModuleConfiguration.SuppressSecurityTokenExceptions();
            }
        }
        
        public void Dispose()
        {
        }
    }
}
