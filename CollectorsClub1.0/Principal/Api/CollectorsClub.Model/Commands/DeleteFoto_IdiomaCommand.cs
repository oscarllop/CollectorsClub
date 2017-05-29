
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteFoto_IdiomaCommand : ICommand {
		public DeleteFoto_IdiomaCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}