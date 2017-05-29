
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class CategoriaFoto_IdiomaRepository : RepositoryBase<CategoriaFoto_Idioma>, ICategoriaFoto_IdiomaRepository {
		public CategoriaFoto_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ICategoriaFoto_IdiomaRepository : IRepository<CategoriaFoto_Idioma> {
	}
}