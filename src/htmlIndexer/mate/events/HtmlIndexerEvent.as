package htmlIndexer.mate.events
{

	import flash.events.Event;

	public class HtmlIndexerEvent extends Event
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		public static const INDEX_PAGE:String = 'indexPage';
		public static const EXPORT_CSV:String = 'exportCsv';

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function HtmlIndexerEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function clone():Event
		{
			return new HtmlIndexerEvent(type, bubbles, cancelable);
		}
	}
}