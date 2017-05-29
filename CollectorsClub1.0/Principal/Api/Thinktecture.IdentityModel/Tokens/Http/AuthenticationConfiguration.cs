/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens;
using System.Linq;
using System.Security.Claims;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    public class AuthenticationConfiguration
    {
        private bool _hasAuthorizationHeader;
        private bool _hasHeader;
        private bool _hasQueryString;
        private bool _hasCookie;
        private bool _hasClientCert;

        public List<AuthenticationOptionMapping> Mappings { get; set; }
        public bool SendWwwAuthenticateResponseHeaders { get; set; }
        public ClaimsAuthenticationManager ClaimsAuthenticationManager { get; set; }
        public bool InheritHostClientIdentity { get; set; }
        public bool EnableSessionToken { get; set; }
        public SessionTokenConfiguration SessionToken { get; set; }
        public bool RequireSsl { get; set; }
        public bool SetPrincipalOnRequestInstance { get; set; }

        #region HasMapping Properties
        public bool HasAuthorizationHeaderMapping
        {
            get { return _hasAuthorizationHeader; }
        }

        public bool HasHeaderMapping
        {
            get { return _hasHeader; }
        }

        public bool HasQueryStringMapping
        {
            get { return _hasQueryString; }
        }

        public bool HasCookieMapping
        {
            get { return _hasCookie; }
        }

        public bool HasClientCertificateMapping
        {
            get { return _hasClientCert; }
        }
        #endregion

        public AuthenticationConfiguration()
        {
            Mappings = new List<AuthenticationOptionMapping>();
            SendWwwAuthenticateResponseHeaders = true;
            InheritHostClientIdentity = true;
            RequireSsl = true;
            SetPrincipalOnRequestInstance = true;

            EnableSessionToken = false;
            SessionToken = new SessionTokenConfiguration();
        }

        public void AddMapping(AuthenticationOptionMapping mapping)
        {
            var hit = from m in Mappings
                      where m.Options.RequestType == mapping.Options.RequestType &&
                            m.Options.Name == mapping.Options.Name &&
                            m.Options.Scheme == mapping.Options.Scheme
                      select m;

            if (hit.FirstOrDefault() != null)
            {
                throw new InvalidOperationException("Duplicate authentication entry");
            }

            Mappings.Add(mapping);

            switch (mapping.Options.RequestType)
            {
                case HttpRequestType.AuthorizationHeader:
                    _hasAuthorizationHeader = true;
                    break;
                case HttpRequestType.Header:
                    _hasHeader = true;
                    break;
                case HttpRequestType.QueryString:
                    _hasQueryString = true;
                    break;
                case HttpRequestType.Cookie:
                    _hasCookie = true;
                    break;
                case HttpRequestType.ClientCertificate:
                    _hasClientCert = true;
                    break;
                default:
                    throw new InvalidOperationException("Invalid request type");
            }
        }

        #region Mapping retrieval
        public bool TryGetAuthorizationHeaderMapping(string scheme, out SecurityTokenHandlerCollection handler)
        {
            handler = (from m in Mappings
                       where m.Options.RequestType == HttpRequestType.AuthorizationHeader &&
                             m.Options.Name == "Authorization" &&
                             m.Options.Scheme == scheme
                       select m.TokenHandler).SingleOrDefault();

            return (handler != null);
        }

        public bool TryGetHeaderMapping(string headerName, out SecurityTokenHandlerCollection handler)
        {
            handler = (from m in Mappings
                       where m.Options.RequestType == HttpRequestType.Header &&
                             m.Options.Name == headerName
                       select m.TokenHandler).SingleOrDefault();

            return (handler != null);
        }

        public bool TryGetQueryStringMapping(string paramName, out SecurityTokenHandlerCollection handler)
        {
            handler = (from m in Mappings
                       where m.Options.RequestType == HttpRequestType.QueryString &&
                             m.Options.Name == paramName
                       select m.TokenHandler).SingleOrDefault();

            return (handler != null);
        }

        public bool TryGetClientCertificateMapping(out SecurityTokenHandlerCollection handler)
        {
            handler = (from m in Mappings
                       where m.Options.RequestType == HttpRequestType.ClientCertificate
                       select m.TokenHandler).SingleOrDefault();

            return (handler != null);
        }
        #endregion
    }
}
