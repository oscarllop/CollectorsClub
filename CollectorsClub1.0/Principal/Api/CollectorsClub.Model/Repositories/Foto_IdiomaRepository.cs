
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Foto_IdiomaRepository : RepositoryBase<Foto_Idioma>, IFoto_IdiomaRepository {
		public Foto_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IFoto_IdiomaRepository : IRepository<Foto_Idioma> {
	}
}