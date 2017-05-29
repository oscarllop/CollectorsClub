
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteTipoEvento_IdiomaHandler : ICommandHandler<DeleteTipoEvento_IdiomaCommand> {
		private readonly ITipoEvento_IdiomaRepository TipoEvento_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteTipoEvento_IdiomaHandler(ITipoEvento_IdiomaRepository TipoEvento_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.TipoEvento_IdiomaRepository = TipoEvento_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteTipoEvento_IdiomaCommand command) {
			var TipoEvento_Idioma = TipoEvento_IdiomaRepository.GetById(command.Id);
			TipoEvento_IdiomaRepository.Delete(TipoEvento_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}