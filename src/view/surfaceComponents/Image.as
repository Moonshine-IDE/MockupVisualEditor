package view.surfaceComponents
{
	import spark.components.Image;

	import view.ISurfaceComponent;

	public class Image extends spark.components.Image implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "image";

		public function Image()
		{
			this.width = 100;
			this.height = 100;
			this.minWidth = 20;
			this.minHeight = 20;
		}

		public function get propertyEditorClass():Class
		{
			return null;
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}
	}
}
