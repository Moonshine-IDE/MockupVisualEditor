package view.surfaceComponents
{
	import mx.controls.DateChooser;

	import view.ISurfaceComponent;
	import view.propertyEditors.CalendarPropertyEditor;

	public class Calendar extends DateChooser implements ISurfaceComponent
	{
		public static const ELEMENT_NAME:String = "calendar";

		public function Calendar()
		{
			this.mouseChildren = false;
			this.width = 200;
			this.height = 200;
			this.minWidth = 150;
			this.minHeight = 150;
		}

		public function get propertyEditorClass():Class
		{
			return CalendarPropertyEditor;
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			if(this.selectedDate !== null)
			{
				xml.@date = this.selectedDate.toUTCString();
			}
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			if("@date" in xml)
			{
				this.selectedDate = new Date(xml.@date);
			}
		}
	}
}
