
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Entidad_IdiomaRepository : RepositoryBase<Entidad_Idioma>, IEntidad_IdiomaRepository {
		public Entidad_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEntidad_IdiomaRepository : IRepository<Entidad_Idioma> {
	}
}