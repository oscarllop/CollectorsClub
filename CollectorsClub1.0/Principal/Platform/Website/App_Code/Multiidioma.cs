using System.Globalization;
using System.Linq;
using System.Web;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Services.Localization;

public static class Multiidioma {
	private static TabCollection tabs;

	public static void CargarTabs() {
		tabs = TabController.Instance.GetTabsByPortal(PortalSettings.Current.PortalId);
	}

	public static string GetUrl(string url) {
		return GetUrlFromTabID(GetTabIDFromUrl(url));
	}

	public static string GetUrlFromTabID(int tabId) {
		if (tabs == null) { tabs = TabController.Instance.GetTabsByPortal(PortalSettings.Current.PortalId); }
		return (new DotNetNuke.Entities.Tabs.TabController()).GetTabByCulture(tabId, PortalSettings.Current.PortalId, LocaleController.Instance.GetLocale(CultureInfo.CurrentCulture.Name)).FullUrl.Replace(HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Host + HttpContext.Current.Request.ApplicationPath.ToLower(), string.Empty);
	}

	public static string GetNameFromTabID(int tabId) {
		if (tabs == null) { tabs = TabController.Instance.GetTabsByPortal(PortalSettings.Current.PortalId); }
		return (new DotNetNuke.Entities.Tabs.TabController()).GetTabByCulture(tabId, PortalSettings.Current.PortalId, LocaleController.Instance.GetLocale(CultureInfo.CurrentCulture.Name)).LocalizedTabName;
	}

	public static int GetTabIDFromUrl(string url) {
		if (tabs == null) { tabs = TabController.Instance.GetTabsByPortal(PortalSettings.Current.PortalId); }
		return tabs.Values.Where(x => x.TabPath == ChangeUrl(url)).Select(x => x.TabID).FirstOrDefault();
	}

	public static string ChangeUrl(string url) {
		string retorno = url;

		if (retorno.Contains("?")) {
			string[] substrings = retorno.Split('?');
			retorno = substrings.FirstOrDefault();
		}

		retorno = retorno.Replace("~", "");
		retorno = retorno.Replace("-", "");
		retorno = retorno.Replace("/", "//");

		return retorno;
	}
}