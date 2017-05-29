
using CollectorsClub.Data.Command;
using CollectorsClub.Data.Common;
using System.Collections.Generic;

namespace CollectorsClub.Data.Dispatcher {
	public interface ICommandBus {
		ICommandResult Submit<TCommand>(TCommand command) where TCommand : ICommand;
		IEnumerable<ValidationResult> Validate<TCommand>(TCommand command) where TCommand : ICommand;
	}
}

