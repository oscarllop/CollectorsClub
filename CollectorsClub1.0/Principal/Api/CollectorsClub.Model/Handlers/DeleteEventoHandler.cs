
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEventoHandler : ICommandHandler<DeleteEventoCommand> {
		private readonly IEventoRepository EventoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEventoHandler(IEventoRepository EventoRepository, IUnitOfWork unitOfWork) {
				this.EventoRepository = EventoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEventoCommand command) {
			var Evento = EventoRepository.GetById(command.Id);
			EventoRepository.Delete(Evento);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}