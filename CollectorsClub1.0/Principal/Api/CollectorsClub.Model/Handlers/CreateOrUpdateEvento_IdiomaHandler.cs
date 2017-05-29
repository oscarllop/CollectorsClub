
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
	public partial class CreateOrUpdateEvento_IdiomaHandler : ICommandHandler<CreateOrUpdateEvento_IdiomaCommand> {
		private readonly IEvento_IdiomaRepository Evento_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEvento_IdiomaHandler(IEvento_IdiomaRepository Evento_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Evento_IdiomaRepository = Evento_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEvento_IdiomaCommand command) {
			Evento_Idioma _Evento_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateEvento_IdiomaCommand, Evento_Idioma>(command);
			if (command.Id == 0) { Evento_IdiomaRepository.Add(_Evento_Idioma); } else { Evento_IdiomaRepository.Update(_Evento_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Evento_Idioma, CreateOrUpdateEvento_IdiomaCommand>(_Evento_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}