
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteTipoColeccionCalendario_IdiomaHandler : ICommandHandler<DeleteTipoColeccionCalendario_IdiomaCommand> {
		private readonly ITipoColeccionCalendario_IdiomaRepository TipoColeccionCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteTipoColeccionCalendario_IdiomaHandler(ITipoColeccionCalendario_IdiomaRepository TipoColeccionCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.TipoColeccionCalendario_IdiomaRepository = TipoColeccionCalendario_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteTipoColeccionCalendario_IdiomaCommand command) {
			var TipoColeccionCalendario_Idioma = TipoColeccionCalendario_IdiomaRepository.GetById(command.Id);
			TipoColeccionCalendario_IdiomaRepository.Delete(TipoColeccionCalendario_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}