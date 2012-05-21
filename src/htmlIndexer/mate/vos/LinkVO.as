package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	public class LinkVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var url:String;

		[Bindable]
		public var text:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function LinkVO(url:String = null, text:String = null)
		{
			this.url = url;
			this.text = text;
		}
	}
}