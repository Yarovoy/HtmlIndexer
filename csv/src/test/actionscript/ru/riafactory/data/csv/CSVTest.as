package ru.riafactory.data.csv
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;

	import ru.riafactory.core.riafactory_internal;

	use namespace riafactory_internal;

	public class CSVTest
	{

		// CHECKS:
		// Number of records.
		// 1. Within the header and each record, there may be one or more fields, separated by commas. [-]
		// 2. Each line should contain the same number of fields throughout the file. [-]
		// Syntax.
		// 3. Spaces are considered part of a field and should not be ignored. [+]
		// 4. The last field in the record must not be followed by a comma. [+]
		// 5. Fields containing line breaks (CRLF), double quotes, and commas should be enclosed in double-quotes. [+]

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var csv:CSV;

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
			csv = new CSV();
		}

		[After]
		public function tearDown():void
		{
			csv = null;
		}

		// ----------------------------------------------------------------------
		// Test methods
		// ----------------------------------------------------------------------

		[Test]
		public function testEscapeRecordString():void
		{
			assertNull(CSV.escapeRecordString(null));
			assertEquals('', CSV.escapeRecordString(''));

			assertEquals('test', CSV.escapeRecordString('test'));
			assertEquals('test string', CSV.escapeRecordString('test string'));

			assertEquals(
					'"This is a line\r\n with line breaks."',
					CSV.escapeRecordString('This is a line\r\n with line breaks.')
			);
			assertEquals('"""quotes"" are beautiful"', CSV.escapeRecordString('"quotes" are beautiful'));
			assertEquals(
					'"This line contains one comma (,)."',
					CSV.escapeRecordString('This line contains one comma (,).')
			);
			assertEquals(
					'"This line contains \r\n (line break), comma and double quote ("")."',
					CSV.escapeRecordString('This line contains \r\n (line break), comma and double quote (").')
			);


			assertEquals('', CSV.escapeRecordString(''));
			assertEquals('', CSV.escapeRecordString(''));
		}

		[Test]
		public function testRecordToString():void
		{
			assertEquals('', CSV.recordToString(null));

			assertEquals('Thu Jan 1 00:00:00 1970 UTC', CSV.recordToString(new Date(0)));
		}

		[Test]
		public function testJoinRecordSet():void
		{
			assertNull(CSV.joinRecordSet(null));

			assertEquals(',,', CSV.joinRecordSet(['', '', '']));

			assertEquals('Name,Value', CSV.joinRecordSet(['Name', 'Value']));

			assertEquals(
					'Name of record,Value of record',
					CSV.joinRecordSet(['Name of record', 'Value of record'])
			);

			assertEquals(
					'"Record, with comma",Value',
					CSV.joinRecordSet(['Record, with comma', 'Value'])
			);

			assertEquals(
					'"Record with double "" quote",Value',
					CSV.joinRecordSet(['Record with double " quote', 'Value'])
			);
		}

		[Test]
		public function getHeaderLine():void
		{
			csv.header = ['', '', ''];
			assertEquals(',,', csv.headerLine);

			csv.header = ['Name', 'Value', 'Date'];
			assertEquals('Name,Value,Date', csv.headerLine);

			csv.header = ['Link', 'Text', 'Page "URL"'];
			assertEquals('Link,Text,"Page ""URL"""', csv.headerLine);
		}

		[Test]
		public function testGetRecordSetAt():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);
			csv.addRecordSet(['Name 2', 'Value 2']);

			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 2', csv.getRecordSetAt(1)[1]);
		}

		[Test]
		public function testSetRecordSetAt():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);

			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);

			csv.setRecordSetAt(['Name 2', 'Value 2'], 0);

			assertEquals('Name 2', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 2', csv.getRecordSetAt(0)[1]);
		}

		[Test(expects="RangeError")]
		public function testSetRecordSetAtError():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);

			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 1', csv.getRecordSetAt(0)[1]);

			csv.setRecordSetAt(['Name 2', 'Value 2'], 1);
		}

		[Test]
		public function testAddRecordSet():void
		{
			assertEquals(0, csv.length);

			csv.addRecordSet(['Name', 'Value']);

			assertEquals(1, csv.length);
		}

		[Test]
		public function testAddRecordSetAt():void
		{
			csv.addRecordSetAt(['Name 1', 'Value 1'], 0);

			assertEquals(1, csv.length);
			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);

			csv.addRecordSetAt(['Name 2', 'Value 2'], 0);

			assertEquals(2, csv.length);
			assertEquals('Name 2', csv.getRecordSetAt(0)[0]);
		}

		[Test(expects="RangeError")]
		public function testAddRecordSetAtError():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);

			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 1', csv.getRecordSetAt(0)[1]);

			csv.addRecordSetAt(['Name 2', 'Value 2'], 2);
		}

		[Test]
		public function testRemoveRecordSetAt():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);
			csv.addRecordSet(['Name 2', 'Value 2']);

			assertEquals(2, csv.length);
			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 1', csv.getRecordSetAt(0)[1]);

			csv.removeRecordSetAt(0);

			assertEquals(1, csv.length);
			assertEquals('Name 2', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 2', csv.getRecordSetAt(0)[1]);
		}

		[Test(expects="RangeError")]
		public function testRemoveRecordSetAtError():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);

			assertEquals('Name 1', csv.getRecordSetAt(0)[0]);
			assertEquals('Value 1', csv.getRecordSetAt(0)[1]);

			csv.removeRecordSetAt(1);
		}

		[Test]
		public function testRemoveAllRecordSets():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);
			csv.addRecordSet(['Name 2', 'Value 2']);

			assertEquals(2, csv.length);

			csv.removeAllRecordSets();

			assertEquals(0, csv.length);
		}

		[Test]
		public function testToCSVString():void
		{
			csv.addRecordSet(['Name 1', 'Value 1']);
			csv.addRecordSet(['Name 2', 'Value 2']);

			assertEquals('Name 1,Value 1\r\nName 2,Value 2', csv.toCSVString());

			csv.header = ['Title 1', 'Title 2'];

			assertEquals('Title 1,Title 2\r\nName 1,Value 1\r\nName 2,Value 2', csv.toCSVString());

			csv.header = null;
			csv.setRecordSetAt(['Name "1"', 'Value 1'], 0);
			assertEquals('"Name ""1""",Value 1\r\nName 2,Value 2', csv.toCSVString());
		}
	}
}
