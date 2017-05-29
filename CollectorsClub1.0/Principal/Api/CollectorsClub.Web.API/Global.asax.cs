using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using CollectorsClub.Model;
using CollectorsClub.IdentityModel.Security;
using CollectorsClub.Web.API;
using CollectorsClub.Web.API.Mappers;
using log4net;
using DotNetNuke.Common;
using System.Net;
using DotNetNuke.Common.Utilities;
using DotNetNuke.ComponentModel;
using DotNetNuke.Data;
using DotNetNuke.Services.Cache;
using DotNetNuke.Security.Membership;
using DotNetNuke.Security.Roles;
using DotNetNuke.Security.Profile;

namespace CollectorsClub.Web.API {

	public class WebApiApplication : HttpApplication {

		public static void RegisterGlobalFilters(GlobalFilterCollection filters) {
			filters.Add(new HandleErrorAttribute());
		}

		public static void RegisterRoutes(RouteCollection routes) {
			routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

			routes.MapHttpRoute(
					name: "ActionApi",
					routeTemplate: "api/{controller}/actions/{action}/{id}",
					defaults: new { id = RouteParameter.Optional }
			);

			routes.MapHttpRoute(
					name: "DefaultApi",
					routeTemplate: "api/{controller}/{id}",
					defaults: new { action = "Get", id = RouteParameter.Optional },
					constraints: new { httpMethod = new HttpMethodConstraint("GET") }
			);

			routes.MapHttpRoute(
					name: "DefaultApiPost",
					routeTemplate: "api/{controller}/{id}",
					defaults: new { action = "Post", id = RouteParameter.Optional },
					constraints: new { httpMethod = new HttpMethodConstraint("POST") }
			);

			routes.MapHttpRoute(
					name: "DefaultApiPut",
					routeTemplate: "api/{controller}/{id}",
					defaults: new { action = "Put" },
					constraints: new { httpMethod = new HttpMethodConstraint("PUT") }
			);

			routes.MapHttpRoute(
					name: "DefaultApiDelete",
					routeTemplate: "api/{controller}/{id}",
					defaults: new { action = "Delete" },
					constraints: new { httpMethod = new HttpMethodConstraint("DELETE") }
			);

			routes.MapHttpRoute(
					name: "DefaultApiOptions",
					routeTemplate: "api/{controller}/{id}",
					defaults: new { action = "Options", id = RouteParameter.Optional },
					constraints: new { httpMethod = new HttpMethodConstraint("OPTIONS") }
			);

			routes.MapRoute(
					name: "Default",
					url: "{controller}/{action}/{id}",
					defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
			);
		}

		protected void Application_Start() {
			ILog _log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
			log4net.Config.XmlConfigurator.Configure();

			_log.Info("Iniciando la API");
			try {
				Database.SetInitializer<CollectorsClubEntities>(null);
				AreaRegistration.RegisterAllAreas();
				_log.Info("Áreas registradas.");

				GlobalConfiguration.Configuration.Formatters.Remove(GlobalConfiguration.Configuration.Formatters.JsonFormatter);
				GlobalConfiguration.Configuration.Formatters.Insert(0, new Core.Json.MaxDepthJsonMediaTypeFormatter());
				GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				// OLL: Si el MaxDepth está a 1, ModelState del Update no es valido al tener propiedades cargadas 
				GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.MaxDepth = 100;
				GlobalConfiguration.Configuration.Formatters.JsonFormatter.Indent = true;
				GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Remove(GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml"));
				_log.Info("Finalizada configurazión global.");

				WebApiConfig.Register(GlobalConfiguration.Configuration, _log);
				RegisterGlobalFilters(GlobalFilters.Filters);
				_log.Info("Filtros registrados.");
				RegisterRoutes(RouteTable.Routes);
				_log.Info("Rutas registradas.");

				//BundleConfig.RegisterBundles(BundleTable.Bundles);
				Bootstrapper.Run();
				_log.Info("Bootstraaper finalizado.");
				AutoMapperConfiguration.Configure();
				_log.Info("Auutomapper configurado.");

				#region Configuración DotNetNuke. Eliminar si el proyecto no está hosteado en un DotNetNuke
				Globals.ServerName = String.IsNullOrEmpty(Config.GetSetting("ServerName")) ? Dns.GetHostName() : Config.GetSetting("ServerName");

				ComponentFactory.Container = new SimpleContainer();
				#region Configuración DotNetNuke 7.0
				ComponentFactory.InstallComponents(new ProviderInstaller("data", typeof(DataProvider), typeof(SqlDataProvider)));
				ComponentFactory.InstallComponents(new ProviderInstaller("caching", typeof(CachingProvider), typeof(FBCachingProvider)));
				ComponentFactory.InstallComponents(new ProviderInstaller("members", typeof(MembershipProvider), typeof(AspNetMembershipProvider)));
				ComponentFactory.InstallComponents(new ProviderInstaller("roles", typeof(RoleProvider), typeof(DNNRoleProvider)));
				ComponentFactory.InstallComponents(new ProviderInstaller("profiles", typeof(ProfileProvider), typeof(DNNProfileProvider)));
				#endregion Configuración DotNetNuke 7.0

				#region Configuración DotNetNuke 6.1.4
				//ComponentFactory.InstallComponents(new ProviderInstaller("data", typeof(DataProvider)));
				//ComponentFactory.InstallComponents(new ProviderInstaller("caching", typeof(CachingProvider)));
				//ComponentFactory.InstallComponents(new ProviderInstaller("members", typeof(MembershipProvider)));
				//ComponentFactory.InstallComponents(new ProviderInstaller("roles", typeof(RoleProvider)));
				//ComponentFactory.InstallComponents(new ProviderInstaller("profiles", typeof(ProfileProvider)));
				#endregion Configuración DotNetNuke 6.1.4

				#endregion Configuración DotNetNuke. Eliminar si el proyecto no está hosteado en un DotNetNuke
				_log.Info("Dotnetnuke configurado.");
			} catch (Exception _excepcion) {
				_log.Error("Error en global.asax", _excepcion);
			}
		}

		//protected void Application_BeginRequest(object sender, EventArgs e) {
		//	HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
		//	HttpContext.Current.Response.AddHeader("Access-Control-Request-Headers", "origin, content-type, accept");
		//	HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET,OPTIONS,POST,PUT,DELETE");
		//	HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
		//}
	}
}