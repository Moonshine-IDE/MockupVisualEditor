package view.flex.surfaceComponents.components
{
    import flash.events.Event;

    import mx.controls.DateChooser;
    import mx.formatters.DateFormatter;
    import mx.utils.ObjectUtil;

    import view.interfaces.ISurfaceComponent;
	import view.flex.propertyEditors.CalendarPropertyEditor;

	public class Calendar extends DateChooser implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DateChooser";
		public static const ELEMENT_NAME:String = "calendar";

		public function Calendar()
		{
			this.mouseChildren = false;
			this.width = 200;
			this.height = 200;
			this.minWidth = 150;
			this.minHeight = 150;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"selectedDateChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return CalendarPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override public function set selectedDate(value:Date):void
        {
			if (ObjectUtil.dateCompare(super.selectedDate, value) != 0)
			{
				dispatchEvent(new Event("selectedDateChanged"));
			}

            super.selectedDate = value;
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
			if("@date" in xml)
			{
				this.selectedDate = DateFormatter.parseDateString(xml.@date);
			}
		}

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var mxNamespace:Namespace = new Namespace("mx", "library://ns.adobe.com/flex/mx");
            xml.addNamespace(mxNamespace);
            xml.setNamespace(mxNamespace);

            setCommonXMLAttributes(xml);

            return xml;
        }

		private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            if(this.selectedDate !== null)
            {
                xml.@date = this.selectedDate.toDateString();
            }
		}
    }
}
