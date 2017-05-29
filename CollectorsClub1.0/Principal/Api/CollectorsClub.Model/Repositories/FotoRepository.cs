
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class FotoRepository : RepositoryBase<Foto>, IFotoRepository {
		public FotoRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IFotoRepository : IRepository<Foto> {
	}
}