package ru.riafactory.data.csv
{

	import ru.riafactory.core.riafactory_internal;

	use namespace riafactory_internal;

	/**
	 * Class for exporting (and importing in future) data to the comma separated values format CSV.
	 * See http://tools.ietf.org/html/rfc4180 for more information about CSV format.
	 */
	public class CSV
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const ENCLOSURE_CHECKER:RegExp = /[",\r\n]/g;
		private static const DELIMITER:String = ",";
		private static const BREAK:String = '\r\n';

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var recordSets:Array = [];

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var header:Array;

		// ----------------------------------------------------------------------
		// Getters and setters
		// ----------------------------------------------------------------------

		public function get length():Number
		{
			return recordSets.length;
		}

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function CSV()
		{
		}

		// ----------------------------------------------------------------------
		// Internal methods
		// ----------------------------------------------------------------------

		riafactory_internal static function escapeRecordString(str:String):String
		{
			if (str == null)
			{
				return null;
			}

			// Enclose by double quotes if need.
			ENCLOSURE_CHECKER.lastIndex = 0;
			if (ENCLOSURE_CHECKER.test(str))
			{
				str = str.replace(/"/g, '""');

				return '"' + str + '"';
			}

			return str;
		}

		riafactory_internal static function recordToString(record:*):String
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

			return escapeRecordString(recordStr);
		}

		riafactory_internal static function joinRecordSet(recordSet:Array):String
		{
			if (!recordSet)
			{
				return null;
			}

			const escapedSet:Array = [];

			for each(var record:* in recordSet)
			{
				escapedSet.push(
						recordToString(record)
				);
			}

			return escapedSet.join(DELIMITER);
		}

		riafactory_internal function get headerLine():String
		{
			if (!header)
			{
				return null;
			}

			return joinRecordSet(header);
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		public function getRecordSetAt(index:int):Array
		{
			return recordSets[index];
		}

		public function setRecordSetAt(recordSet:Array, index:int):void
		{
			if (index < 0 || index >= length)
			{
				throw new RangeError('Index is out of bounds: ' + index + '.');
			}

			recordSets[index] = recordSet;
		}

		public function addRecordSet(recordSet:Array):void
		{
			recordSets.push(recordSet);
		}

		public function addRecordSetAt(recordSet:Array, index:int):void
		{
			if (index < 0 || index > length)
			{
				throw new RangeError('Index is out of bounds: ' + index + '.');
			}

			recordSets.splice(index, 0, recordSet);
		}

		public function removeRecordSetAt(index:int):Array
		{
			if (index < 0 || index >= length)
			{
				throw new RangeError('Index is out of bounds: ' + index + '.');
			}

			return recordSets.splice(index, 1)[0];
		}

		public function removeAllRecordSets():void
		{
			recordSets = [];
		}

		public function toCSVString():String
		{
			var result:String = header ? headerLine + BREAK : '';

			const escapedRecordSet:Array = [];

			for each(var recordSet:Array in recordSets)
			{
				escapedRecordSet.push(joinRecordSet(recordSet));
			}

			return result + escapedRecordSet.join(BREAK);
		}
	}
}