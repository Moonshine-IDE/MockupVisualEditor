package view.models
{
	import view.interfaces.ISurfaceComponent;

	public class PropertyChangeReferenceVO
	{
		public var fieldName:String;
		public var fieldLastValue:*;
		public var fieldNewValue:*;
		public var fieldClass:ISurfaceComponent;
		
		public function PropertyChangeReferenceVO(fieldName:String, fieldLastValue:*, fieldNewValue:*, fieldClass:ISurfaceComponent)
		{
			this.fieldName = fieldName;
			this.fieldLastValue = fieldLastValue;
			this.fieldNewValue = fieldNewValue;
			this.fieldClass = fieldClass;
		}
		
		public function reverse():void
		{
			fieldClass["isUpdating"] = true;
			if (fieldLastValue is Array)
			{
				for each (var i:Object in fieldLastValue)
				{
					fieldClass["restorePropertyOnChangeReference"](i.field, i.value);
				}
			}
			else if (fieldName)
				fieldClass["restorePropertyOnChangeReference"](fieldName, fieldLastValue);
			
			fieldClass["callLater"](function():void
			{
				fieldClass["isUpdating"] = false;
			});
		}
		
		public function restore():void
		{
			fieldClass["isUpdating"] = true;
			if (fieldNewValue is Array)
			{
				for each (var i:Object in fieldNewValue)
				{
					fieldClass["restorePropertyOnChangeReference"](i.field, i.value);
				}
			}
			else if (fieldName)
				fieldClass["restorePropertyOnChangeReference"](fieldName, fieldNewValue);
			
			fieldClass["callLater"](function():void
			{
				fieldClass["isUpdating"] = false;
			});
		}
	}
}