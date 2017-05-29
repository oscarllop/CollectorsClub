
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class TipoColeccionCalendarioRepository : RepositoryBase<TipoColeccionCalendario>, ITipoColeccionCalendarioRepository {
		public TipoColeccionCalendarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ITipoColeccionCalendarioRepository : IRepository<TipoColeccionCalendario> {
	}
}