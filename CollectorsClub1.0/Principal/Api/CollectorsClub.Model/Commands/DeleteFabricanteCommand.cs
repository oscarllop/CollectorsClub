
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteFabricanteCommand : ICommand {
		public DeleteFabricanteCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}