
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCalendario_IdiomaHandler : ICommandHandler<DeleteCalendario_IdiomaCommand> {
		private readonly ICalendario_IdiomaRepository Calendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCalendario_IdiomaHandler(ICalendario_IdiomaRepository Calendario_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Calendario_IdiomaRepository = Calendario_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCalendario_IdiomaCommand command) {
			var Calendario_Idioma = Calendario_IdiomaRepository.GetById(command.Id);
			Calendario_IdiomaRepository.Delete(Calendario_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}