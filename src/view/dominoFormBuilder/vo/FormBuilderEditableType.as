package view.dominoFormBuilder.vo
{
	import org.apache.flex.collections.ArrayList;

	[Bindable] public class FormBuilderEditableType
	{
		public static const EDITABLE:String = "Editable";
		public static const COMPUTED:String = "Computed";
		public static const COMPUTE_ON_COMPOSE:String = "Compute on compose";
		public static const COMPUTE_FOR_DISPLAY:String = "Compute for display";
		
		private static var _editableTypes:ArrayList;
		public static function get editableTypes():ArrayList
		{
			if (!_editableTypes)
			{
				_editableTypes = new ArrayList([
					EDITABLE, COMPUTED, COMPUTE_ON_COMPOSE,
					COMPUTE_FOR_DISPLAY
				]);
			}
			
			return _editableTypes;
		}
	}
}