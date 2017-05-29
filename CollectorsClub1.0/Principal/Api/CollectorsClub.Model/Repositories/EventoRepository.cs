
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class EventoRepository : RepositoryBase<Evento>, IEventoRepository {
		public EventoRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IEventoRepository : IRepository<Evento> {
	}
}