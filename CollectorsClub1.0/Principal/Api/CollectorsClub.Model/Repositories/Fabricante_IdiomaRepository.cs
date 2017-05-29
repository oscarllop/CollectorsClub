
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Fabricante_IdiomaRepository : RepositoryBase<Fabricante_Idioma>, IFabricante_IdiomaRepository {
		public Fabricante_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IFabricante_IdiomaRepository : IRepository<Fabricante_Idioma> {
	}
}