
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class EntidadRepository : RepositoryBase<Entidad>, IEntidadRepository {
		public EntidadRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEntidadRepository : IRepository<Entidad> {
	}
}