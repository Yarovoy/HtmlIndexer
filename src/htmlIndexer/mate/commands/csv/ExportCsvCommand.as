package htmlIndexer.mate.commands.csv
{

	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import htmlIndexer.mate.business.HtmlIndexerModel;
	import htmlIndexer.mate.commands.db.DbCommand;
	import htmlIndexer.mate.vos.LinkVO;
	import htmlIndexer.states.HtmlIndexerState;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	import ru.riafactory.data.csv.CSV;

	public class ExportCsvCommand extends DbCommand
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const DEFAULT_FILE_NAME:String = 'links.csv';

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var file:File;

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var htmlIndexerModel:HtmlIndexerModel;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function ExportCsvCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event = null):void
		{
			super.execute(event);

			htmlIndexerModel.currentState = HtmlIndexerState.EXPORTING;

			file = File.documentsDirectory.resolvePath(DEFAULT_FILE_NAME);
			file.addEventListener(Event.SELECT, file_selectHandler);
			file.addEventListener(Event.CANCEL, file_cancelHandler);
			file.browseForSave('Save File');
		}

		// ----------------------------------------------------------------------
		// Event handlers
		// ----------------------------------------------------------------------

		private function file_selectHandler(event:Event):void
		{
			const csv:CSV = new CSV();
			csv.header = ['URL', 'Text', 'From Page'];

			var linkVO:LinkVO;
			const links:ArrayCollection = dbManager.findAll(LinkVO);
			const cursor:IViewCursor = links.createCursor();
			while (!cursor.afterLast)
			{
				linkVO = cursor.current as LinkVO;
				csv.addRecordSet([linkVO.url, linkVO.text, linkVO.page.url]);

				cursor.moveNext();
			}

			const fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(csv.toCSVString());
			fileStream.close();

			htmlIndexerModel.currentState = HtmlIndexerState.BASE;
		}

		private function file_cancelHandler(event:Event):void
		{
			htmlIndexerModel.currentState = HtmlIndexerState.BASE;
		}
	}
}