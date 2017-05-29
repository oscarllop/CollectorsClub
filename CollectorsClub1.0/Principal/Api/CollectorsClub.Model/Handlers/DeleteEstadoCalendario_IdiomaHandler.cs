
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEstadoCalendario_IdiomaHandler : ICommandHandler<DeleteEstadoCalendario_IdiomaCommand> {
		private readonly IEstadoCalendario_IdiomaRepository EstadoCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEstadoCalendario_IdiomaHandler(IEstadoCalendario_IdiomaRepository EstadoCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.EstadoCalendario_IdiomaRepository = EstadoCalendario_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEstadoCalendario_IdiomaCommand command) {
			var EstadoCalendario_Idioma = EstadoCalendario_IdiomaRepository.GetById(command.Id);
			EstadoCalendario_IdiomaRepository.Delete(EstadoCalendario_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}