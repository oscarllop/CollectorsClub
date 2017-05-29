
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteVideo_IdiomaHandler : ICommandHandler<DeleteVideo_IdiomaCommand> {
		private readonly IVideo_IdiomaRepository Video_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteVideo_IdiomaHandler(IVideo_IdiomaRepository Video_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.Video_IdiomaRepository = Video_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteVideo_IdiomaCommand command) {
			var Video_Idioma = Video_IdiomaRepository.GetById(command.Id);
			Video_IdiomaRepository.Delete(Video_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}