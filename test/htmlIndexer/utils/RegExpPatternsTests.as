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
			const regExp:RegExp = new RegExp(RegExpPatterns.URL_WITH_PROTOCOL, 'i');

			assertFalse(regExp.test('ya.ru'));
			assertFalse(regExp.test('ya.ru/'));
			assertFalse(regExp.test('ya.ru/index.html'));
			assertFalse(regExp.test('ya.ru/index.html?param1=value1&param2=value2'));

			assertFalse(regExp.test('localhost'));
			assertTrue(regExp.test('http://localhost'));
			assertTrue(regExp.test('http://localhost/'));
			assertTrue(regExp.test('http://localhost/index.html?param1=value1&param2=value2'));
			assertTrue(regExp.test('https://localhost'));
			assertTrue(regExp.test('https://localhost/'));
			assertTrue(regExp.test('https://localhost/index.html?param1=value1&param2=value2'));

			assertTrue(regExp.test('http://ya.ru'));
			assertTrue(regExp.test('http://ya.ru/'));
			assertTrue(regExp.test('http://ya.ru/index.html'));
			assertTrue(regExp.test('http://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(regExp.test('http://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			assertTrue(regExp.test('HTTP://YA.RU'));

			assertTrue(regExp.test('https://ya.ru'));
			assertTrue(regExp.test('https://ya.ru/'));
			assertTrue(regExp.test('https://ya.ru/index.html?param1=value1&param2=value2'));
			assertTrue(regExp.test('https://ya.ru/yandsearch?text=%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0+%D0%B2+%D0%BC%D0%BE%D1%81%D0%BA%D0%B2%D0%B5&lr=54'));

			const result:Array = regExp.exec('<a href="http://www.artlebedev.ru" onclick="c(this,17,1084)">Студия Артемия&nbsp;Лебедева</a>');
			assertEquals(result.index, 9);
			assertEquals(result[0], 'http://www.artlebedev.ru"');
			assertEquals(result[1], 'http://');
			assertEquals(result[3], 'www.artlebedev.ru"');
		}

		[Test]
		public function testHtmlLinkPattern():void
		{
			const regExp:RegExp = new RegExp(RegExpPatterns.HTML_LINK, 'i');

			assertTrue(regExp.test('<a id="sethome"href="http://help.yandex.ru/start/" onmousedown="c(this,17,1755);">Сделать стартовой</a>'));
			assertTrue(regExp.test('<a href="http://mail.yandex.ru"onclick="c(this,17,1080)">Войти&nbsp;в&nbsp;почту</a>'));
			assertTrue(regExp.test('<a href="http://www.yandex.ru" onclick="c(this,17,1081)"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAAAsCAMAAACkN=="alt="Яндекс" width="100" border="0" height="44"></a>'));
			assertTrue(regExp.test('<span>© 1997—2012</span> «<a href="http://www.yandex.ru" onclick="c(this,17,1083)">Яндекс</a>»'));
			assertTrue(regExp.test('<a href="http://www.artlebedev.ru" onclick="c(this,17,1084)">Студия Артемия&nbsp;Лебедева</a>'));

			const result:Array = regExp.exec('<span>© 1997—2012</span> «<a href="http://www.yandex.ru" onclick="c(this,17,1083)">Яндекс</a>»');
			assertEquals(result.index, 26);
			assertEquals(result[0], '<a href="http://www.yandex.ru" onclick="c(this,17,1083)">Яндекс</a>');
			assertEquals(result[1], 'http://www.yandex.ru');
			assertEquals(result[2], 'Яндекс');

		}
	}
}