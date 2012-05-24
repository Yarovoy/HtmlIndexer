package htmlIndexer.mate.commands
{

	import com.shortybmc.data.parser.CSV;

	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import htmlIndexer.mate.commands.db.DbCommand;
	import htmlIndexer.mate.vos.LinkVO;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	public class ExportCsvCommand extends DbCommand
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const DEFAULT_FILE_NAME:String = 'links.csv';

		private static const DELIMITER:String = ",";

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var file:File;

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

			file = File.documentsDirectory.resolvePath(DEFAULT_FILE_NAME);
			file.addEventListener(Event.SELECT, file_selectHandler);
			file.browseForSave('Save File');
		}

		// ----------------------------------------------------------------------
		// Event handlers
		// ----------------------------------------------------------------------

		private function file_selectHandler(event:Event):void
		{
			const csv:CSV = new CSV();
			csv.embededHeader = false;
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

			csv.encode();

			const fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(csv.data);
			fileStream.close();
		}
	}
}