package view.surfaceComponents
{
	import spark.components.Label;

	import view.ISurfaceComponent;
	import view.propertyEditors.TextPropertyEditor;

	public class Text extends Label implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "text";

		public function Text()
		{
			this.text = "This is some text";
			this.toolTip = "";
			this.width = 100;
			this.height = 15;
			this.minWidth = 10;
			this.minHeight = 10;
		}

		public function get propertyEditorClass():Class
		{
			return TextPropertyEditor;
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			xml.@text = this.text;
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
	}
}
