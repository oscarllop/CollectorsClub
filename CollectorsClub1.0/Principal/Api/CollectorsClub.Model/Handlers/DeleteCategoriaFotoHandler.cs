
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCategoriaFotoHandler : ICommandHandler<DeleteCategoriaFotoCommand> {
		private readonly ICategoriaFotoRepository CategoriaFotoRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCategoriaFotoHandler(ICategoriaFotoRepository CategoriaFotoRepository, IUnitOfWork unitOfWork) {
				this.CategoriaFotoRepository = CategoriaFotoRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCategoriaFotoCommand command) {
			var CategoriaFoto = CategoriaFotoRepository.GetById(command.Id);
			CategoriaFotoRepository.Delete(CategoriaFoto);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}