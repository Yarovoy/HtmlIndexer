package htmlIndexer.mate.commands.db
{

	import htmlIndexer.mate.commands.*;

	import flash.events.Event;

	import nz.co.codec.flexorm.EntityManager;

	public class DbCommand extends BasicCommand
	{

		// ----------------------------------------------------------------------
		// Protected props
		// ----------------------------------------------------------------------

		protected var dbManager:EntityManager = EntityManager.instance;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function DbCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);
		}
	}
}