package view.dominoFormBuilder.vo
{
	import mx.collections.ArrayList;

	[Bindable] public class FormBuilderSortingType
	{
		private static var _sortTypes:ArrayList;
		public static function get sortTypes():ArrayList
		{
			if (!_sortTypes)
			{
				_sortTypes = new ArrayList([
					new SortTypeVO("No sorting", "none"),
					new SortTypeVO("Ascending", "ascending"),
					new SortTypeVO("Descending", "descending"),
					new SortTypeVO("Categorized (Ascending)", "ascending", true),
					new SortTypeVO("Categorized (Descending)", "descending", true)
				]);
			}
			
			return _sortTypes;
		}
	}
}

class SortTypeVO
{
	public var label:String;
	public var value:String;
	public var isCategorized:Boolean;
	
	public function SortTypeVO(label:String=null, value:String=null, categorized:Boolean=false)
	{
		this.label = label;
		this.value = value;
		this.isCategorized = categorized;
	}
}