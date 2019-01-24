package view.primeFaces.supportClasses
{
    import spark.components.NavigatorContent;
    import interfaces.IComponent;

	public class NavigatorContent extends spark.components.NavigatorContent implements IComponent
	{
		public static const ELEMENT_NAME:String = "NavigatorContent";
		
		public function NavigatorContent()
		{
			super();
		}
		
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			
		}

		public function toCode():XML
		{
			return null;
		}
	}
}