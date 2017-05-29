/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IdentityModel.Tokens;
using System.Net.Http;
using System.Security.Claims;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    public class HttpRequestSecurityTokenHandler : SecurityTokenHandler
    {
        private string[] _identifier;
        public delegate ClaimsPrincipal ValidateTokenDelegate(HttpRequestMessage request);

        public ValidateTokenDelegate Validator { get; set; }

        public HttpRequestSecurityTokenHandler(string identifier)
            : this(identifier, null)
        { }

        public HttpRequestSecurityTokenHandler(ValidateTokenDelegate validator) 
            : this(Guid.NewGuid().ToString(), validator)
        { }

        public HttpRequestSecurityTokenHandler(string identifier, ValidateTokenDelegate validator)
        {
            _identifier = new string[] { identifier };
            Validator = validator;
        }

        protected virtual ClaimsIdentity ValidateRequest(HttpRequestMessage request)
        {
            if (Validator != null)
            {
                return Validator(request).Identity as ClaimsIdentity;
            }
            else
            {
                throw new InvalidOperationException("No validator");
            }
        }

        public override ReadOnlyCollection<ClaimsIdentity> ValidateToken(SecurityToken token)
        {
            var requestToken = token as HttpRequestSecurityToken;
            if (requestToken == null)
            {
                throw new ArgumentException("SecurityToken is not a HttpRequestSecurityToken");
            }

            var identity = ValidateRequest(requestToken.Token);

            if (identity != null)
            {
                return new List<ClaimsIdentity> { identity }.AsReadOnly();
            }
            else
            {
                throw new SecurityTokenValidationException("No identity");
            }
        }

        public override string[] GetTokenTypeIdentifiers()
        {
            return _identifier;
        }

        public override Type TokenType
        {
            get { return typeof(HttpRequestSecurityToken); }
        }
    }
}
