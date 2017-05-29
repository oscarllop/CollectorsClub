
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class SubcategoriaCalendarioRepository : RepositoryBase<SubcategoriaCalendario>, ISubcategoriaCalendarioRepository {
		public SubcategoriaCalendarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ISubcategoriaCalendarioRepository : IRepository<SubcategoriaCalendario> {
	}
}