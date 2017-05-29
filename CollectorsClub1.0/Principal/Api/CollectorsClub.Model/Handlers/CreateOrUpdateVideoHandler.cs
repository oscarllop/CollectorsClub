
using System;
using System.Collections.Generic;
using AutoMapper;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;
using System.Linq;

namespace CollectorsClub.Model.Handlers {
	public partial class CreateOrUpdateVideoHandler : ICommandHandler<CreateOrUpdateVideoCommand> {
		private readonly IVideoRepository VideoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateVideoHandler(IVideoRepository VideoRepository, IUnitOfWork unitOfWork) {
			this.VideoRepository = VideoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateVideoCommand command) {
			Video _Video = AutoMapper.Mapper.Map<CreateOrUpdateVideoCommand, Video>(command);
			if (command.Id == 0) { VideoRepository.Add(_Video); } else { VideoRepository.Update(_Video); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Video, CreateOrUpdateVideoCommand>(_Video, command);
	
			return new CommandResult(true);
		}
	}
}