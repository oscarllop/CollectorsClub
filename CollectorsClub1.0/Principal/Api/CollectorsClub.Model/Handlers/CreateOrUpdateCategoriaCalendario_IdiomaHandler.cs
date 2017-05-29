
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
	public partial class CreateOrUpdateCategoriaCalendario_IdiomaHandler : ICommandHandler<CreateOrUpdateCategoriaCalendario_IdiomaCommand> {
		private readonly ICategoriaCalendario_IdiomaRepository CategoriaCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateCategoriaCalendario_IdiomaHandler(ICategoriaCalendario_IdiomaRepository CategoriaCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.CategoriaCalendario_IdiomaRepository = CategoriaCalendario_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateCategoriaCalendario_IdiomaCommand command) {
			CategoriaCalendario_Idioma _CategoriaCalendario_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateCategoriaCalendario_IdiomaCommand, CategoriaCalendario_Idioma>(command);
			if (command.Id == 0) { CategoriaCalendario_IdiomaRepository.Add(_CategoriaCalendario_Idioma); } else { CategoriaCalendario_IdiomaRepository.Update(_CategoriaCalendario_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<CategoriaCalendario_Idioma, CreateOrUpdateCategoriaCalendario_IdiomaCommand>(_CategoriaCalendario_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}