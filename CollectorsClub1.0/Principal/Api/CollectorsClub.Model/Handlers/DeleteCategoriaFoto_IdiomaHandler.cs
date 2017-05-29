
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCategoriaFoto_IdiomaHandler : ICommandHandler<DeleteCategoriaFoto_IdiomaCommand> {
		private readonly ICategoriaFoto_IdiomaRepository CategoriaFoto_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCategoriaFoto_IdiomaHandler(ICategoriaFoto_IdiomaRepository CategoriaFoto_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.CategoriaFoto_IdiomaRepository = CategoriaFoto_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCategoriaFoto_IdiomaCommand command) {
			var CategoriaFoto_Idioma = CategoriaFoto_IdiomaRepository.GetById(command.Id);
			CategoriaFoto_IdiomaRepository.Delete(CategoriaFoto_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}