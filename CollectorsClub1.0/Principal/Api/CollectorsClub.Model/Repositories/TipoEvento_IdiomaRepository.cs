
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class TipoEvento_IdiomaRepository : RepositoryBase<TipoEvento_Idioma>, ITipoEvento_IdiomaRepository {
		public TipoEvento_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ITipoEvento_IdiomaRepository : IRepository<TipoEvento_Idioma> {
	}
}