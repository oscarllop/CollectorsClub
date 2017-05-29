using System;
using System.Collections.Generic;
using System.IdentityModel.Services;
using System.IdentityModel.Tokens;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading.Tasks;
using System.Web.Security;

namespace Thinktecture.IdentityModel.Web
{
    public class PassiveRepositorySessionSecurityTokenCache : SessionSecurityTokenCache
    {
        const string Purpose = "PassiveSessionTokenCache";

        ITokenCacheRepository tokenCacheRepository;
        SessionSecurityTokenCache inner;

        public PassiveRepositorySessionSecurityTokenCache(ITokenCacheRepository tokenCacheRepository)
            : this(tokenCacheRepository,
                   FederatedAuthentication.FederationConfiguration.IdentityConfiguration.Caches.SessionSecurityTokenCache)
        {
        }

        public PassiveRepositorySessionSecurityTokenCache(ITokenCacheRepository tokenCacheRepository, SessionSecurityTokenCache inner)
        {
            if (tokenCacheRepository == null) throw new ArgumentNullException("tokenCacheRepository");
            if (inner == null) throw new ArgumentNullException("inner");

            this.tokenCacheRepository = tokenCacheRepository;
            this.inner = inner;
        }

        static object lastCleanupLock = new object();
        static DateTime? lastCleanup;
        const int cleanupIntervalHours = 6;
        
        void CleanupOldTokens()
        {
            lock(lastCleanupLock)
            {
                if (lastCleanup == null || lastCleanup < DateTime.UtcNow.AddHours(-cleanupIntervalHours))
                {
                    lastCleanup = DateTime.UtcNow;

                    Task.Factory.StartNew(
                        delegate
                        {
                            // cleanup old tokens
                            DateTime date = DateTime.UtcNow.AddHours(-cleanupIntervalHours);
                            this.tokenCacheRepository.RemoveAllBefore(date);
                        })
                    .ContinueWith(task =>
                        {
                            // don't take down process if this fails 
                            // if ThrowUnobservedTaskExceptions is enabled
                            if (task.IsFaulted)
                            {
                                var ex = task.Exception;
                            }
                        });
                }
            }
        }

        public override void AddOrUpdate(
            SessionSecurityTokenCacheKey key,
            SessionSecurityToken value,
            DateTime expiryTime)
        {
            CleanupOldTokens();

            if (key == null) throw new ArgumentNullException("key");

            inner.AddOrUpdate(key, value, expiryTime);

            var item = new TokenCacheItem
            {
                Key = key.ToString(),
                Expires = expiryTime,
                Token = TokenToBytes(value),
            };
            
            tokenCacheRepository.AddOrUpdate(item);
        }

        public override SessionSecurityToken Get(SessionSecurityTokenCacheKey key)
        {
            CleanupOldTokens();

            if (key == null) throw new ArgumentNullException("key");

            var token = inner.Get(key);
            if (token != null) return token;

            var item = tokenCacheRepository.Get(key.ToString());
            if (item == null) return null;

            token = BytesToToken(item.Token);

            // update in-mem cache from database
            inner.AddOrUpdate(key, token, item.Expires);

            return token;
        }

        public override void Remove(SessionSecurityTokenCacheKey key)
        {
            CleanupOldTokens();

            if (key == null) throw new ArgumentNullException("key");

            inner.Remove(key);
            tokenCacheRepository.Remove(key.ToString());
        }

        public override IEnumerable<SessionSecurityToken> GetAll(
            string endpointId, System.Xml.UniqueId contextId)
        {
            throw new NotImplementedException("PassiveRepositorySessionSecurityTokenCache.GetAll");
        }

        public override void RemoveAll(string endpointId)
        {
            throw new NotImplementedException("PassiveRepositorySessionSecurityTokenCache.RemoveAll");
        }

        public override void RemoveAll(string endpointId, System.Xml.UniqueId contextId)
        {
            throw new NotImplementedException("PassiveRepositorySessionSecurityTokenCache.RemoveAll");
        }

        byte[] TokenToBytes(SessionSecurityToken token)
        {
            if (token == null) return null;

            using (var ms = new MemoryStream())
            {
                var f = new BinaryFormatter();
                f.Serialize(ms, token);
                var bytes = ms.ToArray();

                bytes = MachineKey.Protect(bytes, Purpose);

                return bytes;
            }
        }

        SessionSecurityToken BytesToToken(byte[] bytes)
        {
            if (bytes == null || bytes.Length == 0) return null;

            bytes = MachineKey.Unprotect(bytes, Purpose);

            using (var ms = new MemoryStream(bytes))
            {
                var f = new BinaryFormatter();
                var token = (SessionSecurityToken)f.Deserialize(ms);
                return token;
            }
        }
    }
}
