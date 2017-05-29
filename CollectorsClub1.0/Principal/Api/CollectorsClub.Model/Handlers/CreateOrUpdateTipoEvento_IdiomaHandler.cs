
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
	public partial class CreateOrUpdateTipoEvento_IdiomaHandler : ICommandHandler<CreateOrUpdateTipoEvento_IdiomaCommand> {
		private readonly ITipoEvento_IdiomaRepository TipoEvento_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateTipoEvento_IdiomaHandler(ITipoEvento_IdiomaRepository TipoEvento_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.TipoEvento_IdiomaRepository = TipoEvento_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateTipoEvento_IdiomaCommand command) {
			TipoEvento_Idioma _TipoEvento_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateTipoEvento_IdiomaCommand, TipoEvento_Idioma>(command);
			if (command.Id == 0) { TipoEvento_IdiomaRepository.Add(_TipoEvento_Idioma); } else { TipoEvento_IdiomaRepository.Update(_TipoEvento_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<TipoEvento_Idioma, CreateOrUpdateTipoEvento_IdiomaCommand>(_TipoEvento_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}