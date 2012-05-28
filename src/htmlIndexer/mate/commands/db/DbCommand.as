package htmlIndexer.mate.commands.db
{

	import flash.events.Event;

	import htmlIndexer.mate.commands.*;

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

		override public function execute(event:Event = null):void
		{
			super.execute(event);
		}
	}
}