package htmlIndexer.mate.commands.index
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

	import htmlIndexer.mate.business.HtmlIndexerModel;
	import htmlIndexer.mate.commands.*;
	import htmlIndexer.mate.commands.db.DbPageStoreCommand;
	import htmlIndexer.mate.vos.LinkVO;
	import htmlIndexer.mate.vos.PageVO;
	import htmlIndexer.regExp.RegExpPatterns;
	import htmlIndexer.states.HtmlIndexerState;

	public class PageIndexCommand extends BasicCommand
	{

		public static const TIMEOUT_DELAY:int = 30000;

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var timer:Timer;
		private var urlLoader:URLLoader;

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var htmlIndexerModel:HtmlIndexerModel;

		public var dbPageStoreCommand:DbPageStoreCommand;

		public var url:String;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function PageIndexCommand()
		{
		}

		// ----------------------------------------------------------------------
		// Private methods
		// ----------------------------------------------------------------------

		private static function parseLinks(pageContent:String):Array
		{
			const result:Array = [];
			const regExp:RegExp = new RegExp(RegExpPatterns.HTML_LINK, 'gi');

			var aTag:Array = regExp.exec(pageContent);
			while (aTag)
			{
				result.push(
						new LinkVO(aTag[1], aTag[2])
				);

				aTag = regExp.exec(pageContent);
			}

			return result;
		}

		private function parseLoadedData():void
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

				htmlIndexerModel.lastIndexedPage = page;
				htmlIndexerModel.lastIndexedLinks = page.links;

				storeToDB(page);
			}
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
			htmlIndexerModel.currentState = HtmlIndexerState.INDEXING;

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

			htmlIndexerModel.currentState = HtmlIndexerState.BASE;
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

		private function storeToDB(page:PageVO):void
		{
			dbPageStoreCommand.page = page;
			dbPageStoreCommand.execute();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event = null):void
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
			parseLoadedData();

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