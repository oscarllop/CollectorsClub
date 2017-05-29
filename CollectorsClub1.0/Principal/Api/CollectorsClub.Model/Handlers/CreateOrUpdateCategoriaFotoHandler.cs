
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
	public partial class CreateOrUpdateCategoriaFotoHandler : ICommandHandler<CreateOrUpdateCategoriaFotoCommand> {
		private readonly ICategoriaFotoRepository CategoriaFotoRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCategoriaFotoHandler(ICategoriaFotoRepository CategoriaFotoRepository, IUnitOfWork unitOfWork) {
			this.CategoriaFotoRepository = CategoriaFotoRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCategoriaFotoCommand command) {
			CategoriaFoto _CategoriaFoto = AutoMapper.Mapper.Map<CreateOrUpdateCategoriaFotoCommand, CategoriaFoto>(command);
			if (command.Id == 0) { CategoriaFotoRepository.Add(_CategoriaFoto); } else { CategoriaFotoRepository.Update(_CategoriaFoto); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<CategoriaFoto, CreateOrUpdateCategoriaFotoCommand>(_CategoriaFoto, command);
	
			return new CommandResult(true);
		}
	}
}