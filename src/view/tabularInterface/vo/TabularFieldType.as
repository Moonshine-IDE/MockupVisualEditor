package view.tabularInterface.vo
{
	import org.apache.flex.collections.ArrayList;

	[Bindable] public class TabularFieldType
	{
		public static const TEXT:String = "Text";
		public static const RICH_TEXT:String = "Richtext";
		public static const NUMBER:String = "Number";
		public static const DATETIME:String = "Datetime";
		
		private static var _FIELD_TYPES:ArrayList;
		public static function get FIELD_TYPES():ArrayList
		{
			if (!_FIELD_TYPES)
			{
				_FIELD_TYPES = new ArrayList([
					TEXT, RICH_TEXT, NUMBER, DATETIME
				]);
			}
			
			return _FIELD_TYPES;
		}
	}
}