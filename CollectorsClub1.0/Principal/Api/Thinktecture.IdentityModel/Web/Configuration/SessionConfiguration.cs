using Microsoft.Web.Infrastructure.DynamicModuleHelper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Thinktecture.IdentityModel.Web;

namespace Thinktecture.IdentityModel.Web.Configuration
{
    class SessionConfiguration
    {
        internal static void Start()
        {
            var config = SecuritySessionSection.Instance;
            if (config != null)
            {
                new SessionConfiguration(config).Configure();
            }
        }

        SecuritySessionSection config;
        public SessionConfiguration(SecuritySessionSection config)
        {
            if (config == null) throw new ArgumentNullException("config");

            this.config = config;
        }

        public void Configure()
        {
            if (!String.IsNullOrWhiteSpace(this.config.SessionTokenCacheType))
            {
                var type = Type.GetType(this.config.SessionTokenCacheType);
                if (type == null) throw new ConfigurationErrorsException("Invalid SessionTokenCacheType: " + config.SessionTokenCacheType);
                
                var obj = Activator.CreateInstance(type);
                if (obj == null) throw new Exception("Failed to create instance of " + config.SessionTokenCacheType);
                
                var cache = obj as ITokenCacheRepository;
                if (cache == null) throw new Exception(config.SessionTokenCacheType + " does not implement ITokenCacheRepository interface");
                
                PassiveSessionConfiguration.ConfigureSessionCache(cache);
            }

            if (this.config.UseMackineKeyProtectionForSessionTokens)
            {
                PassiveSessionConfiguration.ConfigureMackineKeyProtectionForSessionTokens();
            }

            if (this.config.PersistentSessionDuration > TimeSpan.Zero)
            {
                PassiveSessionConfiguration.ConfigurePersistentSessions(this.config.PersistentSessionDuration);
            }
            else if (this.config.DefaultSessionDuration > TimeSpan.Zero)
            {
                PassiveSessionConfiguration.ConfigureDefaultSessionDuration(this.config.DefaultSessionDuration);
            }

            if (this.RequiresModuleConfig)
            {
                SessionConfigurationModule.CacheSessionsOnServer = config.CacheSessionsOnServer;
                SessionConfigurationModule.EnableSlidingSessionExpirations = config.EnableSlidingSessionExpirations;
                SessionConfigurationModule.OverrideWSFedTokenLifetime = config.OverrideWSFedTokenLifetime;
                SessionConfigurationModule.SuppressLoginRedirectsForApiCalls = config.SuppressLoginRedirectsForApiCalls;
                SessionConfigurationModule.SuppressSecurityTokenExceptions = config.SuppressSecurityTokenExceptions;

                DynamicModuleUtility.RegisterModule(typeof(SessionConfigurationModule));
            }
        }

        public bool RequiresModuleConfig
        {
            get
            {
                return
                    this.config.CacheSessionsOnServer ||
                    this.config.EnableSlidingSessionExpirations ||
                    this.config.OverrideWSFedTokenLifetime ||
                    this.config.SuppressLoginRedirectsForApiCalls ||
                    this.config.SuppressSecurityTokenExceptions;
            }
        }
    }
}
