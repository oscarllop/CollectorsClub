
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
	public partial class CreateOrUpdateCalendarioHandler : ICommandHandler<CreateOrUpdateCalendarioCommand> {
		private readonly ICalendarioRepository CalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCalendarioHandler(ICalendarioRepository CalendarioRepository, IUnitOfWork unitOfWork) {
			this.CalendarioRepository = CalendarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCalendarioCommand command) {
			Calendario _Calendario = AutoMapper.Mapper.Map<CreateOrUpdateCalendarioCommand, Calendario>(command);
			if (command.Id == 0) { CalendarioRepository.Add(_Calendario); } else { CalendarioRepository.Update(_Calendario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Calendario, CreateOrUpdateCalendarioCommand>(_Calendario, command);
	
			return new CommandResult(true);
		}
	}
}