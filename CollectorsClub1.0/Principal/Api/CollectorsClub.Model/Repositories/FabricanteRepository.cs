
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class FabricanteRepository : RepositoryBase<Fabricante>, IFabricanteRepository {
		public FabricanteRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IFabricanteRepository : IRepository<Fabricante> {
	}
}