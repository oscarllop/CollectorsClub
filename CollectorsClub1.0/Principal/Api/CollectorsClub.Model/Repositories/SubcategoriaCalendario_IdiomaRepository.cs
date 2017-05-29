
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class SubcategoriaCalendario_IdiomaRepository : RepositoryBase<SubcategoriaCalendario_Idioma>, ISubcategoriaCalendario_IdiomaRepository {
		public SubcategoriaCalendario_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ISubcategoriaCalendario_IdiomaRepository : IRepository<SubcategoriaCalendario_Idioma> {
	}
}