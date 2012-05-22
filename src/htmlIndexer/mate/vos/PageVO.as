package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name='pages')]
	public class PageVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Id]
		public var id:int;

		[OneToMany(type='htmlIndexer.mate.vos.LinkVO', cascade='all')]
		public var links:ArrayCollection;

		public var url:String;

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