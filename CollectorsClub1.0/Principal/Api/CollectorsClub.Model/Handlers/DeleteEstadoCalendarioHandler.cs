
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEstadoCalendarioHandler : ICommandHandler<DeleteEstadoCalendarioCommand> {
		private readonly IEstadoCalendarioRepository EstadoCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEstadoCalendarioHandler(IEstadoCalendarioRepository EstadoCalendarioRepository, IUnitOfWork unitOfWork) {
				this.EstadoCalendarioRepository = EstadoCalendarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEstadoCalendarioCommand command) {
			var EstadoCalendario = EstadoCalendarioRepository.GetById(command.Id);
			EstadoCalendarioRepository.Delete(EstadoCalendario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}