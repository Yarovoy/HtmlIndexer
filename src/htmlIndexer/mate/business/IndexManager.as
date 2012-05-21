package htmlIndexer.mate.business
{

	import flash.events.EventDispatcher;

	import htmlIndexer.mate.vos.PageVO;

	import mx.collections.ArrayCollection;

	public class IndexManager extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var pages:ArrayCollection;

		[Bindable]
		public var state:String;

		[Bindable]
		public var currentPage:PageVO;

		[Bindable]
		public var lastLinks:ArrayCollection;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexManager()
		{
			pages = new ArrayCollection();
		}
	}
}