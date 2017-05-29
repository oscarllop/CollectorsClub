
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
	public partial class CreateOrUpdateTipoColeccionCalendario_IdiomaHandler : ICommandHandler<CreateOrUpdateTipoColeccionCalendario_IdiomaCommand> {
		private readonly ITipoColeccionCalendario_IdiomaRepository TipoColeccionCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateTipoColeccionCalendario_IdiomaHandler(ITipoColeccionCalendario_IdiomaRepository TipoColeccionCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.TipoColeccionCalendario_IdiomaRepository = TipoColeccionCalendario_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateTipoColeccionCalendario_IdiomaCommand command) {
			TipoColeccionCalendario_Idioma _TipoColeccionCalendario_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateTipoColeccionCalendario_IdiomaCommand, TipoColeccionCalendario_Idioma>(command);
			if (command.Id == 0) { TipoColeccionCalendario_IdiomaRepository.Add(_TipoColeccionCalendario_Idioma); } else { TipoColeccionCalendario_IdiomaRepository.Update(_TipoColeccionCalendario_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<TipoColeccionCalendario_Idioma, CreateOrUpdateTipoColeccionCalendario_IdiomaCommand>(_TipoColeccionCalendario_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}