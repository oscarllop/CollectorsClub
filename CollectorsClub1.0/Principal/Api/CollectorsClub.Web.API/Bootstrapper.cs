using System.Reflection;
using System.Web.Http;
using System.Web.Mvc;
using Autofac;
using Autofac.Integration.Mvc;
using Autofac.Integration.WebApi;
using CollectorsClub.Data.Command;
using CollectorsClub.Data.Dispatcher;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Repositories;

namespace CollectorsClub.Web.API {
	public static class Bootstrapper {
		public static void Run() {
			SetAutofacWebAPIServices();
		}

		private static void SetAutofacWebAPIServices() {
			var configuration = GlobalConfiguration.Configuration;
			var builder = new ContainerBuilder();
			// Register API controllers using assembly scanning.
			builder.RegisterApiControllers(Assembly.GetExecutingAssembly());
			builder.RegisterType<DefaultCommandBus>().As<ICommandBus>().InstancePerRequest();
			builder.RegisterType<UnitOfWork>().As<IUnitOfWork>().InstancePerRequest();
			builder.RegisterType<DatabaseFactory>().As<IDatabaseFactory>().InstancePerRequest();
			builder.RegisterAssemblyTypes(typeof(CalendarioRepository).Assembly).Where(t => t.Name.EndsWith("Repository")).AsImplementedInterfaces().InstancePerRequest();
			var services = Assembly.Load("CollectorsClub.Model");
			builder.RegisterAssemblyTypes(services).AsClosedTypesOf(typeof(ICommandHandler<>)).InstancePerRequest();
			builder.RegisterAssemblyTypes(services).AsClosedTypesOf(typeof(IValidationHandler<>)).InstancePerRequest();
			var container = builder.Build();
			// Set the dependency resolver implementation.
			var resolver = new AutofacWebApiDependencyResolver(container);
			DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
			configuration.DependencyResolver = resolver;
		}
	}
}
