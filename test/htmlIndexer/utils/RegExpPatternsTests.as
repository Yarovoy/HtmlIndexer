package htmlIndexer.utils
{

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class RegExpPatternsTests
	{
		[Test]
		public function testUrlPattern():void
		{
			assertFalse(RegExpPatterns.URL_WITH_PROTOCOL.test('ya.ru'));
			assertFalse(RegExpPatterns.URL_WITH_PROTOCOL.test('ya.ru/'));
			assertFalse(RegExpPatterns.URL_WITH_PROTOCOL.test('ya.ru/index.html'));
			assertFalse(RegExpPatterns.URL_WITH_PROTOCOL.test('ya.ru/index.html?param1=value1&param2=value2'));

			assertFalse(RegExpPatterns.URL_WITH_PROTOCOL.test('localhost'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://localhost'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://localhost/'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://localhost/index.html?param1=value1&param2=value2'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://localhost'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://localhost/'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://localhost/index.html?param1=value1&param2=value2'));

			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://ya.ru'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://ya.ru/'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://ya.ru/index.html'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('http://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://ya.ru'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://ya.ru/'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(RegExpPatterns.URL_WITH_PROTOCOL.test('https://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			const result:Array = RegExpPatterns.URL_WITH_PROTOCOL.exec('<a href="http://www.artlebedev.ru" onclick="c(this,17,1084)">Студия Артемия&nbsp;Лебедева</a>');
			assertEquals(result.index, 9);
			assertEquals(result[0], 'http://www.artlebedev.ru"');
			assertEquals(result[1], 'http://');
			assertEquals(result[3], 'www.artlebedev.ru"');
		}
	}
}