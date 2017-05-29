
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class MarcaRepository : RepositoryBase<Marca>, IMarcaRepository {
		public MarcaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IMarcaRepository : IRepository<Marca> {
	}
}