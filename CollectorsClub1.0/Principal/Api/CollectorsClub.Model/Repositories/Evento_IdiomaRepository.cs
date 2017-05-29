
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Evento_IdiomaRepository : RepositoryBase<Evento_Idioma>, IEvento_IdiomaRepository {
		public Evento_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEvento_IdiomaRepository : IRepository<Evento_Idioma> {
	}
}