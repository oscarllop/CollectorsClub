
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteUsuarioHandler : ICommandHandler<DeleteUsuarioCommand> {
		private readonly IUsuarioRepository UsuarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteUsuarioHandler(IUsuarioRepository UsuarioRepository, IUnitOfWork unitOfWork) {
				this.UsuarioRepository = UsuarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteUsuarioCommand command) {
			var Usuario = UsuarioRepository.GetById(command.Id);
			UsuarioRepository.Delete(Usuario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}