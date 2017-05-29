
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteSubcategoriaCalendario_IdiomaHandler : ICommandHandler<DeleteSubcategoriaCalendario_IdiomaCommand> {
		private readonly ISubcategoriaCalendario_IdiomaRepository SubcategoriaCalendario_IdiomaRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteSubcategoriaCalendario_IdiomaHandler(ISubcategoriaCalendario_IdiomaRepository SubcategoriaCalendario_IdiomaRepository, IUnitOfWork unitOfWork) {
				this.SubcategoriaCalendario_IdiomaRepository = SubcategoriaCalendario_IdiomaRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteSubcategoriaCalendario_IdiomaCommand command) {
			var SubcategoriaCalendario_Idioma = SubcategoriaCalendario_IdiomaRepository.GetById(command.Id);
			SubcategoriaCalendario_IdiomaRepository.Delete(SubcategoriaCalendario_Idioma);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}