package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	import mx.collections.ArrayCollection;

	public class PageVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Bindable]
		public var url:String;

		[Bindable]
		public var links:ArrayCollection;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function PageVO(url:String = null, links:Array = null)
		{
			this.url = url;
			this.links = links ? new ArrayCollection(links) : new ArrayCollection();
		}
	}
}