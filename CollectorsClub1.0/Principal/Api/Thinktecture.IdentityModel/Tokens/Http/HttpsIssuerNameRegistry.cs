/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System;
using System.IdentityModel.Tokens;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    /// <summary>
    /// Simple implementation of an issuer registy that returns the certificate issuer name or public key hash as an issuer
    /// </summary>
    public class HttpsIssuerNameRegistry : IssuerNameRegistry
    {
        /// <summary>
        /// Gets the name of the issuer.
        /// </summary>
        /// <param name="securityToken">The security token.</param>
        /// <returns></returns>
        public override string GetIssuerName(SecurityToken securityToken)
        {
            if (securityToken == null)
            {
                throw new ArgumentNullException("securityToken");
            }

            X509SecurityToken token = securityToken as X509SecurityToken;
            if (token != null)
            {
                return token.Certificate.Issuer;
            }

            throw new SecurityTokenException(securityToken.GetType().FullName);
        }
    }
}
