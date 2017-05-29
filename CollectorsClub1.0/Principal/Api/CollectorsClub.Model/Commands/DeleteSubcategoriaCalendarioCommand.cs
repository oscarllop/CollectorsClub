
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteSubcategoriaCalendarioCommand : ICommand {
		public DeleteSubcategoriaCalendarioCommand(short Id) {
			this.Id = Id;
		}
	
		public short Id { get; set; }
	}
}