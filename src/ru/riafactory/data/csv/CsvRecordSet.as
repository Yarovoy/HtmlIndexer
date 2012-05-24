package ru.riafactory.data.csv
{

	public class CsvRecordSet
	{

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var records:Array;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function CsvRecordSet(records:Array)
		{
			this.records = records ? records : [];
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		public function toString():String
		{
			var result:String = '';

			for each(var entry:* in records)
			{

			}

			return result;
		}
	}
}