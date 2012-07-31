package htmlIndexer.mate.commands.db
{

	import flash.events.Event;

	public class DbCloseConnectionCommand extends DbCommand
	{

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function DbCloseConnectionCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event = null):void
		{
			super.execute(event);

			dbManager.sqlConnection.close();
		}
	}
}