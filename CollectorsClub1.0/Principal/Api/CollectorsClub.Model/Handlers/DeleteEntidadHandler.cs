
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEntidadHandler : ICommandHandler<DeleteEntidadCommand> {
		private readonly IEntidadRepository EntidadRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEntidadHandler(IEntidadRepository EntidadRepository, IUnitOfWork unitOfWork) {
				this.EntidadRepository = EntidadRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEntidadCommand command) {
			var Entidad = EntidadRepository.GetById(command.Id);
			EntidadRepository.Delete(Entidad);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}