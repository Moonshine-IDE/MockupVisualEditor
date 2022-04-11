package view.primeFaces.supportClasses
{
    import interfaces.IComponent;
	import interfaces.ILookup;

	import mx.containers.GridRow;
	
	public class GridRow extends mx.containers.GridRow implements IComponent
	{
		public static const ELEMENT_NAME:String = "GridRow";
		
		public function GridRow()
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