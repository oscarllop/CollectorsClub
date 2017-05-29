
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Calendario_IdiomaRepository : RepositoryBase<Calendario_Idioma>, ICalendario_IdiomaRepository {
		public Calendario_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICalendario_IdiomaRepository : IRepository<Calendario_Idioma> {
	}
}