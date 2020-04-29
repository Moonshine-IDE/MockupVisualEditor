package view.dominoFormBuilder.vo
{
	import mx.collections.ArrayList;

	[Bindable] public class FormBuilderFieldType
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