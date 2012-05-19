package htmlIndexer.mate.commands
{

	import flash.events.Event;

	import htmlIndexer.mate.business.IndexManager;

	public class IndexManagerCommand extends BasicCommand
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var indexManager:IndexManager;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexManagerCommand()
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