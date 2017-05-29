
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class TipoColeccionCalendario_IdiomaRepository : RepositoryBase<TipoColeccionCalendario_Idioma>, ITipoColeccionCalendario_IdiomaRepository {
		public TipoColeccionCalendario_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ITipoColeccionCalendario_IdiomaRepository : IRepository<TipoColeccionCalendario_Idioma> {
	}
}