
namespace CollectorsClub.Web.API.Models {
	public partial class TokenModel {
		//[JsonProperty(PropertyName = "access_token")]
		public string access_token { get; set; }
		//[JsonProperty(PropertyName = "expires_in")]

		public float expires_in { get; set; }
	}
}
