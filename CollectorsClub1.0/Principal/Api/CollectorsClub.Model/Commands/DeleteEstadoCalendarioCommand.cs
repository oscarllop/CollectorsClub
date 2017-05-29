
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteEstadoCalendarioCommand : ICommand {
		public DeleteEstadoCalendarioCommand(short Id) {
			this.Id = Id;
		}
	
		public short Id { get; set; }
	}
}