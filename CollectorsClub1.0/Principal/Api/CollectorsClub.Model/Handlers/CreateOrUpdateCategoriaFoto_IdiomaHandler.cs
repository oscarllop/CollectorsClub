
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
	public partial class CreateOrUpdateCategoriaFoto_IdiomaHandler : ICommandHandler<CreateOrUpdateCategoriaFoto_IdiomaCommand> {
		private readonly ICategoriaFoto_IdiomaRepository CategoriaFoto_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCategoriaFoto_IdiomaHandler(ICategoriaFoto_IdiomaRepository CategoriaFoto_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.CategoriaFoto_IdiomaRepository = CategoriaFoto_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCategoriaFoto_IdiomaCommand command) {
			CategoriaFoto_Idioma _CategoriaFoto_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateCategoriaFoto_IdiomaCommand, CategoriaFoto_Idioma>(command);
			if (command.Id == 0) { CategoriaFoto_IdiomaRepository.Add(_CategoriaFoto_Idioma); } else { CategoriaFoto_IdiomaRepository.Update(_CategoriaFoto_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<CategoriaFoto_Idioma, CreateOrUpdateCategoriaFoto_IdiomaCommand>(_CategoriaFoto_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}