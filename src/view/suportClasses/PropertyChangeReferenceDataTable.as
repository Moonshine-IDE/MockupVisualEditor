package view.suportClasses
{
	import view.interfaces.IHistorySurfaceComponent;
	import view.primeFaces.surfaceComponents.components.DataTable;

	public class PropertyChangeReferenceDataTable extends PropertyChangeReference
	{
		public function PropertyChangeReferenceDataTable(fieldClass:IHistorySurfaceComponent, fieldName:String=null, fieldLastValue:*=null, fieldNewValue:*=null)
		{
			super(fieldClass, fieldName, fieldLastValue, fieldNewValue);
		}
		
		override protected function changeItem(value:*):void
		{
			if (!fieldName && (value is Array))
			{
				for each (var i:Object in value)
				{
					DataTable(fieldClass).restorePropertyOnChangeReference(i.field, i.value);
				}
			}
			else if (fieldName)
			{
				// assigning single field change
				DataTable(fieldClass).restorePropertyOnChangeReference(fieldName, value);
			}
		}
	}
}