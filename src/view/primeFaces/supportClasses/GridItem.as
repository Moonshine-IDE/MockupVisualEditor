package view.primeFaces.supportClasses
{
    import interfaces.IComponent;
    import mx.containers.GridItem;

	public class GridItem extends mx.containers.GridItem implements IComponent
	{
		public function GridItem()
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