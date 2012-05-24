package ru.riafactory.data.csv
{

	import ru.riafactory.core.riafactory_internal;

	/**
	 * Class for exporting (and importing in future) data to the comma separated values format CSV.
	 * See http://tools.ietf.org/html/rfc4180 for more information about that format.
	 */
	public class CSV
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const ENCLOSURE_CHECKER:RegExp = /[",]|(?:\r\n)/g;
		private static const DELIMITER:String = ",";
		private static const BREAK:String = '\r\n';

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var header:Array;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function CSV()
		{
		}

		// ----------------------------------------------------------------------
		// Internal methods
		// ----------------------------------------------------------------------

		riafactory_internal static function escapeRecordString(recordStr:String):String
		{
			if (recordStr == null)
			{
				return null;
			}

			ENCLOSURE_CHECKER.lastIndex = 0;

			var escapedStr:String = recordStr.replace(/"/g, '""');

			var encloseByQuotes:Boolean = ENCLOSURE_CHECKER.test(escapedStr);

			// Enclose by double quotes if need.
			if (encloseByQuotes)
			{
				escapedStr = '"' + escapedStr + '"';
			}

			return escapedStr;
		}

		riafactory_internal static function recordString(record:*):String
		{
			if (!record)
			{
				return '';
			}

			var recordStr:String;
			if (record is Date)
			{
				recordStr = (record as Date).toUTCString();
			}
			else
			{
				recordStr = record.toString();
			}

			return recordStr;
		}

		riafactory_internal function get headerLine():String
		{
			if (!header)
			{
				return null;
			}

			return header.join(DELIMITER);
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		public function addRecordSet(recordSet:Array):void
		{
		}

		public function toCSVString():String
		{
			return null;
		}
	}
}