package htmlIndexer.mate.business
{

	import flash.events.EventDispatcher;

	import htmlIndexer.mate.vos.PageVO;

	import mx.collections.ArrayCollection;

	public class HtmlIndexerModel extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var currentState:String;

		[Bindable]
		public var lastIndexedPage:PageVO;

		[Bindable]
		public var lastIndexedLinks:ArrayCollection;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function HtmlIndexerModel()
		{
		}
	}
}