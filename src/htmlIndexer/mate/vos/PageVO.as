package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	public class PageVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var url:String;

		[Bindable]
		public var links:Array = [];

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function PageVO()
		{
		}
	}
}