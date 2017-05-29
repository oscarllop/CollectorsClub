
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteFoto_IdiomaHandler : ICommandHandler<DeleteFoto_IdiomaCommand> {
		private readonly IFoto_IdiomaRepository Foto_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteFoto_IdiomaHandler(IFoto_IdiomaRepository Foto_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Foto_IdiomaRepository = Foto_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteFoto_IdiomaCommand command) {
			var Foto_Idioma = Foto_IdiomaRepository.GetById(command.Id);
			Foto_IdiomaRepository.Delete(Foto_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}