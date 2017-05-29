
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;

namespace CollectorsClub.Model.Commands {
	
	public partial class DeleteEstadoCalendario_IdiomaCommand : ICommand {
		public DeleteEstadoCalendario_IdiomaCommand(int Id) {
			this.Id = Id;
		}
	
		public int Id { get; set; }
	}
}