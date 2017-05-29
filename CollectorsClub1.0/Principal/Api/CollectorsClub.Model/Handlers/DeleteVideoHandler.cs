
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteVideoHandler : ICommandHandler<DeleteVideoCommand> {
		private readonly IVideoRepository VideoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteVideoHandler(IVideoRepository VideoRepository, IUnitOfWork unitOfWork) {
				this.VideoRepository = VideoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteVideoCommand command) {
			var Video = VideoRepository.GetById(command.Id);
			VideoRepository.Delete(Video);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}