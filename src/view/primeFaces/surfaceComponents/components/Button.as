package view.primeFaces.surfaceComponents.components
{
	import spark.components.Button;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
	import view.primeFaces.propertyEditors.ButtonPropertyEditor;

	public class Button extends spark.components.Button implements IPrimeFacesSurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
		public static const ELEMENT_NAME:String = "button";
		
		public function Button()
		{
			super();
			
			this.label = "Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged"
			];
		}
		
		public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}		
		
		private var _propertiesChangedEvents:Array;
		public function get propertiesChangedEvents():Array
		{
			return _propertiesChangedEvents;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
			setCommonXMLAttributes(xml);

            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}		
		
		public function toCode():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);
            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}		
		
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			if ("@width" in xml)
			{
                this.width = xml.@width;
			}
			else if ("@percentWidth" in xml)
			{
				this.percentWidth = xml.@percentWidth;
			}

			if ("@height" in xml)
			{
				this.height = xml.@height;
			}
            else if ("@percentHeight" in xml)
            {
                this.percentHeight = xml.@percentHeight;
            }

			this.label = xml.@value;
			this.toolTip = xml.@title;
		}
		
		private function setCommonXMLAttributes(xml:XML):void
		{
			if (!isNaN(this.percentWidth))
			{
				xml.@percentWidth = this.percentWidth;
			}
			else if (!isNaN(this.width))
            {
                xml.@width = this.width;
            }

			if (!isNaN(this.percentHeight))
			{
                xml.@percentHeight = this.percentHeight;
			}
			else if (!isNaN(this.height))
            {
                xml.@height = this.height;
            }
		}
	}
}