package htmlIndexer.mate.commands.db
{

	import flash.events.Event;

	import nz.co.codec.flexorm.EntityManager;

	public class DbOpenConnectionCommand extends DbCommand
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const DB_NAME:String = 'links.db';

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function DbOpenConnectionCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);

			dbManager.openSyncConnection(DB_NAME);
		}
	}
}