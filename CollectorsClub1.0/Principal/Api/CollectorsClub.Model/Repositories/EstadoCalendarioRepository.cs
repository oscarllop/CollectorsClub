
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class EstadoCalendarioRepository : RepositoryBase<EstadoCalendario>, IEstadoCalendarioRepository {
		public EstadoCalendarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEstadoCalendarioRepository : IRepository<EstadoCalendario> {
	}
}