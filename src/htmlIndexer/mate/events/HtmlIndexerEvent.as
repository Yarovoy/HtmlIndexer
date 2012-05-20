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
		// Public props
		// ----------------------------------------------------------------------

		public var url:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function HtmlIndexerEvent(type:String, url:String = null, bubbles:Boolean = true,
		                                 cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);

			this.url = url;
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function clone():Event
		{
			return new HtmlIndexerEvent(type, url, bubbles, cancelable);
		}
	}
}