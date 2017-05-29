
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class CategoriaFotoRepository : RepositoryBase<CategoriaFoto>, ICategoriaFotoRepository {
		public CategoriaFotoRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICategoriaFotoRepository : IRepository<CategoriaFoto> {
	}
}