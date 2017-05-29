
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class CalendarioRepository : RepositoryBase<Calendario>, ICalendarioRepository {
		public CalendarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICalendarioRepository : IRepository<Calendario> {
	}
}