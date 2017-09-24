package view.surfaceComponents
{
	import spark.components.Image;

	import view.ISurfaceComponent;

	public class Image extends spark.components.Image implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Image";
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
			
			setCommonXMLAttributes(xml);
			
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

            return xml;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
		}
    }
}
