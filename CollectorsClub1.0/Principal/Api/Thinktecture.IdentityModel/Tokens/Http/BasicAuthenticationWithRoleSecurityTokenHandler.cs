/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * contribution by SomaticIT
 * see license.txt
 */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IdentityModel.Tokens;
using System.Linq;
using System.Security.Claims;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    public class BasicAuthenticationWithRoleSecurityTokenHandler : BasicAuthenticationSecurityTokenHandler
    {
        public Func<string, string[]> GetRolesForUserHandler { get; private set; }

        public BasicAuthenticationWithRoleSecurityTokenHandler(Func<string, string, bool> validationDelegate, Func<string, string[]> roleDelegate)
            : base(validationDelegate.Invoke)
        {
            if (roleDelegate == null)
                throw new ArgumentNullException("roleDelegate");
                
            this.GetRolesForUserHandler = roleDelegate;
        }

        public override ReadOnlyCollection<ClaimsIdentity> ValidateToken(SecurityToken token)
        {
            UserNameSecurityToken unToken = token as UserNameSecurityToken;

            var identities = base.ValidateToken(token);
            ClaimsIdentity identity = identities.FirstOrDefault();

            if (identity != null)
            {
                string[] roles = this.GetRolesForUserBase(unToken.UserName);

                if (roles.Length > 0)
                {
                    IEnumerable<Claim> claims = roles.Select(r => new Claim(identity.RoleClaimType, r));
                    identity.AddClaims(claims);
                }
            }

            return identities;
        }

        public virtual string[] GetRolesForUserBase(string username)
        {
            if (this.GetRolesForUserHandler == null)
                throw new ArgumentNullException("GetRolesForUserHandler");

            return this.GetRolesForUserHandler(username);
        }
    }
}
