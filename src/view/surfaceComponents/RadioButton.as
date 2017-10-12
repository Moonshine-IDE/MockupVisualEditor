package view.surfaceComponents
{
	import spark.components.RadioButton;

	import view.ISurfaceComponent;
	import view.propertyEditors.RadioButtonPropertyEditor;

	public class RadioButton extends spark.components.RadioButton implements ISurfaceComponent
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
		}

		public function get propertyEditorClass():Class
		{
			return RadioButtonPropertyEditor;
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
			this.selected = xml.@selected === "true";
			this.groupName = xml.@groupName;
		}

		override protected function buttonReleased():void
		{
			//we don't want the selection to change on the editing surface
		}

        public function toMXML():XML
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
