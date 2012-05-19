package htmlIndexer.mate.commands
{

	import flash.events.Event;

	public class ExportCsvCommand extends IndexManagerCommand
	{

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function ExportCsvCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);

			trace('ExportCsvCommand.execute()');
		}
	}
}