
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
	public partial class CreateOrUpdateSolicitudContactoHandler : ICommandHandler<CreateOrUpdateSolicitudContactoCommand> {
		private readonly ISolicitudContactoRepository SolicitudContactoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateSolicitudContactoHandler(ISolicitudContactoRepository SolicitudContactoRepository, IUnitOfWork unitOfWork) {
			this.SolicitudContactoRepository = SolicitudContactoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateSolicitudContactoCommand command) {
			SolicitudContacto _SolicitudContacto = AutoMapper.Mapper.Map<CreateOrUpdateSolicitudContactoCommand, SolicitudContacto>(command);
			if (command.Id == 0) { SolicitudContactoRepository.Add(_SolicitudContacto); } else { SolicitudContactoRepository.Update(_SolicitudContacto); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<SolicitudContacto, CreateOrUpdateSolicitudContactoCommand>(_SolicitudContacto, command);
	
			return new CommandResult(true);
		}
	}
}