
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
	public partial class CreateOrUpdateEstadoCalendarioHandler : ICommandHandler<CreateOrUpdateEstadoCalendarioCommand> {
		private readonly IEstadoCalendarioRepository EstadoCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEstadoCalendarioHandler(IEstadoCalendarioRepository EstadoCalendarioRepository, IUnitOfWork unitOfWork) {
			this.EstadoCalendarioRepository = EstadoCalendarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEstadoCalendarioCommand command) {
			EstadoCalendario _EstadoCalendario = AutoMapper.Mapper.Map<CreateOrUpdateEstadoCalendarioCommand, EstadoCalendario>(command);
			if (command.Id == 0) { EstadoCalendarioRepository.Add(_EstadoCalendario); } else { EstadoCalendarioRepository.Update(_EstadoCalendario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<EstadoCalendario, CreateOrUpdateEstadoCalendarioCommand>(_EstadoCalendario, command);
	
			return new CommandResult(true);
		}
	}
}