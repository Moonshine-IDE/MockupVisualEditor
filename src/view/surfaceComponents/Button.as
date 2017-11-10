package view.surfaceComponents
{
	import spark.components.Button;

	import view.ISurfaceComponent;
	import view.propertyEditors.ButtonPropertyEditor;

	public class Button extends spark.components.Button implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Button";
		public static const ELEMENT_NAME:String = "button";
		
		public function Button()
		{
			this.label = "Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			
			_propertiesChangedEvents = [
					"xChanged",
					"yChanged",
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged"
			];
		}

		public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}

		private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            setCommonXMLAttributes(xml);

			xml.@text = this.label;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.label = xml.@text;
		}

		public function toMXML():XML
		{
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

			setCommonXMLAttributes(xml);

            xml.@label = this.label;

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
