
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
	public partial class CreateOrUpdateFoto_IdiomaHandler : ICommandHandler<CreateOrUpdateFoto_IdiomaCommand> {
		private readonly IFoto_IdiomaRepository Foto_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateFoto_IdiomaHandler(IFoto_IdiomaRepository Foto_IdiomaRepository, IUnitOfWork unitOfWork) {
			this.Foto_IdiomaRepository = Foto_IdiomaRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateFoto_IdiomaCommand command) {
			Foto_Idioma _Foto_Idioma = AutoMapper.Mapper.Map<CreateOrUpdateFoto_IdiomaCommand, Foto_Idioma>(command);
			if (command.Id == 0) { Foto_IdiomaRepository.Add(_Foto_Idioma); } else { Foto_IdiomaRepository.Update(_Foto_Idioma); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Foto_Idioma, CreateOrUpdateFoto_IdiomaCommand>(_Foto_Idioma, command);
	
			return new CommandResult(true);
		}
	}
}