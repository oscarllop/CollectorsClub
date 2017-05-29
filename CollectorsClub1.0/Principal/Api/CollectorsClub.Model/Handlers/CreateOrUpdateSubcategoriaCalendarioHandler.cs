
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
	public partial class CreateOrUpdateSubcategoriaCalendarioHandler : ICommandHandler<CreateOrUpdateSubcategoriaCalendarioCommand> {
		private readonly ISubcategoriaCalendarioRepository SubcategoriaCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateSubcategoriaCalendarioHandler(ISubcategoriaCalendarioRepository SubcategoriaCalendarioRepository, IUnitOfWork unitOfWork) {
			this.SubcategoriaCalendarioRepository = SubcategoriaCalendarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateSubcategoriaCalendarioCommand command) {
			SubcategoriaCalendario _SubcategoriaCalendario = AutoMapper.Mapper.Map<CreateOrUpdateSubcategoriaCalendarioCommand, SubcategoriaCalendario>(command);
			if (command.Id == 0) { SubcategoriaCalendarioRepository.Add(_SubcategoriaCalendario); } else { SubcategoriaCalendarioRepository.Update(_SubcategoriaCalendario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<SubcategoriaCalendario, CreateOrUpdateSubcategoriaCalendarioCommand>(_SubcategoriaCalendario, command);
	
			return new CommandResult(true);
		}
	}
}