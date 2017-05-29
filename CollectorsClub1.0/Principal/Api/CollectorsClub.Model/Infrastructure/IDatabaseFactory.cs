using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CollectorsClub.Model.Infrastructure {
	public interface IDatabaseFactory : IDisposable {
		CollectorsClubEntities Get();
	}
}
