using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Thinktecture.IdentityModel.Web.Configuration
{
    public class SecuritySessionSection : ConfigurationSection
    {
        public static SecuritySessionSection Instance { get; set; }

        static SecuritySessionSection()
        {
            Instance = GetConfigSection();
        }

        public const string SectionName = "securitySessionConfiguration";

        static SecuritySessionSection GetConfigSection()
        {
            return (SecuritySessionSection)System.Configuration.ConfigurationManager.GetSection(SectionName);
        }

        private const string _SessionTokenCacheType = "sessionTokenCacheType";
        [ConfigurationProperty(_SessionTokenCacheType, DefaultValue = null)]
        public string SessionTokenCacheType
        {
            get { return (string)this[_SessionTokenCacheType]; }
            set { this[_SessionTokenCacheType] = value; }
        }

        private const string _UseMackineKeyProtectionForSessionTokens = "useMackineKeyProtectionForSessionTokens";
        [ConfigurationProperty(_UseMackineKeyProtectionForSessionTokens, DefaultValue = false)]
        public bool UseMackineKeyProtectionForSessionTokens
        {
            get { return (bool)this[_UseMackineKeyProtectionForSessionTokens]; }
            set { this[_UseMackineKeyProtectionForSessionTokens] = value; }
        }

        private const string _DefaultSessionDuration = "defaultSessionDuration";
        [ConfigurationProperty(_DefaultSessionDuration, DefaultValue = "00:00:00")]
        public TimeSpan DefaultSessionDuration
        {
            get { return (TimeSpan)this[_DefaultSessionDuration]; }
            set { this[_DefaultSessionDuration] = value; }
        }

        private const string _PersistentSessionDuration = "persistentSessionDuration";
        [ConfigurationProperty(_PersistentSessionDuration, DefaultValue = "00:00:00")]
        public TimeSpan PersistentSessionDuration
        {
            get { return (TimeSpan)this[_PersistentSessionDuration]; }
            set { this[_PersistentSessionDuration] = value; }
        }

        private const string _CacheSessionsOnServer = "cacheSessionsOnServer";
        [ConfigurationProperty(_CacheSessionsOnServer, DefaultValue = false)]
        public bool CacheSessionsOnServer
        {
            get { return (bool)this[_CacheSessionsOnServer]; }
            set { this[_CacheSessionsOnServer] = value; }
        }

        private const string _EnableSlidingSessionExpirations = "enableSlidingSessionExpirations";
        [ConfigurationProperty(_EnableSlidingSessionExpirations, DefaultValue = false)]
        public bool EnableSlidingSessionExpirations
        {
            get { return (bool)this[_EnableSlidingSessionExpirations]; }
            set { this[_EnableSlidingSessionExpirations] = value; }
        }

        private const string _OverrideWSFedTokenLifetime = "overrideWSFedTokenLifetime";
        [ConfigurationProperty(_OverrideWSFedTokenLifetime, DefaultValue = false)]
        public bool OverrideWSFedTokenLifetime
        {
            get { return (bool)this[_OverrideWSFedTokenLifetime]; }
            set { this[_OverrideWSFedTokenLifetime] = value; }
        }

        private const string _SuppressLoginRedirectsForApiCalls = "suppressLoginRedirectsForApiCalls";
        [ConfigurationProperty(_SuppressLoginRedirectsForApiCalls, DefaultValue = false)]
        public bool SuppressLoginRedirectsForApiCalls
        {
            get { return (bool)this[_SuppressLoginRedirectsForApiCalls]; }
            set { this[_SuppressLoginRedirectsForApiCalls] = value; }
        }

        private const string _SuppressSecurityTokenExceptions = "suppressSecurityTokenExceptions";
        [ConfigurationProperty(_SuppressSecurityTokenExceptions, DefaultValue = false)]
        public bool SuppressSecurityTokenExceptions
        {
            get { return (bool)this[_SuppressSecurityTokenExceptions]; }
            set { this[_SuppressSecurityTokenExceptions] = value; }
        }
    }
}
