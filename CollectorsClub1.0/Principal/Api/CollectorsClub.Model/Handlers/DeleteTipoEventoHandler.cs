
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteTipoEventoHandler : ICommandHandler<DeleteTipoEventoCommand> {
		private readonly ITipoEventoRepository TipoEventoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteTipoEventoHandler(ITipoEventoRepository TipoEventoRepository, IUnitOfWork unitOfWork) {
				this.TipoEventoRepository = TipoEventoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteTipoEventoCommand command) {
			var TipoEvento = TipoEventoRepository.GetById(command.Id);
			TipoEventoRepository.Delete(TipoEvento);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}