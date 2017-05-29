
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteSolicitudContactoHandler : ICommandHandler<DeleteSolicitudContactoCommand> {
		private readonly ISolicitudContactoRepository SolicitudContactoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteSolicitudContactoHandler(ISolicitudContactoRepository SolicitudContactoRepository, IUnitOfWork unitOfWork) {
				this.SolicitudContactoRepository = SolicitudContactoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteSolicitudContactoCommand command) {
			var SolicitudContacto = SolicitudContactoRepository.GetById(command.Id);
			SolicitudContactoRepository.Delete(SolicitudContacto);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}