
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
	public partial class CreateOrUpdateEstadoCalendario_IdiomaHandler : ICommandHandler<CreateOrUpdateEstadoCalendario_IdiomaCommand> {
		private readonly IEstadoCalendario_IdiomaRepository EstadoCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEstadoCalendario_IdiomaHandler(IEstadoCalendario_IdiomaRepository EstadoCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.EstadoCalendario_IdiomaRepository = EstadoCalendario_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEstadoCalendario_IdiomaCommand command) {
			EstadoCalendario_Idioma _EstadoCalendario_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateEstadoCalendario_IdiomaCommand, EstadoCalendario_Idioma>(command);
			if (command.Id == 0) { EstadoCalendario_IdiomaRepository.Add(_EstadoCalendario_Idioma); } else { EstadoCalendario_IdiomaRepository.Update(_EstadoCalendario_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<EstadoCalendario_Idioma, CreateOrUpdateEstadoCalendario_IdiomaCommand>(_EstadoCalendario_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}