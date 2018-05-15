package view.suportClasses
{
	import spark.components.ButtonBarButton;
	import spark.components.NavigatorContent;
	
	import view.interfaces.IHistorySurfaceComponent;
	import view.primeFaces.surfaceComponents.components.TabView;

	public class PropertyChangeReferenceTabView extends PropertyChangeReference
	{
		public function PropertyChangeReferenceTabView(fieldClass:IHistorySurfaceComponent, fieldName:String=null, fieldLastValue:*=null, fieldNewValue:*=null)
		{
			super(fieldClass, fieldName, fieldLastValue, fieldNewValue);
		}
		
		override protected function changeItem(value:*, eventType:String):void
		{
			var i:Object;
			if (fieldName && (value is Array))
			{
				if (fieldName == "label")
				{
					var selectedTab:NavigatorContent;
					var item:ButtonBarButton;
					for each (i in value)
					{
						selectedTab = TabView(this.fieldClass).getItemAt(i.field) as NavigatorContent;
						item = TabView(this.fieldClass).tabBar.dataGroup.getElementAt(i.field) as ButtonBarButton;
						selectedTab.label = i.value;
						item.label = i.value;
					}
				}
			}
			else if (!fieldName && (value is Array))
			{
				for each (i in value)
				{
					fieldClass.restorePropertyOnChangeReference(i.field, i.value, eventType);
				}
			}
			else if (fieldName)
			{
				// assigning single field change
				fieldClass.restorePropertyOnChangeReference(fieldName, value, eventType);
			}
		}
	}
}