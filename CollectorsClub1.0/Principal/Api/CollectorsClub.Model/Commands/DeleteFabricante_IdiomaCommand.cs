
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteFabricante_IdiomaCommand : ICommand {
		public DeleteFabricante_IdiomaCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}