package view.surfaceComponents
{
	import spark.components.TextInput;

	import view.ISurfaceComponent;
	import view.propertyEditors.InputPropertyEditor;

	public class Input extends spark.components.TextInput implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "input";

		public function Input()
		{
			this.editable = false;
			this.selectable = false;
			this.text = "Text Input|";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
		}

		public function get propertyEditorClass():Class
		{
			return InputPropertyEditor;
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
