
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
	public partial class CreateOrUpdateFotoHandler : ICommandHandler<CreateOrUpdateFotoCommand> {
		private readonly IFotoRepository FotoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateFotoHandler(IFotoRepository FotoRepository, IUnitOfWork unitOfWork) {
			this.FotoRepository = FotoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateFotoCommand command) {
			Foto _Foto = AutoMapper.Mapper.Map<CreateOrUpdateFotoCommand, Foto>(command);
			if (command.Id == 0) { FotoRepository.Add(_Foto); } else { FotoRepository.Update(_Foto); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Foto, CreateOrUpdateFotoCommand>(_Foto, command);
	
			return new CommandResult(true);
		}
	}
}