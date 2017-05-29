
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteTipoColeccionCalendarioCommand : ICommand {
		public DeleteTipoColeccionCalendarioCommand(short Id) {
			this.Id = Id;
		}
	
		public short Id { get; set; }
	}
}