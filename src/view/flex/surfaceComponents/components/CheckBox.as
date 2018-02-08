package view.flex.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.CheckBox;

	import view.interfaces.ISurfaceComponent;
	import view.flex.propertyEditors.CheckBoxPropertyEditor;

	public class CheckBox extends spark.components.CheckBox implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "CheckBox";
		public static const ELEMENT_NAME:String = "checkbox";

		public function CheckBox()
		{
			this.label = "Check Box";
			this.toolTip = "";
			this.width = 90;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "contentChange",
				"selectedChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return CheckBoxPropertyEditor;
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
			this.selected = xml.@selected == "true";
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

        override public function set selected(value:Boolean):void
        {
			if (super.selected != value)
			{
				dispatchEvent(new Event("selectedChanged"));
			}

            super.selected = value;
        }

        override protected function buttonReleased():void
        {
            //we don't want the selection to change on the editing surface
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@selected = this.selected;
		}
    }
}
