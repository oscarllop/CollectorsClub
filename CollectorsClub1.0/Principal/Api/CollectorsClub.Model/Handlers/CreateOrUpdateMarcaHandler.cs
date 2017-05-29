
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
	public partial class CreateOrUpdateMarcaHandler : ICommandHandler<CreateOrUpdateMarcaCommand> {
		private readonly IMarcaRepository MarcaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateMarcaHandler(IMarcaRepository MarcaRepository, IUnitOfWork unitOfWork) {
			this.MarcaRepository = MarcaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateMarcaCommand command) {
			Marca _Marca = AutoMapper.Mapper.Map<CreateOrUpdateMarcaCommand, Marca>(command);
			if (!MarcaRepository.Exist(p => p.Id == command.Id)) { MarcaRepository.Add(_Marca); } else { MarcaRepository.Update(_Marca); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Marca, CreateOrUpdateMarcaCommand>(_Marca, command);
	
			return new CommandResult(true);
		}
	}
}