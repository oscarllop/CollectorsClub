
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteUsuarioCommand : ICommand {
		public DeleteUsuarioCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}