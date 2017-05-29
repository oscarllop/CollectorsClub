using System.Net.Http;
using System.Security.Claims;

namespace System.Web.Http
{
    public static class HttpRequestMessageProxyExtensions
    {
        public static ClaimsPrincipal GetClaimsPrincipal(this HttpRequestMessage request)
        {
            return Thinktecture.IdentityModel.Extensions.HttpRequestMessageExtensions.GetClaimsPrincipal(request);
        }
    }
}