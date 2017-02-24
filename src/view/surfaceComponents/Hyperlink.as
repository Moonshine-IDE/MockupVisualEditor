package view.surfaceComponents
{
	import flash.events.Event;

	import spark.components.Label;

	import view.ISurfaceComponent;
	import view.propertyEditors.HyperlinkPropertyEditor;

	public class Hyperlink extends Label implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "hyperlink";

		public function Hyperlink()
		{
			this.text = "Hyperlink";
			this.width = 60;
			this.height = 15;
			this.minWidth = 10;
			this.minHeight = 10;
		}

		public function get propertyEditorClass():Class
		{
			return HyperlinkPropertyEditor;
		}

		private var _url:String = "http://www.example.com/";

		[Bindable("urlChange")]
		public function get url():String
		{
			return this._url;
		}

		public function set url(value:String):void
		{
			if(this._url === value)
			{
				return;
			}
			this._url = value;
			this.dispatchEvent(new Event("urlChange"));
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			xml.@text = this.text;
			xml.@url = this.url;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.text = xml.@text;
			this.url = xml.@url;
		}
	}
}
