package view.suportClasses
{
	import view.VisualEditor;
	import view.interfaces.IHistorySurfaceComponent;
	import view.interfaces.IHistorySurfaceCustomHandlerComponent;

	public class PropertyChangeReferenceCustomHandlerBasic extends PropertyChangeReference
	{
		public function PropertyChangeReferenceCustomHandlerBasic(fieldClass:IHistorySurfaceComponent, fieldName:String=null, fieldLastValue:*=null, fieldNewValue:*=null)
		{
			super(fieldClass, fieldName, fieldLastValue, fieldNewValue);
		}
		
		override protected function changeItem(value:*, editor:VisualEditor):void
		{
			if (!fieldName && (value is Array))
			{
				for each (var i:Object in value)
				{
					IHistorySurfaceCustomHandlerComponent(fieldClass).restorePropertyOnChangeReference(i.field, i.value);
				}
			}
			else if (fieldName)
			{
				// assigning single field change
				IHistorySurfaceCustomHandlerComponent(fieldClass).restorePropertyOnChangeReference(fieldName, value);
			}
			
			editor.componentsOrganizer.updateItemWithPropertyChanges(this, true);
		}
	}
}