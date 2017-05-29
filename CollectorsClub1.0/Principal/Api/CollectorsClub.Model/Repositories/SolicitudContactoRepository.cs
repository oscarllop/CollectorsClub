
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class SolicitudContactoRepository : RepositoryBase<SolicitudContacto>, ISolicitudContactoRepository {
		public SolicitudContactoRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface ISolicitudContactoRepository : IRepository<SolicitudContacto> {
	}
}