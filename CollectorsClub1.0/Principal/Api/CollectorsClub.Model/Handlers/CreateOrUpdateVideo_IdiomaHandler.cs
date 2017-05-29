
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
	public partial class CreateOrUpdateVideo_IdiomaHandler : ICommandHandler<CreateOrUpdateVideo_IdiomaCommand> {
		private readonly IVideo_IdiomaRepository Video_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateVideo_IdiomaHandler(IVideo_IdiomaRepository Video_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Video_IdiomaRepository = Video_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateVideo_IdiomaCommand command) {
			Video_Idioma _Video_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateVideo_IdiomaCommand, Video_Idioma>(command);
			if (command.Id == 0) { Video_IdiomaRepository.Add(_Video_Idioma); } else { Video_IdiomaRepository.Update(_Video_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Video_Idioma, CreateOrUpdateVideo_IdiomaCommand>(_Video_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}