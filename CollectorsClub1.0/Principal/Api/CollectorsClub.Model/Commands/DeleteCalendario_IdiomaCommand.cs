
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteCalendario_IdiomaCommand : ICommand {
		public DeleteCalendario_IdiomaCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}