
using System;
using System.Collections.Generic;
using CollectorsClub.Data.Command;
using CollectorsClub.Model.Commands;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;

namespace CollectorsClub.Model.Handlers {
	public partial class DeleteSubcategoriaCalendarioHandler : ICommandHandler<DeleteSubcategoriaCalendarioCommand> {
		private readonly ISubcategoriaCalendarioRepository SubcategoriaCalendarioRepository;
		private readonly IUnitOfWork unitOfWork;
		public DeleteSubcategoriaCalendarioHandler(ISubcategoriaCalendarioRepository SubcategoriaCalendarioRepository, IUnitOfWork unitOfWork) {
				this.SubcategoriaCalendarioRepository = SubcategoriaCalendarioRepository;
				this.unitOfWork = unitOfWork;
		}
		public ICommandResult Execute(DeleteSubcategoriaCalendarioCommand command) {
			var SubcategoriaCalendario = SubcategoriaCalendarioRepository.GetById(command.Id);
			SubcategoriaCalendarioRepository.Delete(SubcategoriaCalendario);
			unitOfWork.Commit();
			return new CommandResult(true);
		}
	}
}