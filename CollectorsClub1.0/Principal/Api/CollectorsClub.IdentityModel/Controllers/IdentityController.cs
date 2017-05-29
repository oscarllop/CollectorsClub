using System.Security.Claims;
using System.Web.Http;

namespace CollectorsClub.IdentityModel {
	[Authorize]
	public class IdentityController : ApiController {
		public ViewClaims Get() {
			var principal = Request.GetClaimsPrincipal();
			return ViewClaims.GetAll(principal);
		}
	}
}
