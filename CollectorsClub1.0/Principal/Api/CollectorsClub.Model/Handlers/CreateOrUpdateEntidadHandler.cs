
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
	public partial class CreateOrUpdateEntidadHandler : ICommandHandler<CreateOrUpdateEntidadCommand> {
		private readonly IEntidadRepository EntidadRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEntidadHandler(IEntidadRepository EntidadRepository, IUnitOfWork unitOfWork) {
			this.EntidadRepository = EntidadRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEntidadCommand command) {
			Entidad _Entidad = AutoMapper.Mapper.Map<CreateOrUpdateEntidadCommand, Entidad>(command);
			if (command.Id == 0) { EntidadRepository.Add(_Entidad); } else { EntidadRepository.Update(_Entidad); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Entidad, CreateOrUpdateEntidadCommand>(_Entidad, command);
	
			return new CommandResult(true);
		}
	}
}