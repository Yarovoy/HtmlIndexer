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
			const pattern:RegExp = new RegExp(RegExpPatterns.URL_WITH_PROTOCOL);

			assertFalse(pattern.test('ya.ru'));
			assertFalse(pattern.test('ya.ru/'));
			assertFalse(pattern.test('ya.ru/index.html'));
			assertFalse(pattern.test('ya.ru/index.html?param1=value1&param2=value2'));

			assertFalse(pattern.test('localhost'));
			assertTrue(pattern.test('http://localhost'));
			assertTrue(pattern.test('http://localhost/'));
			assertTrue(pattern.test('http://localhost/index.html?param1=value1&param2=value2'));
			assertTrue(pattern.test('https://localhost'));
			assertTrue(pattern.test('https://localhost/'));
			assertTrue(pattern.test('https://localhost/index.html?param1=value1&param2=value2'));

			assertTrue(pattern.test('http://ya.ru'));
			assertTrue(pattern.test('http://ya.ru/'));
			assertTrue(pattern.test('http://ya.ru/index.html'));
			assertTrue(pattern.test('http://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(pattern.test('http://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			assertTrue(pattern.test('https://ya.ru'));
			assertTrue(pattern.test('https://ya.ru/'));
			assertTrue(pattern.test('https://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(pattern.test('https://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			const result:Array = pattern.exec('<a href="http://www.artlebedev.ru" onclick="c(this,17,1084)">Студия Артемия&nbsp;Лебедева</a>');
			assertEquals(result.index, 9);
			assertEquals(result[0], 'http://www.artlebedev.ru"');
			assertEquals(result[1], 'http://');
			assertEquals(result[3], 'www.artlebedev.ru"');
		}

		[Test]
		public function testHtmlLinkPattern():void
		{
//			assertTrue(RegExpPatterns.HTML_LINK.test('<a href="http://www.yandex.ru" onclick="c(this,17,1083)">Яндекс</a>'));
//			assertTrue(RegExpPatterns.HTML_LINK.test('<a href="http://www.artlebedev.ru" onclick="c(this,17,1084)">Студия Артемия&nbsp;Лебедева</a>'));
//			assertTrue(RegExpPatterns.HTML_LINK.test('<a href="http://mail.yandex.ru"onclick="c(this,17,1080)">Войти&nbsp;в&nbsp;почту</a>'));
//			assertTrue(RegExpPatterns.HTML_LINK.test('<a id="sethome"href="http://help.yandex.ru/start/" onmousedown="c(this,17,1755);">Сделать стартовой</a>'));
		}
	}
}