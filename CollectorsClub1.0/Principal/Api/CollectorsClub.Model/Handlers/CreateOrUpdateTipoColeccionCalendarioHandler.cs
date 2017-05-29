
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
	public partial class CreateOrUpdateTipoColeccionCalendarioHandler : ICommandHandler<CreateOrUpdateTipoColeccionCalendarioCommand> {
		private readonly ITipoColeccionCalendarioRepository TipoColeccionCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateTipoColeccionCalendarioHandler(ITipoColeccionCalendarioRepository TipoColeccionCalendarioRepository, IUnitOfWork unitOfWork) {
			this.TipoColeccionCalendarioRepository = TipoColeccionCalendarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateTipoColeccionCalendarioCommand command) {
			TipoColeccionCalendario _TipoColeccionCalendario = AutoMapper.Mapper.Map<CreateOrUpdateTipoColeccionCalendarioCommand, TipoColeccionCalendario>(command);
			if (command.Id == 0) { TipoColeccionCalendarioRepository.Add(_TipoColeccionCalendario); } else { TipoColeccionCalendarioRepository.Update(_TipoColeccionCalendario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<TipoColeccionCalendario, CreateOrUpdateTipoColeccionCalendarioCommand>(_TipoColeccionCalendario, command);
	
			return new CommandResult(true);
		}
	}
}