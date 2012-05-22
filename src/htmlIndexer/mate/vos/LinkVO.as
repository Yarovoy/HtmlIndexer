package htmlIndexer.mate.vos
{

	import flash.events.EventDispatcher;

	[Bindable]
	[Table(name='links')]
	public class LinkVO extends EventDispatcher
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		[Id]
		public var id:int;

		[ManyToOne]
		public var page:PageVO;

		public var url:String;

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