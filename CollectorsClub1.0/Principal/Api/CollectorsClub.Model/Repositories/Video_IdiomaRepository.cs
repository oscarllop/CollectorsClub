
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class Video_IdiomaRepository : RepositoryBase<Video_Idioma>, IVideo_IdiomaRepository {
		public Video_IdiomaRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IVideo_IdiomaRepository : IRepository<Video_Idioma> {
	}
}