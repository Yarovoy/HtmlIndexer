package htmlIndexer.mate.commands
{

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class IndexCommand extends IndexManagerCommand
	{

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var urlLoader:URLLoader;

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var url:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexCommand()
		{
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);

			urlLoader = new URLLoader(
					new URLRequest(url)
			);

			urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			urlLoader.addEventListener(Event.OPEN, urlLoader_openHandler);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_httpStatusHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorHandler);
		}

		// ----------------------------------------------------------------------
		// Event handlers
		// ----------------------------------------------------------------------

		private function urlLoader_completeHandler(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
		}

		private function urlLoader_openHandler(event:Event):void
		{
		}

		private function urlLoader_progressHandler(event:ProgressEvent):void
		{
		}

		private function urlLoader_securityErrorHandler(event:SecurityErrorEvent):void
		{
		}

		private function urlLoader_httpStatusHandler(event:HTTPStatusEvent):void
		{
		}

		private function urlLoader_ioErrorHandler(event:IOErrorEvent):void
		{
		}
	}
}