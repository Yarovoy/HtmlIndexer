package htmlIndexer.mate.commands
{

	import flash.events.Event;

	public class IndexCommand extends IndexManagerCommand
	{

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexCommand()
		{
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);

			trace('IndexCommand.execute()')
		}
	}
}