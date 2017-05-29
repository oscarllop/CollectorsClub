/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System;
using System.Net;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    [Serializable]
    public class AuthenticationException : Exception
    {
        HttpStatusCode _statusCode = HttpStatusCode.Unauthorized;
        string _reasonPhrase = "Unauthorized.";

        public HttpStatusCode StatusCode 
        {
            get { return _statusCode; }
            set { _statusCode = value; } 
        }

        public string ReasonPhrase 
        {
            get { return _reasonPhrase; }
            set { _reasonPhrase = value; }
        }

        public string Scheme { get; set; }

        public AuthenticationException() { }
        public AuthenticationException(string message) : base(message) { }
        public AuthenticationException(string message, Exception inner) : base(message, inner) { }
        protected AuthenticationException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }
    }
}
