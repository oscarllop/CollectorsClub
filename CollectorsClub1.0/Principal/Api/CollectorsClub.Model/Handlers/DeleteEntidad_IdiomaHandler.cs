
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteEntidad_IdiomaHandler : ICommandHandler<DeleteEntidad_IdiomaCommand> {
		private readonly IEntidad_IdiomaRepository Entidad_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteEntidad_IdiomaHandler(IEntidad_IdiomaRepository Entidad_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Entidad_IdiomaRepository = Entidad_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteEntidad_IdiomaCommand command) {
			var Entidad_Idioma = Entidad_IdiomaRepository.GetById(command.Id);
			Entidad_IdiomaRepository.Delete(Entidad_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}