
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteCategoriaCalendarioCommand : ICommand {
		public DeleteCategoriaCalendarioCommand(short Id) {
			this.Id = Id;
		}
	
		public short Id { get; set; }
	}
}