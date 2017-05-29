
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
	public partial class CreateOrUpdateEntidad_IdiomaHandler : ICommandHandler<CreateOrUpdateEntidad_IdiomaCommand> {
		private readonly IEntidad_IdiomaRepository Entidad_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateEntidad_IdiomaHandler(IEntidad_IdiomaRepository Entidad_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Entidad_IdiomaRepository = Entidad_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateEntidad_IdiomaCommand command) {
			Entidad_Idioma _Entidad_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateEntidad_IdiomaCommand, Entidad_Idioma>(command);
			if (command.Id == 0) { Entidad_IdiomaRepository.Add(_Entidad_Idioma); } else { Entidad_IdiomaRepository.Update(_Entidad_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Entidad_Idioma, CreateOrUpdateEntidad_IdiomaCommand>(_Entidad_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}