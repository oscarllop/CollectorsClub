
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteCategoriaCalendario_IdiomaHandler : ICommandHandler<DeleteCategoriaCalendario_IdiomaCommand> {
		private readonly ICategoriaCalendario_IdiomaRepository CategoriaCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteCategoriaCalendario_IdiomaHandler(ICategoriaCalendario_IdiomaRepository CategoriaCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.CategoriaCalendario_IdiomaRepository = CategoriaCalendario_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteCategoriaCalendario_IdiomaCommand command) {
			var CategoriaCalendario_Idioma = CategoriaCalendario_IdiomaRepository.GetById(command.Id);
			CategoriaCalendario_IdiomaRepository.Delete(CategoriaCalendario_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}