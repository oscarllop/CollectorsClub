
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteMarcaHandler : ICommandHandler<DeleteMarcaCommand> {
		private readonly IMarcaRepository MarcaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteMarcaHandler(IMarcaRepository MarcaRepository, IUnitOfWork unitOfWork) {
				this.MarcaRepository = MarcaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteMarcaCommand command) {
			var Marca = MarcaRepository.GetById(command.Id);
			MarcaRepository.Delete(Marca);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}