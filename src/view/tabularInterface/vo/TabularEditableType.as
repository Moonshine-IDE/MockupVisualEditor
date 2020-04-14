package view.tabularInterface.vo
{
	import org.apache.flex.collections.ArrayList;

	[Bindable] public class TabularEditableType
	{
		public static const EDITABLE:String = "Editable";
		public static const COMPUTED:String = "Computed";
		public static const COMPUTE_ON_COMPOSE:String = "Compute on compose";
		public static const COMPUTE_FOR_DISPLAY:String = "Compute for display";
		
		private static var _EDITABLE_TYPES:ArrayList;
		public static function get EDITABLE_TYPES():ArrayList
		{
			if (!_EDITABLE_TYPES)
			{
				_EDITABLE_TYPES = new ArrayList([
					EDITABLE, COMPUTED, COMPUTE_ON_COMPOSE,
					COMPUTE_FOR_DISPLAY
				]);
			}
			
			return _EDITABLE_TYPES;
		}
	}
}