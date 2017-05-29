
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class EstadoCalendario_IdiomaRepository : RepositoryBase<EstadoCalendario_Idioma>, IEstadoCalendario_IdiomaRepository {
		public EstadoCalendario_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEstadoCalendario_IdiomaRepository : IRepository<EstadoCalendario_Idioma> {
	}
}