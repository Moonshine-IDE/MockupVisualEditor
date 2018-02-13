package view.flex.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.RadioButton;

    import view.interfaces.IFlexSurfaceComponent;

	import view.flex.propertyEditors.RadioButtonPropertyEditor;

	public class RadioButton extends spark.components.RadioButton implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "RadioButton";
		public static const ELEMENT_NAME:String = "radiobutton";

		public function RadioButton()
		{
			this.label = "Radio Button";
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
                "explicitMinHeightChanged",
                "contentChange",
                "selectedChanged",
                "groupNameChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return RadioButtonPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override public function set selected(value:Boolean):void
        {
            if (super.selected != value)
            {
                dispatchEvent(new Event("selectedChanged"));
            }

            super.selected = value;
        }

        override public function set groupName(value:String):void
        {
            if (super.groupName != value)
            {
                dispatchEvent(new Event("groupNameChanged"));
            }

            super.groupName = value;
        }

        override protected function buttonReleased():void
		{
			//we don't want the selection to change on the editing surface
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
            xml.@text = this.label;
            setCommonXMLAttributes(xml);

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
            this.groupName = xml.@groupName;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            xml.@label = this.label;
            setCommonXMLAttributes(xml);

            return xml;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@selected = this.selected;
            xml.@groupName = this.groupName;
		}
    }
}
