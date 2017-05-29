
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
	public partial class CreateOrUpdateUsuarioHandler : ICommandHandler<CreateOrUpdateUsuarioCommand> {
		private readonly IUsuarioRepository UsuarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public CreateOrUpdateUsuarioHandler(IUsuarioRepository UsuarioRepository, IUnitOfWork unitOfWork) {
			this.UsuarioRepository = UsuarioRepository;
			this.unitOfWork = unitOfWork;
		}
	
		public ICommandResult Execute(CreateOrUpdateUsuarioCommand command) {
			Usuario _Usuario = AutoMapper.Mapper.Map<CreateOrUpdateUsuarioCommand, Usuario>(command);
			if (command.Id == 0) { UsuarioRepository.Add(_Usuario); } else { UsuarioRepository.Update(_Usuario); }
			unitOfWork.Commit();
	
			AutoMapper.Mapper.Map<Usuario, CreateOrUpdateUsuarioCommand>(_Usuario, command);
	
			return new CommandResult(true);
		}
	}
}