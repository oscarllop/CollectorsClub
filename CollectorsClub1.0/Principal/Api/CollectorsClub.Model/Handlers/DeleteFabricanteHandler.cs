
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteFabricanteHandler : ICommandHandler<DeleteFabricanteCommand> {
		private readonly IFabricanteRepository FabricanteRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteFabricanteHandler(IFabricanteRepository FabricanteRepository, IUnitOfWork unitOfWork) {
				this.FabricanteRepository = FabricanteRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteFabricanteCommand command) {
			var Fabricante = FabricanteRepository.GetById(command.Id);
			FabricanteRepository.Delete(Fabricante);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}