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

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexManager()
		{
		}
	}
}