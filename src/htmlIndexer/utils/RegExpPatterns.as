package htmlIndexer.utils
{

	public class RegExpPatterns
	{
		public static const URL_WITH_PROTOCOL:String = '(https?://)(\\w+:{0,1}\\w*@)?(\\S+)(:[0-9]+)?(/|/([\\w#!:.?+=&%@!\\-/]))?';
		public static const HTML_LINK:String = '<a\\s[^>]*href\\s*=\\s*"([^"]*)"[^>]*>(.*?)</a>';
	}
}