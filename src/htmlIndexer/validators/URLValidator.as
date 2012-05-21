package htmlIndexer.validators
{

	import htmlIndexer.utils.RegExpPatterns;

	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class URLValidator extends Validator
	{

		// ----------------------------------------------------------------------
		// Constants
		// ----------------------------------------------------------------------

		private static const DEFAULT_INVALID_URL_ERROR:String = "This is an invalid URL.";

		// ----------------------------------------------------------------------
		// Private props
		// ----------------------------------------------------------------------

		private var _invalidUrlError:String = DEFAULT_INVALID_URL_ERROR;

		// ----------------------------------------------------------------------
		// Getters and setters
		// ----------------------------------------------------------------------

		[Inspectable(category="Errors", defaultValue="null")]

		/**
		 *  Error message when a string is not a valid url.
		 *  @default "This is an invalid url."
		 */
		public function get invalidUrlError():String
		{
			return _invalidUrlError;
		}

		public function set invalidUrlError(value:String):void
		{
			_invalidUrlError = value;
		}

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function URLValidator()
		{
		}

		// ----------------------------------------------------------------------
		// Protected methods
		// ----------------------------------------------------------------------

		override protected function doValidation(value:Object):Array
		{
			const results:Array = super.doValidation(value);
			if (!isUrl(value.toString()))
			{
				results.push(new ValidationResult(true, property, "invalidUrl", _invalidUrlError));
			}

			return results;
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		public static function isUrl(s:String):Boolean
		{
			const regExp:RegExp = new RegExp(RegExpPatterns.URL_WITH_PROTOCOL);
			return regExp.test(s);
		}
	}
}