
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteMarcaCommand : ICommand {
		public DeleteMarcaCommand(string Id) {
			this.Id = Id;
		}
	
		public string Id { get; set; }
	}
}