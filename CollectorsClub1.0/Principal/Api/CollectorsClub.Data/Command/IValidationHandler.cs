using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CollectorsClub.Data.Common;

namespace CollectorsClub.Data.Command {
	public interface IValidationHandler<in TCommand> where TCommand : ICommand {
		IEnumerable<ValidationResult> Validate(TCommand command);
	}
}
