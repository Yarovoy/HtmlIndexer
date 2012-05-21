package htmlIndexer.mate.commands
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	import htmlIndexer.mate.vos.LinkVO;
	import htmlIndexer.mate.vos.PageVO;

	public class IndexCommand extends IndexManagerCommand
	{

		public static const WHOLE_LINK_PATTERN:RegExp = /<a\s[^>]*href\s*=\s*"([^"]*)"[^>]*>(.*?)<\/a>/g;

		public static const TIMEOUT_DELAY:int = 30000;

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var urlLoader:URLLoader;

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var url:String;
		private var timer:Timer;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function IndexCommand()
		{
		}

		// ----------------------------------------------------------------------
		// Private methods
		// ----------------------------------------------------------------------

		private static function parseLinks(pageContent:String):Array
		{
			const result:Array = [];

			var aTag:Array = WHOLE_LINK_PATTERN.exec(pageContent);
			while (aTag)
			{
				result.push(
						new LinkVO(aTag[1], aTag[2])
				);

				aTag = WHOLE_LINK_PATTERN.exec(pageContent);
			}

			return result;
		}

		private function addLoaderListeners(dispatcher:EventDispatcher):void
		{
			dispatcher.addEventListener(Event.OPEN, urlLoader_openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			dispatcher.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorHandler);
		}

		private function removeLoaderListeners(dispatcher:EventDispatcher):void
		{
			dispatcher.removeEventListener(Event.OPEN, urlLoader_openHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			dispatcher.removeEventListener(Event.COMPLETE, urlLoader_completeHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorHandler);
		}

		private function loadPage():void
		{
			urlLoader = new URLLoader();
			addLoaderListeners(urlLoader);
			urlLoader.load(new URLRequest(url));

			timer = new Timer(TIMEOUT_DELAY, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_timerCompleteHandler);
			timer.start();
		}

		private function releaseLoaderAndTimer():void
		{
			removeLoaderListeners(urlLoader);
			urlLoader = null;

			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_timerCompleteHandler);
			timer.stop();
			timer = null;
		}

		private function stopPageLoading():void
		{
			try
			{
				urlLoader.close();
			}
			catch (error:Error)
			{
				trace(error.message);
			}

			releaseLoaderAndTimer();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event):void
		{
			super.execute(event);

			loadPage();
		}

		// ----------------------------------------------------------------------
		// Event handlers
		// ----------------------------------------------------------------------

		private function urlLoader_openHandler(event:Event):void
		{
		}

		private function urlLoader_httpStatusHandler(event:HTTPStatusEvent):void
		{
		}

		private function urlLoader_progressHandler(event:ProgressEvent):void
		{
		}

		private function urlLoader_completeHandler(event:Event):void
		{
			if (urlLoader.data && urlLoader.data.toString().length)
			{
				const links:Array = parseLinks(
						urlLoader.data.toString()
				);
				const page:PageVO = new PageVO(
						url,
						links
				);

				indexManager.currentPage = page;
			}

			releaseLoaderAndTimer();
		}

		private function urlLoader_securityErrorHandler(event:SecurityErrorEvent):void
		{
			releaseLoaderAndTimer();
		}

		private function urlLoader_ioErrorHandler(event:IOErrorEvent):void
		{
			releaseLoaderAndTimer();
		}

		private function timer_timerCompleteHandler(event:TimerEvent):void
		{
			stopPageLoading();
		}
	}
}