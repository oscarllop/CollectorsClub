
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEvento_IdiomaHandler : ICommandHandler<DeleteEvento_IdiomaCommand> {
		private readonly IEvento_IdiomaRepository Evento_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEvento_IdiomaHandler(IEvento_IdiomaRepository Evento_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Evento_IdiomaRepository = Evento_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEvento_IdiomaCommand command) {
			var Evento_Idioma = Evento_IdiomaRepository.GetById(command.Id);
			Evento_IdiomaRepository.Delete(Evento_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}