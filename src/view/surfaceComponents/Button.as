package view.surfaceComponents
{
	import spark.components.Button;

	import view.ISurfaceComponent;
	import view.propertyEditors.ButtonPropertyEditor;

	public class Button extends spark.components.Button implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "button";

		public function Button()
		{
			this.label = "Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
		}

		public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
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
	}
}
