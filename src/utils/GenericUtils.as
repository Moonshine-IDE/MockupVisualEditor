package utils
{
	import flash.display.InteractiveObject;
	
	import spark.components.List;
	import spark.core.NavigationUnit;
	
	public class GenericUtils
	{
		public static function getWidth(value:InteractiveObject):String
		{
			if (value.hasOwnProperty("percentWidth") && !isNaN(value["percentWidth"])) return value["percentWidth"]+"%";
			return value.width.toString();
		}
		
		public static function listScrollToBottom(list:List):void
		{
			var delta:Number = 0;
			var count:int = 0;
			while (count++ < 10)
			{
				list.validateNow();
				delta = list.layout.getVerticalScrollPositionDelta(NavigationUnit.END);
				list.layout.verticalScrollPosition += delta;
				
				if (delta == 0) break;
			}
		}
	}
}