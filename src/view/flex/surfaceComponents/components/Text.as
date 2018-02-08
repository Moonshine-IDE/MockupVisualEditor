package view.flex.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.Label;

    import view.interfaces.IFlexSurfaceComponent;

	import view.flex.propertyEditors.TextPropertyEditor;

	public class Text extends Label implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Label";
		public static const ELEMENT_NAME:String = "text";

		public function Text()
		{
			this.text = "This is some text";
			this.toolTip = "";
			this.percentWidth = 100;
			this.height = 15;
			this.minWidth = 10;
			this.minHeight = 10;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"textChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return TextPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override public function set text(value:String):void
        {
			if (super.text != value)
			{
				dispatchEvent(new Event("textChanged"));
			}

            super.text = value;
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
			this.text = xml.@text;
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
            xml.@text = this.text;
		}
    }
}
