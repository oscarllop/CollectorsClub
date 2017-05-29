
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCategoriaCalendarioHandler : ICommandHandler<DeleteCategoriaCalendarioCommand> {
		private readonly ICategoriaCalendarioRepository CategoriaCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCategoriaCalendarioHandler(ICategoriaCalendarioRepository CategoriaCalendarioRepository, IUnitOfWork unitOfWork) {
				this.CategoriaCalendarioRepository = CategoriaCalendarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCategoriaCalendarioCommand command) {
			var CategoriaCalendario = CategoriaCalendarioRepository.GetById(command.Id);
			CategoriaCalendarioRepository.Delete(CategoriaCalendario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}