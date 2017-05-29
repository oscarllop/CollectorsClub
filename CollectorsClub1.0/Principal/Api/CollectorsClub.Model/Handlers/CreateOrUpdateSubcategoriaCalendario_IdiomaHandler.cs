
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
	public partial class CreateOrUpdateSubcategoriaCalendario_IdiomaHandler : ICommandHandler<CreateOrUpdateSubcategoriaCalendario_IdiomaCommand> {
		private readonly ISubcategoriaCalendario_IdiomaRepository SubcategoriaCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateSubcategoriaCalendario_IdiomaHandler(ISubcategoriaCalendario_IdiomaRepository SubcategoriaCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.SubcategoriaCalendario_IdiomaRepository = SubcategoriaCalendario_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateSubcategoriaCalendario_IdiomaCommand command) {
			SubcategoriaCalendario_Idioma _SubcategoriaCalendario_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateSubcategoriaCalendario_IdiomaCommand, SubcategoriaCalendario_Idioma>(command);
			if (command.Id == 0) { SubcategoriaCalendario_IdiomaRepository.Add(_SubcategoriaCalendario_Idioma); } else { SubcategoriaCalendario_IdiomaRepository.Update(_SubcategoriaCalendario_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<SubcategoriaCalendario_Idioma, CreateOrUpdateSubcategoriaCalendario_IdiomaCommand>(_SubcategoriaCalendario_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}