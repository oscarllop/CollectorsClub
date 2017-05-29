
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteTipoColeccionCalendarioHandler : ICommandHandler<DeleteTipoColeccionCalendarioCommand> {
		private readonly ITipoColeccionCalendarioRepository TipoColeccionCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteTipoColeccionCalendarioHandler(ITipoColeccionCalendarioRepository TipoColeccionCalendarioRepository, IUnitOfWork unitOfWork) {
				this.TipoColeccionCalendarioRepository = TipoColeccionCalendarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteTipoColeccionCalendarioCommand command) {
			var TipoColeccionCalendario = TipoColeccionCalendarioRepository.GetById(command.Id);
			TipoColeccionCalendarioRepository.Delete(TipoColeccionCalendario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}