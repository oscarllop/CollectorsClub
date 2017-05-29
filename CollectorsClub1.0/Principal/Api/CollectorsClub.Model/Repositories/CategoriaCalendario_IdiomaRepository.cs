
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class CategoriaCalendario_IdiomaRepository : RepositoryBase<CategoriaCalendario_Idioma>, ICategoriaCalendario_IdiomaRepository {
		public CategoriaCalendario_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICategoriaCalendario_IdiomaRepository : IRepository<CategoriaCalendario_Idioma> {
	}
}