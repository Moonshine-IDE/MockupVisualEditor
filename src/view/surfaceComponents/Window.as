package view.surfaceComponents
{
    import flash.events.Event;

    import spark.components.Panel;

	import view.ISurfaceComponent;
	import view.propertyEditors.WindowPropertyEditor;

	public class Window extends Panel implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Panel";
		public static const ELEMENT_NAME:String = "window";

		public function Window()
		{
			this.title = "Window";
			this.width = 200;
			this.height = 200;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"titleChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return WindowPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override public function set title(value:String):void
        {
			if (super.title != value)
			{
				 dispatchEvent(new Event("titleChanged"));
			}
            super.title = value;
        }

        public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			var elementCount:int = this.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = this.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
				xml.appendChild(element.toXML());
			}
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.title = xml.@title;
			var elementsXML:XMLList = xml.elements();
			var childCount:int = elementsXML.length();
			for(var i:int = 0; i < childCount; i++)
			{
				var childXML:XML = elementsXML[i];
				callback(this, childXML);
			}
		}

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:ISurfaceComponent = this.getElementAt(i) as ISurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                CONFIG::MOONSHINE
                {
                    xml.appendChild(element.toMXML());
                }
            }

            return xml;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@title = this.title;
		}
    }
}
