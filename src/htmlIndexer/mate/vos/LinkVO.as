package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	public class LinkVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var text:String;

		[Bindable]
		public var url:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function LinkVO()
		{
		}
	}
}