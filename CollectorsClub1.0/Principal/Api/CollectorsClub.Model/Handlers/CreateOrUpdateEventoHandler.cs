
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
	public partial class CreateOrUpdateEventoHandler : ICommandHandler<CreateOrUpdateEventoCommand> {
		private readonly IEventoRepository EventoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEventoHandler(IEventoRepository EventoRepository, IUnitOfWork unitOfWork) {
			this.EventoRepository = EventoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEventoCommand command) {
			Evento _Evento = AutoMapper.Mapper.Map<CreateOrUpdateEventoCommand, Evento>(command);
			if (command.Id == 0) { EventoRepository.Add(_Evento); } else { EventoRepository.Update(_Evento); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Evento, CreateOrUpdateEventoCommand>(_Evento, command);
	
			return new CommandResult(true);
		}
	}
}