
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
	public partial class CreateOrUpdateCalendario_IdiomaHandler : ICommandHandler<CreateOrUpdateCalendario_IdiomaCommand> {
		private readonly ICalendario_IdiomaRepository Calendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCalendario_IdiomaHandler(ICalendario_IdiomaRepository Calendario_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Calendario_IdiomaRepository = Calendario_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCalendario_IdiomaCommand command) {
			Calendario_Idioma _Calendario_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateCalendario_IdiomaCommand, Calendario_Idioma>(command);
			if (command.Id == 0) { Calendario_IdiomaRepository.Add(_Calendario_Idioma); } else { Calendario_IdiomaRepository.Update(_Calendario_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Calendario_Idioma, CreateOrUpdateCalendario_IdiomaCommand>(_Calendario_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}