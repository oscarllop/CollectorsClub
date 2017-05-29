using System.Net.Http.Headers;
using Thinktecture.IdentityModel.Constants;
using Thinktecture.IdentityModel.Tokens.Http;

namespace System.Net.Http
{
    public static class HttpClientExtensions
    {
        public static void SetBasicAuthentication(this HttpClient client, string userName, string password)
        {
            client.DefaultRequestHeaders.Authorization = new BasicAuthenticationHeaderValue(userName, password);
        }

        public static void SetToken(this HttpClient client, string scheme, string token)
        {
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(scheme, token);
        }

        public static void SetBearerToken(this HttpClient client, string token)
        {
            client.SetToken(JwtConstants.Bearer, token);
        }
    }
}
