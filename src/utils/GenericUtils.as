package utils
{
	import flash.display.InteractiveObject;
	
	import view.interfaces.IHistorySurfaceComponent;
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
			var isHistoryComponent:Boolean = selectedItem is IHistorySurfaceComponent;
			
			if (isHistoryComponent)	(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference = new PropertyChangeReference(selectedItem as IHistorySurfaceComponent);
			
			if (isWidth)
			{
				if (isHistoryComponent)	
				{
					(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
					(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldNewValue = [{field:"width", value:NaN}, {field:"percentWidth", value:Number(newValue)}];
				}
				
				selectedItem.percentWidth = Number(newValue);
				selectedItem.width = Number.NaN;
			}
			else
			{
				if (isHistoryComponent)	
				{
					(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
					(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldNewValue = [{field:"height", value:NaN}, {field:"percentHeight", value:Number(newValue)}];
				}
				
				selectedItem.percentHeight = Number(newValue);
				selectedItem.height = Number.NaN;
			}
		}
		
		public static function applyMinAndMaxWidth(selectedItem:ISurfaceComponent, newWidth:Number):String
		{
			var minWidth:Number = selectedItem.minWidth;
			var maxWidth:Number = selectedItem.maxWidth;
			var isHistoryComponent:Boolean = selectedItem is IHistorySurfaceComponent;
			
			if (newWidth < minWidth)
			{
				newWidth = minWidth;
			}
			else if (newWidth > maxWidth)
			{
				newWidth = maxWidth;
			}
			
			if (isHistoryComponent)	
			{
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference = new PropertyChangeReference(selectedItem as IHistorySurfaceComponent);
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldNewValue = [{field:"width", value:newWidth}, {field:"percentWidth", value:NaN}];
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
			var isHistoryComponent:Boolean = selectedItem is IHistorySurfaceComponent;
			
			if (newHeight < minHeight)
			{
				newHeight = minHeight;
			}
			else if (newHeight > maxHeight)
			{
				newHeight = maxHeight;
			}
			
			if (isHistoryComponent)	
			{
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference = new PropertyChangeReference(selectedItem as IHistorySurfaceComponent);
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
				(selectedItem as IHistorySurfaceComponent).propertyChangeFieldReference.fieldNewValue = [{field:"height", value:newHeight}, {field:"percentHeight", value:NaN}];
			}
			
			selectedItem.percentHeight = Number.NaN;
			selectedItem.height = newHeight;
			//the text might not have updated if the height property is the same
			//but the old text value is different
			return selectedItem.height.toString();
		}
	}
}