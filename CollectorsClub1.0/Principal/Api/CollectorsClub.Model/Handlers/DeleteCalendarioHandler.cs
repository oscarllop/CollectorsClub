
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCalendarioHandler : ICommandHandler<DeleteCalendarioCommand> {
		private readonly ICalendarioRepository CalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCalendarioHandler(ICalendarioRepository CalendarioRepository, IUnitOfWork unitOfWork) {
				this.CalendarioRepository = CalendarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCalendarioCommand command) {
			var Calendario = CalendarioRepository.GetById(command.Id);
			CalendarioRepository.Delete(Calendario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}