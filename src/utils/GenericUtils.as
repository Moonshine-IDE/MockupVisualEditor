package utils
{
	import flash.display.InteractiveObject;
	
	import mx.core.IVisualElementContainer;
	
	import data.OrganizerItem;
	
	import view.EditingSurface;
	import view.interfaces.IHistorySurfaceComponent;
	import view.interfaces.IPrimeFacesSurfaceComponent;
	import view.interfaces.ISurfaceComponent;
	import view.suportClasses.PropertyChangeReference;
	
	public class GenericUtils
	{
		public static function getWidth(value:InteractiveObject):String
		{
			if (value.hasOwnProperty("percentWidth") && !isNaN(value["percentWidth"])) return value["percentWidth"]+"%";
			return value.width.toString();
		}
		
		public static function applyPercentageWidthHeight(selectedItem:ISurfaceComponent, width:String, height:String, isWidth:Boolean):void
		{
			var pattern:RegExp = new RegExp(/(%)/g);
			var newValue:String = isWidth ? width.replace(pattern, "") : height.replace(pattern, "");
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (historyComponent) historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
			
			if (isWidth)
			{
				if (historyComponent)
				{
					historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
					historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"width", value:NaN}, {field:"percentWidth", value:Number(newValue)}];
				}
				
				selectedItem.percentWidth = Number(newValue);
				selectedItem.width = Number.NaN;
			}
			else
			{
				if (historyComponent)	
				{
					historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
					historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"height", value:NaN}, {field:"percentHeight", value:Number(newValue)}];
				}
				
				selectedItem.percentHeight = Number(newValue);
				selectedItem.height = Number.NaN;
			}
		}
		
		public static function applyMinAndMaxWidth(selectedItem:ISurfaceComponent, newWidth:Number):String
		{
			var minWidth:Number = selectedItem.minWidth;
			var maxWidth:Number = selectedItem.maxWidth;
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (newWidth < minWidth)
			{
				newWidth = minWidth;
			}
			else if (newWidth > maxWidth)
			{
				newWidth = maxWidth;
			}
			
			if (historyComponent)	
			{
				historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
				historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
				historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"width", value:newWidth}, {field:"percentWidth", value:NaN}];
			}
			
			selectedItem.percentWidth = Number.NaN;
			selectedItem.width = newWidth;
			//the text might not have updated if the width property is the same
			//but the old text value is different
			return selectedItem.width.toString();
		}
		
		public static function applyMinAndMaxHeight(selectedItem:ISurfaceComponent, newHeight:Number):String
		{
			var minHeight:Number = selectedItem.minHeight;
			var maxHeight:Number = selectedItem.maxHeight;
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (newHeight < minHeight)
			{
				newHeight = minHeight;
			}
			else if (newHeight > maxHeight)
			{
				newHeight = maxHeight;
			}
			
			if (historyComponent)	
			{
				historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
				historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
				historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"height", value:newHeight}, {field:"percentHeight", value:NaN}];
			}
			
			selectedItem.percentHeight = Number.NaN;
			selectedItem.height = newHeight;
			//the text might not have updated if the height property is the same
			//but the old text value is different
			return selectedItem.height.toString();
		}
		
		public static function getComponentsChildren(surface:EditingSurface):Array
		{
			var element:IPrimeFacesSurfaceComponent = surface.getElementAt(0) as IPrimeFacesSurfaceComponent;
			var componentsArray:Array = [];				
			var container:IVisualElementContainer = surface;
			var organizerItem:OrganizerItem;
			var elementCount:int = 0;
			
			if (element is IPrimeFacesSurfaceComponent) container = element as IVisualElementContainer;
			if (!container)
			{
				elementCount = surface.numElements;
				container = surface;
			}
			else
			{
				elementCount = container.numElements;
			}
			
			for (var i:int = 0; i < elementCount; i++)
			{
				element = container.getElementAt(i) as IPrimeFacesSurfaceComponent;
				
				if (element === null)
				{
					continue;
				}
				
				organizerItem = element.getComponentsChildren();
				if (organizerItem) componentsArray.push(organizerItem);
			}
			
			return componentsArray;
		}
	}
}