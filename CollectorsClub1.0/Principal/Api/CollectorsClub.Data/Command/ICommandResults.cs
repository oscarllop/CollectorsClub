namespace CollectorsClub.Data.Command {
	public interface ICommandResults {
		ICommandResult[] Results { get; }

		bool Success { get; }
	}
}

