package view.primeFaces.surfaceComponents.components
{
	import view.interfaces.IPrimeFacesSurfaceComponent;	
	import view.interfaces.IMainApplication;
	import view.interfaces.INonDeletableSurfaceComponent;
	import view.primeFaces.propertyEditors.WindowPropertyEditor;
	import mx.core.IVisualElementContainer;
	import spark.components.HGroup;
	import spark.components.BorderContainer;
	import spark.layouts.HorizontalLayout;

	public class MainApplication extends BorderContainer implements IPrimeFacesSurfaceComponent, 
															INonDeletableSurfaceComponent, IMainApplication, IVisualElementContainer
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
		public static const ELEMENT_NAME:String = "MainApplication";
		
		public function MainApplication()
		{
			super();
			
			_propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];

			var hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 0;
			
			layout = hLayout;
			setStyle("borderColor", "#FF0004");
		}

		public function get propertyEditorClass():Class
		{
			return WindowPropertyEditor;
		}
		
		private var _title:String;
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
		
		private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME+ "/>");
			
			setCommonXMLAttributes(xml);
			
			var elementCount:int = this.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
				if(element === null)
				{
					continue;
				}
				xml.appendChild(element.toXML());
			}
			return xml;
		}
		
		public function toCode():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
			
            setCommonXMLAttributes(xml);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

                xml.appendChild(element.toCode());
            }

            return xml;
		}
		
		public function fromXML(xml:XML, callback:Function):void
		{
			this.width = xml.@width;
			this.height = xml.@height;
			var elementsXML:XMLList = xml.elements();
			var childCount:int = elementsXML.length();
			for(var i:int = 0; i < childCount; i++)
			{
				var childXML:XML = elementsXML[i];
				callback(this, childXML);
			}
		}
		
		private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@width = this.width;
            xml.@height = this.height;
		}
	}
}