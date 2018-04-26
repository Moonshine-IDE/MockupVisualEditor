package view.models
{
	import view.interfaces.ISurfaceComponent;

	public class PropertyChangeReferenceVO
	{
		public var fieldName:String;
		public var fieldValue:*;
		public var fieldClass:ISurfaceComponent;
		
		public function PropertyChangeReferenceVO(fieldName:String, fieldValue:*, fieldClass:ISurfaceComponent)
		{
			this.fieldName = fieldName;
			this.fieldValue = fieldValue;
			this.fieldClass = fieldClass;
		}
	}
}