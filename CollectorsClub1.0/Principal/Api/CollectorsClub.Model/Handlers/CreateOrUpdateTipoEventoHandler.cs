
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
	public partial class CreateOrUpdateTipoEventoHandler : ICommandHandler<CreateOrUpdateTipoEventoCommand> {
		private readonly ITipoEventoRepository TipoEventoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateTipoEventoHandler(ITipoEventoRepository TipoEventoRepository, IUnitOfWork unitOfWork) {
			this.TipoEventoRepository = TipoEventoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateTipoEventoCommand command) {
			TipoEvento _TipoEvento = AutoMapper.Mapper.Map<CreateOrUpdateTipoEventoCommand, TipoEvento>(command);
			if (command.Id == 0) { TipoEventoRepository.Add(_TipoEvento); } else { TipoEventoRepository.Update(_TipoEvento); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<TipoEvento, CreateOrUpdateTipoEventoCommand>(_TipoEvento, command);
	
			return new CommandResult(true);
		}
	}
}