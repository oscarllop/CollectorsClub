
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
	public partial class CreateOrUpdateFabricante_IdiomaHandler : ICommandHandler<CreateOrUpdateFabricante_IdiomaCommand> {
		private readonly IFabricante_IdiomaRepository Fabricante_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateFabricante_IdiomaHandler(IFabricante_IdiomaRepository Fabricante_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Fabricante_IdiomaRepository = Fabricante_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateFabricante_IdiomaCommand command) {
			Fabricante_Idioma _Fabricante_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateFabricante_IdiomaCommand, Fabricante_Idioma>(command);
			if (command.Id == 0) { Fabricante_IdiomaRepository.Add(_Fabricante_Idioma); } else { Fabricante_IdiomaRepository.Update(_Fabricante_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Fabricante_Idioma, CreateOrUpdateFabricante_IdiomaCommand>(_Fabricante_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}