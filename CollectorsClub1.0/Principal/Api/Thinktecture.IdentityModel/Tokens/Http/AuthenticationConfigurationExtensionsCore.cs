/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System;
using System.IdentityModel.Selectors;
using System.IdentityModel.Tokens;
using Thinktecture.IdentityModel.Constants;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    public static class AuthenticationConfigurationExtensionsCore
    {
        public static void AddAccessKey(this AuthenticationConfiguration configuration, SimpleSecurityTokenHandler handler, AuthenticationOptions options)
        {
            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options,
            });
        }

        public static void AddAccessKey(this AuthenticationConfiguration configuration, SimpleSecurityTokenHandler.ValidateTokenDelegate validateTokenDelegate, AuthenticationOptions options)
        {
            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { new SimpleSecurityTokenHandler(validateTokenDelegate) },
                Options = options,
            });
        }

        [Obsolete("Use JSON Web Tokens instead")]
        public static void AddSimpleWebToken(this AuthenticationConfiguration configuration, string issuer, string audience, string signingKey, AuthenticationOptions options)
        {
            var config = new SecurityTokenHandlerConfiguration();
            var registry = new WebTokenIssuerNameRegistry();
            registry.AddTrustedIssuer(issuer, issuer);
            config.IssuerNameRegistry = registry;

            var issuerResolver = new WebTokenIssuerTokenResolver();
            issuerResolver.AddSigningKey(issuer, signingKey);
            config.IssuerTokenResolver = issuerResolver;

            config.AudienceRestriction.AllowedAudienceUris.Add(new Uri(audience));

            var handler = new SimpleWebTokenHandler();
            handler.Configuration = config;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options
            });
        }

        public static void AddJsonWebToken(this AuthenticationConfiguration configuration, string issuer, string audience, string signingKey, AuthenticationOptions options, AuthenticationScheme scheme)
        {
            var config = new SecurityTokenHandlerConfiguration();
            var registry = new WebTokenIssuerNameRegistry();
            registry.AddTrustedIssuer(issuer, issuer);
            config.IssuerNameRegistry = registry;

            var issuerResolver = new WebTokenIssuerTokenResolver();
            issuerResolver.AddSigningKey(issuer, signingKey);
            config.IssuerTokenResolver = issuerResolver;

            config.AudienceRestriction.AllowedAudienceUris.Add(new Uri(audience));

            var handler = new JsonWebTokenHandler();
            handler.Configuration = config;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options,
                Scheme = scheme
            });
        }

        public static void AddJsonWebToken(this AuthenticationConfiguration configuration, string issuer, string audience, string signingKey, string scheme)
        {
            configuration.AddJsonWebToken(
                issuer,
                audience,
                signingKey,
                AuthenticationOptions.ForAuthorizationHeader(scheme),
                AuthenticationScheme.SchemeOnly(scheme));
        }

        public static void AddJsonWebToken(this AuthenticationConfiguration configuration, string issuer, string audience, string signingKey)
        {
            configuration.AddJsonWebToken(
                issuer, 
                audience, 
                signingKey, 
                AuthenticationOptions.ForAuthorizationHeader(JwtConstants.Bearer),
                AuthenticationScheme.SchemeOnly(JwtConstants.Bearer));
        }

        //public static void AddBasicAuthentication(this AuthenticationConfiguration configuration, BasicAuthenticationSecurityTokenHandler.ValidateUserNameCredentialDelegate validationDelegate, bool retainPassword = false)
        //{
        //    configuration.AddBasicAuthentication(
        //        validationDelegate, 
        //        "localhost", 
        //        retainPassword);
        //}

        public static void AddBasicAuthentication(this AuthenticationConfiguration configuration, BasicAuthenticationSecurityTokenHandler.ValidateUserNameCredentialDelegate validationDelegate, string realm = "localhost", bool retainPassword = false)
        {
            var handler = new BasicAuthenticationSecurityTokenHandler(validationDelegate);
            handler.RetainPassword = retainPassword;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = AuthenticationOptions.ForAuthorizationHeader(scheme: "Basic"),
                Scheme = AuthenticationScheme.SchemeAndRealm("Basic", realm)
            });
        }

        public static void AddBasicAuthentication(this AuthenticationConfiguration configuration, BasicAuthenticationSecurityTokenHandler.ValidateUserNameCredentialDelegate validationDelegate, AuthenticationOptions options, string realm = "localhost", bool retainPassword = false)
        {
            var handler = new BasicAuthenticationSecurityTokenHandler(validationDelegate);
            handler.RetainPassword = retainPassword;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options,
                Scheme = AuthenticationScheme.SchemeAndRealm("Basic", realm)
            });
        }

        public static void AddBasicAuthentication(this AuthenticationConfiguration configuration, Func<string, string, bool> validationDelegate, Func<string, string[]> roleDelegate, string realm = "localhost", bool retainPassword = false)
        {
            var handler = new BasicAuthenticationWithRoleSecurityTokenHandler(validationDelegate, roleDelegate);
            handler.RetainPassword = retainPassword;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = AuthenticationOptions.ForAuthorizationHeader(scheme: "Basic"),
                Scheme = AuthenticationScheme.SchemeAndRealm("Basic", realm)
            });
        }

        public static void AddClientCertificate(this AuthenticationConfiguration configuration, SecurityTokenHandler handler)
        {
            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = AuthenticationOptions.ForClientCertificate()
            });
        }

        public static void AddClientCertificate(this AuthenticationConfiguration configuration, ClientCertificateMode mode, params string[] values)
        {
            var handler = new ClientCertificateHandler(mode, values);

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = AuthenticationOptions.ForClientCertificate()
            });
        }

        public static void AddSaml2(this AuthenticationConfiguration configuration, string issuerThumbprint, string issuerName, string audienceUri, X509CertificateValidator certificateValidator, AuthenticationOptions options, AuthenticationScheme scheme)
        {
            var registry = new ConfigurationBasedIssuerNameRegistry();
            registry.AddTrustedIssuer(issuerThumbprint, issuerName);

            var handlerConfig = new SecurityTokenHandlerConfiguration();
            handlerConfig.AudienceRestriction.AllowedAudienceUris.Add(new Uri(audienceUri));
            handlerConfig.IssuerNameRegistry = registry;
            handlerConfig.CertificateValidator = certificateValidator;

            configuration.AddSaml2(handlerConfig, options, scheme);
        }

        public static void AddSaml2(this AuthenticationConfiguration configuration, SecurityTokenHandlerConfiguration handlerConfiguration, AuthenticationOptions options, AuthenticationScheme scheme)
        {
            var handler = new HttpSaml2SecurityTokenHandler();
            handler.Configuration = handlerConfiguration;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options,
                Scheme = scheme
            });
        }

        public static void AddSaml11(this AuthenticationConfiguration configuration, SecurityTokenHandlerConfiguration handlerConfiguration, AuthenticationOptions options)
        {
            var handler = new HttpSamlSecurityTokenHandler();
            handler.Configuration = handlerConfiguration;

            configuration.AddMapping(new AuthenticationOptionMapping
            {
                TokenHandler = new SecurityTokenHandlerCollection { handler },
                Options = options
            });
        }
    }
}
