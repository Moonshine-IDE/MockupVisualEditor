package view.primeFaces.supportClasses
{
	import interfaces.ILookup;

	import spark.components.NavigatorContent;
    import interfaces.IComponent;

	public class NavigatorContent extends spark.components.NavigatorContent implements IComponent
	{
		public static const ELEMENT_NAME:String = "NavigatorContent";
		
		public function NavigatorContent()
		{
			super();
		}
		
		public function fromXML(xml:XML, childFromXMLCallback:Function, lookup:ILookup = null):void
		{
			
		}

		public function toCode():XML
		{
			return null;
		}
		public function toRoyaleConvertCode():XML
		{
			return null;
		}
		public function toRora():XML
        {
            return null;
        }
	}
}