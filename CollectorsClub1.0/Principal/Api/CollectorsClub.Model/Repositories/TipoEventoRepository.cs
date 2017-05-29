
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class TipoEventoRepository : RepositoryBase<TipoEvento>, ITipoEventoRepository {
		public TipoEventoRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ITipoEventoRepository : IRepository<TipoEvento> {
	}
}