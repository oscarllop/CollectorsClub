
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteFotoHandler : ICommandHandler<DeleteFotoCommand> {
		private readonly IFotoRepository FotoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteFotoHandler(IFotoRepository FotoRepository, IUnitOfWork unitOfWork) {
				this.FotoRepository = FotoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteFotoCommand command) {
			var Foto = FotoRepository.GetById(command.Id);
			FotoRepository.Delete(Foto);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}