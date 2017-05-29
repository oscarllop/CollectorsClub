﻿/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

namespace Thinktecture.IdentityModel.Constants
{
    public static class OAuth2Constants
    {
        public const string GrantType = "grant_type";
        public const string UserName  = "username";
        public const string Scope     = "scope";
        public const string Assertion = "assertion";
        public const string Password  = "password";
        public const string Code = "code";

        public static class GrantTypes
        {
            public const string Password          = "password";
            public const string AuthorizationCode = "authorization_code";
            public const string ClientCredentials = "client_credentials";
            public const string RefreshToken      = "refresh_token";
            public const string JWT               = "urn:ietf:params:oauth:grant-type:jwt-bearer";
            public const string Saml2             = "urn:ietf:params:oauth:grant-type:saml2-bearer";
        }

        public static class ResponseTypes
        {
            public const string Token = "token";
            public const string Code  = "code";
        }

        public static class Errors
        {
            public const string Error                   = "error";
            public const string InvalidRequest          = "invalid_request";
            public const string InvalidClient           = "invalid_client";
            public const string InvalidGrant            = "invalid_grant";
            public const string UnauthorizedClient      = "unauthorized_client";
            public const string UnsupportedGrantType    = "unsupported_grant_type";
            public const string UnsupportedResponseType = "unsupported_response_type";
            public const string InvalidScope            = "invalid_scope";
            public const string AccessDenied            = "access_denied";
        }
    }
}