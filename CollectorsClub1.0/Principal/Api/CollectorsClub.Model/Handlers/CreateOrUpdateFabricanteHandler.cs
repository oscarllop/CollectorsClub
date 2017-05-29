
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
	public partial class CreateOrUpdateFabricanteHandler : ICommandHandler<CreateOrUpdateFabricanteCommand> {
		private readonly IFabricanteRepository FabricanteRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateFabricanteHandler(IFabricanteRepository FabricanteRepository, IUnitOfWork unitOfWork) {
			this.FabricanteRepository = FabricanteRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateFabricanteCommand command) {
			Fabricante _Fabricante = AutoMapper.Mapper.Map<CreateOrUpdateFabricanteCommand, Fabricante>(command);
			if (command.Id == 0) { FabricanteRepository.Add(_Fabricante); } else { FabricanteRepository.Update(_Fabricante); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Fabricante, CreateOrUpdateFabricanteCommand>(_Fabricante, command);
	
			return new CommandResult(true);
		}
	}
}