
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteSolicitudContactoCommand : ICommand {
		public DeleteSolicitudContactoCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}