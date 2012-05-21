package htmlIndexer.mate.business
{

	import flash.events.EventDispatcher;

	public class IndexManager extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var pages:Array = [];

		[Bindable]
		public var state:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexManager()
		{
		}
	}
}