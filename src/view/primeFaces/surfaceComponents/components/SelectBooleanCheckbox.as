package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.CheckBox;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.CheckboxPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.CheckboxSkin;

    public class SelectBooleanCheckbox extends CheckBox implements IPrimeFacesSurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectBooleanCheckbox";
		public static const ELEMENT_NAME:String = "selectBooleanCheckbox";
		
		public function SelectBooleanCheckbox()
		{
			super();

            this.setStyle("skinClass", CheckboxSkin);

			this.selected = true;
			this.label = "Checkbox";
			this.toolTip = "";
			this.width = 94;
			this.height = 20;
			this.minWidth = 20;
			this.minHeight = 20;
			this.mouseChildren = false;
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged",
					"contentChange",
					"selectedChanged"
			];
		}
		
		override public function set selected(value:Boolean):void
		{
			if (super.selected != value)
			{
				super.selected = value;
				dispatchEvent(new Event("selectedChanged"));
			}
		}
		
		override protected function buttonReleased():void
		{
			//we don't want the selection to change on the editing surface
		}

        public function get propertyEditorClass():Class
		{
			return CheckboxPropertyEditor;
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

			xml.@label = this.label;
			xml.@selected = this.selected;

			return xml;
		}

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.label = xml.@label;
            this.selected = xml.@selected == "true" ? true : false;
        }

		public function toCode():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

			xml.@value = this.selected;
			if (this.label && this.label != "") xml.@itemLabel = this.label;

			return xml;
		}
	}
}