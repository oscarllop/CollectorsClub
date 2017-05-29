
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteTipoEvento_IdiomaCommand : ICommand {
		public DeleteTipoEvento_IdiomaCommand(short Id) {
			this.Id = Id;
		}
	
		public short Id { get; set; }
	}
}