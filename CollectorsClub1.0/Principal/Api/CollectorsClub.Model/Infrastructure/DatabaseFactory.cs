using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CollectorsClub.Data.Infrastructure;

namespace CollectorsClub.Model.Infrastructure {
	public class DatabaseFactory : Disposable, IDatabaseFactory {
		private CollectorsClubEntities dataContext;
		public CollectorsClubEntities Get() {
			return dataContext ?? (dataContext = new CollectorsClubEntities());
		}
		protected override void DisposeCore() {
			if (dataContext != null)
				dataContext.Dispose();
		}
	}
}
