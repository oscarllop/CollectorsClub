/*
 * Copyright (c) Dominick Baier.  All rights reserved.
 * see license.txt
 */

namespace Thinktecture.IdentityModel.Tokens
{
    public class SimpleSecurityToken : WrappedSecurityToken<string>
    {
        public SimpleSecurityToken(string token)
            : base(token)
        { }
    }
}
