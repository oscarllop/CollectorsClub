/*
 * Copyright (c) Dominick Baier, Brock Allen.  All rights reserved.
 * see license.txt
 */

using System.Net.Http;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Dispatcher;

namespace Thinktecture.IdentityModel.Tokens.Http
{
    public class ClaimsTransformationHandler : DelegatingHandler
    {
        ClaimsAuthenticationManager _transfomer;

        public ClaimsTransformationHandler(ClaimsAuthenticationManager transformer, HttpConfiguration configuration)
        {
            _transfomer = transformer;
            InnerHandler = new HttpControllerDispatcher(configuration);
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            var principal = _transfomer.Authenticate(request.RequestUri.AbsoluteUri, ClaimsPrincipal.Current);

            Thread.CurrentPrincipal = principal;

            if (HttpContext.Current != null)
            {
                HttpContext.Current.User = principal;
            }

            return base.SendAsync(request, cancellationToken);
        }
    }
}
