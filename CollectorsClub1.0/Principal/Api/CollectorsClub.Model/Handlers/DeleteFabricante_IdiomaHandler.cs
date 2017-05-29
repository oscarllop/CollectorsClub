
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteFabricante_IdiomaHandler : ICommandHandler<DeleteFabricante_IdiomaCommand> {
		private readonly IFabricante_IdiomaRepository Fabricante_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteFabricante_IdiomaHandler(IFabricante_IdiomaRepository Fabricante_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Fabricante_IdiomaRepository = Fabricante_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteFabricante_IdiomaCommand command) {
			var Fabricante_Idioma = Fabricante_IdiomaRepository.GetById(command.Id);
			Fabricante_IdiomaRepository.Delete(Fabricante_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}