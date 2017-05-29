
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class CategoriaCalendarioRepository : RepositoryBase<CategoriaCalendario>, ICategoriaCalendarioRepository {
		public CategoriaCalendarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICategoriaCalendarioRepository : IRepository<CategoriaCalendario> {
	}
}