package view.primeFaces.supportClasses
{
    import interfaces.IComponent;
	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.containers.GridItem;

	public class GridItem extends mx.containers.GridItem implements IComponent
	{
		public static const ELEMENT_NAME:String = "GridItem";
		
		public function GridItem()
		{
			super();
		}
		
		public function fromXML(xml:XML, childFromXMLCallback:Function, surface:ISurface, lookup:ILookup):void
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