package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.Button;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
	import view.primeFaces.propertyEditors.ButtonPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.ButtonSkin;

    public class Button extends spark.components.Button implements IPrimeFacesSurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
		public static const ELEMENT_NAME:String = "button";
		
		public function Button()
		{
			super();

            this.setStyle("skinClass", ButtonSkin);

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
					"explicitMinHeightChanged",
					"enabledChanged"
			];
		}

        private var _enabled:Boolean = true;

        [Bindable("enabledChanged")]
        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        override public function get enabled():Boolean
        {
            return _enabled;
        }


        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        override public function set enabled(value:Boolean):void
        {
			if (_enabled != value)
            {
                _enabled = value;

                invalidateSkinState();

				dispatchEvent(new Event("enabledChanged"));
            }
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

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.enabled = xml.@disabled == "false" ? true : false;
            this.label = xml.@value;
            this.toolTip = xml.@title;
        }

		public function toCode():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}
	}
}