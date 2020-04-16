package view.tabularInterface.vo
{
	import org.apache.flex.collections.ArrayList;

	[Bindable] public class TabularFieldType
	{
		public static const TEXT:String = "Text";
		public static const RICH_TEXT:String = "Richtext";
		public static const NUMBER:String = "Number";
		public static const DATETIME:String = "Datetime";
		
		private static var _fieldTypes:ArrayList;
		public static function get fieldTypes():ArrayList
		{
			if (!_fieldTypes)
			{
				_fieldTypes = new ArrayList([
					TEXT, RICH_TEXT, NUMBER, DATETIME
				]);
			}
			
			return _fieldTypes;
		}
	}
}