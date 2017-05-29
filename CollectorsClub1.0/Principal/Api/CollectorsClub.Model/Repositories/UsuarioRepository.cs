
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Repositories {
	public partial class UsuarioRepository : RepositoryBase<Usuario>, IUsuarioRepository {
		public UsuarioRepository(IDatabaseFactory databaseFactory) : base(databaseFactory) {
		}
	}
	public partial interface IUsuarioRepository : IRepository<Usuario> {
	}
}