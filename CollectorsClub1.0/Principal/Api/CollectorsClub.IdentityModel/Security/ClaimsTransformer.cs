using System.Linq;
using System.Security.Claims;

namespace CollectorsClub.IdentityModel.Security {
	public class ClaimsTransformer : ClaimsAuthenticationManager {
		public override ClaimsPrincipal Authenticate(string resourceName, ClaimsPrincipal incomingPrincipal) {
			if (!incomingPrincipal.Identity.IsAuthenticated) {
				return base.Authenticate(resourceName, incomingPrincipal);
			}

			incomingPrincipal.Identities.First().AddClaim(
					new Claim("localClaim", "someValue"));

			return incomingPrincipal;
		}
	}
}
