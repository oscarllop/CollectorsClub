
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
	public partial class CreateOrUpdateCategoriaCalendarioHandler : ICommandHandler<CreateOrUpdateCategoriaCalendarioCommand> {
		private readonly ICategoriaCalendarioRepository CategoriaCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCategoriaCalendarioHandler(ICategoriaCalendarioRepository CategoriaCalendarioRepository, IUnitOfWork unitOfWork) {
			this.CategoriaCalendarioRepository = CategoriaCalendarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCategoriaCalendarioCommand command) {
			CategoriaCalendario _CategoriaCalendario = AutoMapper.Mapper.Map<CreateOrUpdateCategoriaCalendarioCommand, CategoriaCalendario>(command);
			if (command.Id == 0) { CategoriaCalendarioRepository.Add(_CategoriaCalendario); } else { CategoriaCalendarioRepository.Update(_CategoriaCalendario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<CategoriaCalendario, CreateOrUpdateCategoriaCalendarioCommand>(_CategoriaCalendario, command);
	
			return new CommandResult(true);
		}
	}
}